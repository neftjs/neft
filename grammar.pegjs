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
		return Math.random().toString(16).slice(2);
	}

	function setParentRec(arr, val){
		for (var i = 0; i < arr.length; i++){
			var elem = arr[i];
			if (elem.type && !elem.parent){
				elem.parent = val;
				if (elem.body){
					setParentRec(elem.body, val);
				} else if (Array.isArray(elem.value)){
					setParentRec(elem.value, val);
				}
			}
		}
	}
}

Start
	= (Code / Type)*

/* HELPERS */

SourceCharacter
	= .

Letter
	= [a-zA-Z_$]

Word
	= $[a-zA-Z0-9_$]+

Variable
	= $(Letter Word?)

Reference
	= $(Variable ("." Variable)+)

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

HexDigit
	= [0-9a-f]i

DecimalDigit
	= [0-9]

SingleEscapeCharacter
	= "'"
	/ '"'
	/ "\\"
	/ "b"  { return "\b";   }
	/ "f"  { return "\f";   }
	/ "n"  { return "\n";   }
	/ "r"  { return "\r";   }
	/ "t"  { return "\t";   }
	/ "v"  { return "\x0B"; }   // IE does not recognize "\v".

NonEscapeCharacter
  = !(EscapeCharacter / LineTerminator) SourceCharacter { return text(); }

EscapeCharacter
	= SingleEscapeCharacter
	/ DecimalDigit
	/ "x"
	/ "u"

Comment "comment"
	= MultiLineComment
	/ SingleLineComment

MultiLineComment
	= WhiteSpace* "/*" (!"*/" SourceCharacter)* "*/"

SingleLineComment
	= WhiteSpace* "//" (!LineTerminator SourceCharacter)*

StringLiteral "string"
	= '"' chars:$DoubleStringCharacter* '"' {
		return chars;
	}
	/ "'" chars:$SingleStringCharacter* "'" {
		return chars;
	}

DoubleStringCharacter
	= !('"' / "\\" / LineTerminator) SourceCharacter { return text(); }
	/ "\\" sequence:EscapeSequence { return sequence; }
	/ LineContinuation

SingleStringCharacter
	= !("'" / "\\" / LineTerminator) SourceCharacter { return text(); }
	/ "\\" sequence:EscapeSequence { return sequence; }
	/ LineContinuation

LineContinuation
  = "\\" LineTerminatorSequence { return ""; }

EscapeSequence
	= CharacterEscapeSequence
	/ "0" !DecimalDigit { return "\0"; }
	/ HexEscapeSequence
	/ UnicodeEscapeSequence

CharacterEscapeSequence
	= SingleEscapeCharacter
	/ NonEscapeCharacter

HexEscapeSequence
	= "x" digits:$(HexDigit HexDigit) {
		return String.fromCharCode(parseInt(digits, 16));
	}

UnicodeEscapeSequence
	= "u" digits:$(HexDigit HexDigit HexDigit HexDigit) {
		return String.fromCharCode(parseInt(digits, 16));
	}

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
	/ "{" d:(__ d:Attribute __ { return d })* "}" AttributeEnds { return d }
	/ "[" d:Type* "]" AttributeEnds { return d }
	/ d:$StringLiteral AttributeEnds { return d }
	/ value:(!AttributeEnds d:($StringLiteral/SourceCharacter) {return d})+ AttributeEnds {
		return value.join('').trim()
	}

AttributeDeclaration
	= name:AttributeName ":" WhiteSpace* {return name}

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
		if (name.indexOf('$.') !== 0) { error('Properties can be created only in the \'$\' object. Use \'property $.'+name+'\' instead'); }
		var obj = { type: 'property', name: name.slice(2) };
		return typeof attribute === 'string' ? obj : [obj, attribute];
	}

/* SIGNAL */

SignalToken
	= "signal"

Signal "signal"
	= SignalToken WhiteSpace name:(Reference / Variable) AttributeEnds {
		if (name.indexOf('$.') !== 0) { error('Signals can be created only in the \'$\' object. Use \'signal $.'+name+'\' instead'); }
		return { type: 'signal', name: name.slice(2) };
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
	= "(" first:Variable? rest:(WhiteSpace* "," WhiteSpace* d:Variable { return d })* ")" {
		return flattenArray([first, rest])
	}

FunctionName
	= (Variable ".")* "on" Variable

Function "function"
	= name:$FunctionName ":" WhiteSpace* "function" WhiteSpace* params:FunctionParams WhiteSpace* "{" body:$FunctionBody "}" AttributeEnds {
		return { type: 'function', name: name, params: params, body: body };
	}

/* DECLARATION */

Declaration
	= __ d:(Function / Id / Attribute / Property / Signal / Type) {
		return d
	}

Declarations
	= d:(Declaration / Code)* { return flattenArray(d) }

/* TYPE */

TypeNameRest
	= "." ("/"? Variable)+
	/ "['" (("." / "/")? Variable)+ "']"
	/ "[\"" (("." / "/")? Variable)+ "\"]"

TypeName "type name"
	= d:$(Variable TypeNameRest?) {
		if (d.indexOf('/') !== -1 && d.indexOf('[') === -1){
			return d.replace(/\.([a-zA-Z0-9_/]+)$/, "['$1") + "']";
		}
		return d;
	}

TypeBody
	= __ d:Declarations __ { return d }

Type
	= __ name:TypeName WhiteSpace* "{" body:TypeBody "}" __ {
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

		var obj = { type: 'object', name: name, id: id, body: body };

		setParentRec(body, obj);

		return obj;
	}

/* CODE */

CodeBody
	= CodeBodyCode (CodeBodyCode CodeBodyFunc)* CodeBodyCode

CodeBodyCode
	= CodeBodyAny (StringLiteral CodeBodyAny)* CodeBodyAny

CodeBodyAny
	= CodeBodyAnyChar*

CodeBodyAnyChar
	= (!(name:TypeName WhiteSpace* "{")) [a-zA-Z0-9_\-+=!@#$%^&*()~\[\]\\|<>,.?/ \t\n;:]

CodeBodyFunc
	= "{" CodeBody "}"

Code
	= d:$(d:$CodeBody &{return d.trim() ? d : undefined;}) {
		return { type: 'code', body: d }
	}
