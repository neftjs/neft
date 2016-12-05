start =
    features:features? __ returns:type? __ name:name parameters:parameters? textPrefix:__ extend:extend? __ defaults:defaults? __ text:text? __ tags:tags? {
        var publicName = name.name + (text ? textPrefix + text.trimRight() : '');
        if (name.namespace) {
            publicName = name.namespace + '.' + publicName;
        }
        if (parameters) {
            publicName += '()';
        }
        return {
            namespace: name.namespace || '',
            parent: name.parent || '',
            name: publicName,
            returns: returns || '',
            extends: extend || '',
            default: defaults || '',
            features: features,
            parameters: parameters,
            tags: tags
        };
    }

__ =
    $[ ]*

word =
    $[a-zA-Z0-9-|_$/{}]+

text =
    arr:$(d:$[a-zA-Z0-9-|_$:/{}*]+ " "? { return d })+ { return arr }

name =
    namespace:$(word ".")? parent:(d:word "::" { return d })? name:$("**Class**"? __? $(word "."?)+) {
        namespace = namespace.slice(0, -1);
        return {namespace: namespace, parent: parent, name: name};
    }

type =
    "*" d:$name "*" { return d }

types =
    first:type arr:("|" d:type { return d })* {
        arr.push(first);
        return arr;
    }

feature =
    "ReadOnly" { return 'Read Only' }
    / "Hidden" { return 'Not Implemented' }

features =
    first:feature arr:(__ d:feature { return d })* {
        arr.push(first);
        return arr;
    }

parameter =
    types:types __ name:$(word "..."?) defaults:(__ "=" __ "`" d:$(!"`" .)+ "`" { return d })? {
        return {
            types: types,
            name: name,
            defaults: defaults,
            optional: false
        };
    }

parametersList =
    d:parameter ","? __ { return d }

optionalParametersList =
    "[" d:parametersList* "]" {
        for (var i = 0, n = d.length; i < n; i++){
            d[i].optional = true;
        }
        return d
    }

parameters =
    "(" d1:parametersList* ("," __)? d2:optionalParametersList? ("," __)? d3:parametersList* ")" {
        d1.push.apply(d1, d2);
        d1.push.apply(d1, d3);
        return d1;
    }

extend =
    ":" __ d:type { return d }

defaults =
    "=" __ "`" d:$([a-zA-Z0-9'"._\-{}\[\]&#;]+ / type) "`" { return d }

tags =
    arr:(__? d:("@" d:word { return d })+ { return d }) { return arr }
