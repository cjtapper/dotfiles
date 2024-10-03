; extends

; contextmanager
(with_statement) @contextmanager.outer

(with_statement
   body: (block)? @contextmanager.inner)

(with_item value: (_) @contextmanager.inner)

; docstrings
(module
   . (expression_statement
       (string) @docstring))

(class_definition
   body: (block
       . (expression_statement
         (string) @docstring)))

(function_definition
   body: (block
       . (expression_statement
         (string) @docstring)))
