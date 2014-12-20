{
	var RESERVED_ATTRIBUTES = {id: true};
	var ids = {};

	function forEachType(arr, type, callback){
		for (var i = 0, n = arr.length; i < n; i++){
			if (arr[i].type === type) callback(arr[i], i, arr);
		}
	}

	function flattenArray(arr){
		for (var i = 0, n = arr.length; i < n; i++){
			if (!Array.isArray(arr[i]))
				continue;

			var child = arr[i];

			child.unshift(i, 1);
			arr.splice.apply(arr, child);

			i--;
			n += child.length - 3;
		}

		return arr;
	}

	function extractArray(arr, step){
		for (var i = 0, n = arr.length; i < n; i++){
			arr[i] = arr[i][step];
		}

		return arr;
	}

	function uid(){
		return Math.random().toString(16).slice(2);;
	}

	function typeValueOf(){
		return 'var ' + this.id + ' = new ' + this.name;
	}
}

Start
	= type:Type {return type}

/* HELPERS */

SourceCharacter
	= .

Letter
	= [a-zA-Z_]

Word
	= value:[a-zA-Z0-9_]+ {return value.join('')}

Variable
	= letter:Letter word:Word? {return letter + (word||'');}

Reference
	= Variable ("." Variable)+ {return text()}

LineTerminator
	= [\n\r\u2028\u2029]

LineTerminatorSequence "end of line"
	= "\n"
	/ "\r\n"
	/ "\r"
	/ "\u2028"
	/ "\u2029"

Zs = [\u0020\u00A0\u1680\u2000-\u200A\u202F\u205F\u3000]
WhiteSpace "whitespace"
	= "\t"
	/ "\v"
	/ "\f"
	/ " "
	/ "\u00A0"
	/ "\uFEFF"
	/ Zs

Comment "comment"
	= MultiLineComment
	/ SingleLineComment

MultiLineComment
	= WhiteSpace* "/*" (!"*/" SourceCharacter)* "*/"

SingleLineComment
	= WhiteSpace* "//" (!LineTerminator SourceCharacter)*

StringLiteral "string"
	= '"' chars:DoubleStringCharacter* '"' {
			return chars.join('');
		}
	/ "'" chars:SingleStringCharacter* "'" {
			return chars.join('');
		}

DoubleStringCharacter
	= !('"' / "\\" / LineTerminator) SourceCharacter { return text(); }

SingleStringCharacter
	= !("'" / "\\" / LineTerminator) SourceCharacter { return text(); }

__
	= (WhiteSpace / LineTerminatorSequence / Comment)*

/* ATTRIBUTE */

AttributeName "attribute name"
	= name:(Reference / Variable) {
			if (RESERVED_ATTRIBUTES[name]){
				error(name+" syntax error");
			}
			return name;
		}

AttributeEnds
	= ";"
	/ LineTerminator
	/ Comment

AttributeBody
	= Type
	/ "{" d:(__ d:Attribute __ { return d })* "}" { return d }
	/ "[" d:Type* "]" { return d }
	/ $StringLiteral
	/ value:(!AttributeEnds d:SourceCharacter {return d})+ AttributeEnds {
			return value.join('').trim()
		}

AttributeDeclaration
	= name:AttributeName ":" __ {return name}

Attribute "attribute"
	= name:AttributeDeclaration value:AttributeBody {
			return { type: 'attribute', name: name, value: value };
		}

/* PROPERTY */

PropertyToken
	= "property"

Property "custom property"
	= PropertyToken WhiteSpace attribute:(Attribute / (d:AttributeName AttributeEnds {return d})) {
			var name = attribute.name || attribute;
			var obj = { type: 'property', name: name };
			return typeof attribute === 'string' ? obj : [obj, attribute];
		}

/* SIGNAL */

SignalToken
	= "signal"

Signal "signal"
	= SignalToken WhiteSpace name:(Variable) AttributeEnds {
			return { type: 'signal', name: name };
		}

/* ID */

IdToken
	= "id"

Id "id declaration"
	= IdToken ":" WhiteSpace* value:Variable AttributeEnds {
			if (ids[value]){
				error("this id has been already defined");
			}
			ids[value] = true;
			return { type: 'id', value: value };
		}

/* FUNCTION */

FunctionBody
	= FunctionBodyCode (FunctionBodyCode FunctionBodyFunc)* FunctionBodyCode

FunctionBodyCode
	= FunctionBodyAny (StringLiteral FunctionBodyAny)* FunctionBodyAny

FunctionBodyAny
	= [a-zA-Z0-9_\-+=!@#$%^&*()~\[\]\\|<>,.?/ \t\n;:]*

FunctionBodyFunc
	= "{" FunctionBody "}"

FunctionParams
	= "(" first:Variable? rest:(__ "," __ d:Variable { return d })* ")" {
			return flattenArray([first, rest])
		}

FunctionName
	= (Variable ".")* "on" Variable

Function "function"
	= name:$FunctionName ":" __ params:FunctionParams? __ "{" body:$FunctionBody "}" {
			return { type: 'function', name: name, params: params, body: body };
		}

/* DECLARATION */

Declaration
	= __ d:(Function / Id / Attribute / Property / Signal / Type) {
			return d
		}

Declarations
	= s:Declaration* { return flattenArray(s) }

/* TYPE */

TypeName "type name"
	= letter:[A-Z_] word:Word? {return letter + (word||'')}

TypeBody
	= declarations:Declarations __ {return declarations}

Type
	= __ name:TypeName __ "{" body:TypeBody "}" __ {
			var id;
			forEachType(body, "id", function(elem){
				if (id){
					error("item can has only one id");
				}
				id = elem.value;
			});

			if (!id){
				id = 'a' + uid();
			}

			return { type: 'object', name: name, id: id, body: body };
		}