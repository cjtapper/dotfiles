; extends

; contextmanager
(with_statement) @contextmanager.outer

(with_statement
   body: (block)? @contextmanager.inner)

(with_item value: (_) @contextmanager.inner)
