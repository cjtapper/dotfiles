setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

setlocal colorcolumn=72,80,88

" dense-analysis/ale
let b:ale_fixers = ['black', 'isort']
let b:ale_linters = ['flake8', 'mypy']

" vim-python/python-syntax
let b:python_highlight_all=1
