; Variables

(identifier) @variable

(call_expression
  function: (member_expression
    object: (identifier) @type
    (#any-of?
      @type
      "Promise"
      "Array"
      "Object"
      "Map"
      "Set"
      "WeakMap"
      "WeakSet"
      "Date"
      "Error"
      "TypeError"
      "RangeError"
      "SyntaxError"
      "ReferenceError"
      "EvalError"
      "URIError"
      "RegExp"
      "Function"
      "Number"
      "String"
      "Boolean"
      "Symbol"
      "BigInt"
      "Proxy"
      "ArrayBuffer"
      "DataView"
    )
  )
)

; Properties

(property_identifier) @property
(shorthand_property_identifier) @property
(shorthand_property_identifier_pattern) @property
(private_property_identifier) @property

; Function and method calls

(call_expression
  function: (identifier) @function)

(call_expression
  function: (member_expression
    property: [(property_identifier) (private_property_identifier)] @function.method))

; new expressions - constructor is a type
(new_expression
  constructor: (identifier) @type)

(nested_type_identifier
  module: (identifier) @type)

; Function and method definitions

(function_expression
  name: (identifier) @function)
(function_declaration
  name: (identifier) @function)
(method_definition
  name: [(property_identifier) (private_property_identifier)] @function.method)
(method_definition
    name: (property_identifier) @constructor
    (#eq? @constructor "constructor"))

(pair
  key: [(property_identifier) (private_property_identifier)] @function.method
  value: [(function_expression) (arrow_function)])

(assignment_expression
  left: (member_expression
    property: [(property_identifier) (private_property_identifier)] @function.method)
  right: [(function_expression) (arrow_function)])

(variable_declarator
  name: (identifier) @function
  value: [(function_expression) (arrow_function)])

(assignment_expression
  left: (identifier) @function
  right: [(function_expression) (arrow_function)])

; Parameters

(required_parameter
  (identifier) @variable.parameter)

(required_parameter
  (_
    ([
      (identifier)
      (shorthand_property_identifier_pattern)
    ]) @variable.parameter))

(optional_parameter
  (identifier) @variable.parameter)

(optional_parameter
  (_
    ([
      (identifier)
      (shorthand_property_identifier_pattern)
    ]) @variable.parameter))

(catch_clause
  parameter: (identifier) @variable.parameter)

(index_signature
  name: (identifier) @variable.parameter)

(arrow_function
  parameter: (identifier) @variable.parameter)

(type_predicate
  name: (identifier) @variable.parameter)

; instanceof right-hand side is a type
(binary_expression
  operator: "instanceof"
  right: (identifier) @type)

; Special identifiers

(type_annotation) @type
(type_identifier) @type
(predefined_type) @type.builtin

(type_alias_declaration
  (type_identifier) @type)

(type_alias_declaration
  value: (_
    (type_identifier) @type))

(interface_declaration
  (type_identifier) @type)

(enum_declaration
  name: (identifier) @type)

(class_declaration
  (type_identifier) @type.class)

(extends_clause
  value: (identifier) @type.super)

(extends_type_clause
  type: (type_identifier) @type.super)

(implements_clause
  (type_identifier) @type)

([
  (identifier)
  (shorthand_property_identifier)
  (shorthand_property_identifier_pattern)
 ] @constant
 (#match? @constant "^_*[A-Z_][A-Z\\d_]*$"))

; Const declarations - variables declared with const are semantically constants
(lexical_declaration
  kind: "const"
  (variable_declarator
    name: (identifier) @constant))

(lexical_declaration
  kind: "const"
  (variable_declarator
    name: (array_pattern
      (identifier) @constant)))

(lexical_declaration
  kind: "const"
  (variable_declarator
    name: (object_pattern
      (shorthand_property_identifier_pattern) @constant)))

(lexical_declaration
  kind: "const"
  (variable_declarator
    name: (object_pattern
      (pair_pattern
        value: (identifier) @constant))))

; Rest patterns in const object destructuring: const { ...rest } = obj
(lexical_declaration
  kind: "const"
  (variable_declarator
    name: (object_pattern
      (rest_pattern
        (identifier) @constant))))

; Rest patterns in const array destructuring: const [...rest] = arr
(lexical_declaration
  kind: "const"
  (variable_declarator
    name: (array_pattern
      (rest_pattern
        (identifier) @constant))))

(for_in_statement
  "const"
  left: (identifier) @constant)

; UPPER_CASE properties in member expressions are constants (e.g., process.env.GITHUB_TOKEN)
; but NOT object literal keys like { JSON: ".json" }
(member_expression
  property: (property_identifier) @constant
  (#match? @constant "^_*[A-Z_][A-Z\\d_]*$"))

; Literals

(this) @variable.special
(super) @variable.special

[
  (null)
  (undefined)
] @constant.builtin

[
  (true)
  (false)
] @boolean

(comment) @comment

[
  (string)
  (template_string)
  (template_literal_type)
] @string

(escape_sequence) @string.escape

(regex) @string.regex
(regex_flags) @keyword.operator.regex
(number) @number

; Tokens

[
  ";"
  "?."
  "."
  ","
  ":"
  "?"
] @punctuation.delimiter

[
  "-"
  "--"
  "-="
  "+"
  "++"
  "+="
  "*"
  "*="
  "**"
  "**="
  "/"
  "/="
  "%"
  "%="
  "<"
  "<="
  "<<"
  "<<="
  "="
  "=="
  "==="
  "!"
  "!="
  "!=="
  "=>"
  ">"
  ">="
  ">>"
  ">>="
  ">>>"
  ">>>="
  "~"
  "^"
  "&"
  "|"
  "^="
  "&="
  "|="
  "&&"
  "||"
  "??"
  "&&="
  "||="
  "??="
  "..."
] @operator

(regex "/" @string.regex)

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
]  @punctuation.bracket

(ternary_expression
  [
    "?"
    ":"
  ] @operator
)

["await"] @keyword.coroutine

; Modifiers
[
  "abstract"
  "async"
  "override"
  "private"
  "protected"
  "public"
  "readonly"
  "static"
] @keyword.modifier

; Keyword operators
[
  "delete"
  "in"
  "instanceof"
  "is"
  "keyof"
  "new"
  "of"
  "satisfies"
  "typeof"
] @keyword.operator

; Type casting
["as"] @keyword.control

; Module-related
[
  "declare"
  "module"
  "namespace"
] @keyword.module

; Accessors
[
  "get"
  "set"
] @keyword.accessor

; Other keywords
[
  "debugger"
  "default"
  "extends"
  "implements"
  "infer"
  "target"
  "using"
  "void"
  "with"
] @keyword

[
  "const"
  "let"
  "var"
  "function"
  "class"
  "enum"
  "interface"
  "type"
] @keyword.declaration

[
  "export"
  "from"
  "import"
] @keyword.import

[
  "break"
  "case"
  "catch"
  "continue"
  "do"
  "else"
  "finally"
  "for"
  "if"
  "return"
  "switch"
  "throw"
  "try"
  "while"
  "yield"
] @keyword.control

(switch_default "default" @keyword.control)

(template_substitution
  "${" @punctuation.interpolation
  "}" @punctuation.interpolation) @embedded

(template_type
  "${" @punctuation.interpolation
  "}" @punctuation.interpolation) @embedded

(type_arguments
  "<" @punctuation.bracket
  ">" @punctuation.bracket)

(type_parameters
  "<" @punctuation.bracket
  ">" @punctuation.bracket)

(decorator "@" @punctuation.special)

(union_type
  ("|") @punctuation.special)

(intersection_type
  ("&") @punctuation.special)

(type_annotation
  (":") @punctuation.special)

(index_signature
  (":") @punctuation.special)

(type_predicate_annotation
  (":") @punctuation.special)

(public_field_definition
  ("?") @punctuation.special)

(property_signature
  ("?") @punctuation.special)

(method_signature
  ("?") @punctuation.special)

(optional_parameter
  ([
    "?"
    ":"
  ]) @punctuation.special)

(jsx_opening_element
  [
    (identifier) @type
    (member_expression
      object: (identifier) @type
      property: (property_identifier) @type
    )
  ]
)
(jsx_closing_element
  [
    (identifier) @type
    (member_expression
      object: (identifier) @type
      property: (property_identifier) @type
    )
  ]
)
(jsx_self_closing_element
  [
    (identifier) @type
    (member_expression
      object: (identifier) @type
      property: (property_identifier) @type
    )
  ]
)

(jsx_opening_element (identifier) @tag.jsx (#match? @tag.jsx "^[a-z][^.]*$"))
(jsx_closing_element (identifier) @tag.jsx (#match? @tag.jsx "^[a-z][^.]*$"))
(jsx_self_closing_element (identifier) @tag.jsx (#match? @tag.jsx "^[a-z][^.]*$"))

(jsx_attribute (property_identifier) @attribute.jsx)
(jsx_opening_element (["<" ">"]) @punctuation.bracket.jsx)
(jsx_closing_element (["</" ">"]) @punctuation.bracket.jsx)
(jsx_self_closing_element (["<" "/>"]) @punctuation.bracket.jsx)
(jsx_attribute "=" @punctuation.delimiter.jsx)
(jsx_text) @text.jsx

; Ensure new expression constructors are highlighted as types (must be at end to take precedence)
(new_expression
  constructor: (identifier) @type)
