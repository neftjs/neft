start =
  code:$code? first:literal? arr:($body literal / e:$body {return [e, null]} / e:literal {return [null, e]})* {
    var r = [code, first];
    arr.forEach(function(elem){ r.push.apply(r, elem); });
    return r
  }

literal =
  "${" d:$expr "}" { return d }

body =
  [a-zA-Z0-9_\-+=!@%^&*()~\[\]\\|<>,.?/ \t\n;:'"']+

block =
  "{" expr "}"

blockInExpr =
  "$"? block
  / block

code =
  body? (block)* body?

expr =
  body? (blockInExpr)* body?