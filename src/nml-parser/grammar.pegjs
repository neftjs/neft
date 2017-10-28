{
    var RESERVED_ATTRIBUTES = {id: true};

    function warning(msg) {
        var startLocation = location().start;
        options.warnings.push({
            message: msg,
            line: startLocation.line,
            column: startLocation.column
        });
    }

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
}

Start
    = imports:Import* constants:Constant* objects:MainType* {
        return {
            imports: imports,
            constants: constants,
            objects: objects
        };
    }

/* HELPERS */

SourceCharacter
    = .

Letter "letter"
    = [a-zA-Z_$]

Word "word"
    = $[a-zA-Z0-9_$]+

Variable
    = $(Letter Word?)

Reference
    = $(Variable ("." Variable)+)

LineTerminator "line terminator"
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

SingleEscapeCharacter "escape character"
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

StringLiteral "string literal"
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

InlineBrackets
    = '(' (!')' (StringLiteral / InlineBrackets / SourceCharacter))* ')'

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
    / ","
    / LineTerminator
    / Comment

AttributeBody
    = d:Type AttributeEnds? { return d }
    / "{" d:(__ d:Declaration __ { return d })* __ "}" AttributeEnds { return d }
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

PropertyValue
    = Function
    / Attribute
    / d:AttributeName AttributeEnds {return d}

FullProperty
    = PropertyToken WhiteSpace+ value:PropertyValue {
        var name = value.name || value;
        var obj = { type: 'property', name: name };
        return typeof value === 'string' ? obj : [obj, value];
    }

FunctionProperty
    = d:NamedFunction {
        return [
            { type: 'property', name: d.name },
            d
        ];
    }

Property "custom property"
    = FullProperty
    / FunctionProperty

/* SIGNAL */

SignalToken
    = "signal"

SignalValue
    = Function
    / d:AttributeName AttributeEnds {return d}

Signal "custom signal"
    = SignalToken WhiteSpace+ value:SignalValue {
        var name = value.name || value;
        var obj = { type: 'signal', name: name };
        return typeof value === 'string' ? obj : [obj, value];
    }

/* ID */

IdToken
    = "id"

Id "id declaration"
    = IdToken ":" WhiteSpace* value:Variable AttributeEnds {
        if (options.ids[value]) {
            error("Id '" + value + "' is already defined");
        }
        options.ids[value] = true;
        return { type: 'id', value: value };
    }

/* FUNCTION */

FunctionToken
    = "function"

FunctionBody "function brackets"
    = "{" FunctionInnerBody "}"

FunctionInnerBody "function brackets"
    = (!"}" FunctionBodyText)*

FunctionBodyText "function code"
    = StringLiteral / Comment / FunctionBody / SourceCharacter

FunctionParams "function parameters"
    = "(" first:Variable? rest:(WhiteSpace* "," WhiteSpace* d:Variable { return d })* ")" {
        return first ? flattenArray([first, rest]) : [];
    }

FunctionName "function name"
    = (Variable ".")* Variable

Function "function"
    = name:$FunctionName (":" WhiteSpace* FunctionToken)? WhiteSpace* params:FunctionParams WhiteSpace* "{" body:$FunctionInnerBody "}" AttributeEnds {
        return { type: 'function', name: name, params: params, code: body };
    }

/* NAMED FUNCTION */

NamedFunction "function with name"
    = FunctionToken WhiteSpace+ name:$FunctionName WhiteSpace* params:FunctionParams WhiteSpace* "{" body:$FunctionInnerBody "}" AttributeEnds {
        return { type: 'function', name: name, params: params, code: body };
    }

/* ANONYMOUS FUNCTION */

AnonymousFunction "anonymous function"
    = FunctionToken WhiteSpace* params:FunctionParams WhiteSpace* "{" body:$FunctionInnerBody "}" AttributeEnds {
        return { type: 'function', name: '', params: params, code: body };
    }

/* DECLARATION */

Declaration
    = __ d:(Function / Id / Attribute / Property / Signal / Type) {
        return d
    }

Declarations
    = d:(Declaration / ConditionStatement / SelectStatement)* { return flattenArray(d) }

/* TYPE */

TypeNameRest
    = "." ("/"? Variable)+
    / "['" (("." / "/")? Variable)+ "']"
    / "[\"" (("." / "/")? Variable)+ "\"]"

TypeName "renderer type name"
    = d:$(Variable TypeNameRest?) {
        if (d.indexOf('/') !== -1 && d.indexOf('[') === -1){
            return d.replace(/\.([a-zA-Z0-9_/]+)$/, "['$1") + "']";
        }
        return d;
    }

TypeBody "renderer type body"
    = __ d:Declarations __ { return d }

Type "renderer type"
    = __ name:TypeName WhiteSpace* "{" body:TypeBody "}" __ {
        var obj = { type: 'object', name: name, id: '', body: body };

        forEachType(body, "id", function(elem){
            if (obj.id){
                error("item can has only one id");
            }
            obj.id = elem.value;
        });

        if (!obj.id) {
            obj.id = "_i" + options.lastUid++;
        }

        return obj;
    }

MainType
    = Type

/* CONDITION STATEMENT */

ConditionToken
    = "if"

ConditionStatement "condition statement"
    = __ ConditionToken WhiteSpace* "(" WhiteSpace* cond:$(!")" d:($StringLiteral/$InlineBrackets/SourceCharacter) {return d})+ WhiteSpace* ")" WhiteSpace* "{" body:TypeBody "}" __ {
        return { type: 'condition', condition: cond, body: body };
    }

/* SELECT STATEMENT */

SelectToken
    = "select"
    / "for"

SelectStatement "select statement"
    = __ type:SelectToken WhiteSpace* "(" WhiteSpace* cond:$(!")" d:($StringLiteral) {return d})+ WhiteSpace* ")" WhiteSpace* "{" body:TypeBody "}" __ {
        if (type === "for") {
            warning("'for' statement has been renamed to 'select'");
        }
        return { type: 'select', query: cond, body: body };
    }

/* IMPORT */

ImportToken
    = "import"

Import "import statement"
    = __ ImportToken WhiteSpace+ path:Reference WhiteSpace* AttributeEnds* __ {
        return path.split('.');
    }

/* CONSTANT */

ConstantToken
    = "const"

ConstantValue "constant value"
    = $NamedFunction
    / $AnonymousFunction
    / $StringLiteral
    / $FunctionBody
    / d:$(!AttributeEnds SourceCharacter)+ AttributeEnds {return d}

Constant "constant value"
    = __ ConstantToken WhiteSpace+ name:Variable WhiteSpace+ "=" WhiteSpace+ value:ConstantValue AttributeEnds? __ {
        return {
            name: name,
            value: value
        };
    }
