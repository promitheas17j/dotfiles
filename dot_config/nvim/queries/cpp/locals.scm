;; Functions
(function_definition
  declarator: (function_declarator
    declarator: (identifier) @function.name))

;; Global and local variables
(declaration
  type: (_) 
  declarator: (init_declarator
    declarator: (identifier) @variable.name))

;; Arrays
(declaration
  type: (_)
  declarator: (init_declarator
    declarator: (array_declarator
      declarator: (identifier) @variable.name)))

;; Structs
(struct_specifier
  name: (type_identifier) @type.name)

;; Enums
(enum_specifier
  name: (type_identifier) @type.name)
