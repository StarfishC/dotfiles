" Vim syntax file
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn keyword tslStatement	false true
syn keyword tslStatement	break continue begin end then
syn keyword tslStatement	return with
syn keyword tslStatement	class function nextgroup=pythonFunction skipwhite
syn keyword tslLabel		case of
syn keyword tslConditional	else if
syn keyword tslRepeat		for while do
syn keyword tslOperator		and in is not or
syn keyword tslException	except raise try

syn match   tslFunction	"\h\w*" display contained

syn match   tslComment	"//.*$" contains=pythonTodo,@Spell
syn keyword tslTodo		FIXME NOTE NOTES TODO XXX contained

" Triple-quoted strings can contain doctests.
syn region  pythonString matchgroup=pythonQuotes
      \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=pythonEscape,@Spell
syn region  pythonString matchgroup=pythonTripleQuotes
      \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend
      \ contains=pythonEscape,pythonSpaceError,pythonDoctest,@Spell
syn region  pythonRawString matchgroup=pythonQuotes
      \ start=+[uU]\=[rR]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=@Spell
syn region  pythonRawString matchgroup=pythonTripleQuotes
      \ start=+[uU]\=[rR]\z('''\|"""\)+ end="\z1" keepend
      \ contains=pythonSpaceError,pythonDoctest,@Spell

syn match   pythonEscape	+\\[abfnrtv'"\\]+ contained
syn match   pythonEscape	"\\\o\{1,3}" contained
syn match   pythonEscape	"\\x\x\{2}" contained
syn match   pythonEscape	"\%(\\u\x\{4}\|\\U\x\{8}\)" contained
" Python allows case-insensitive Unicode IDs: http://www.unicode.org/charts/
syn match   pythonEscape	"\\N{\a\+\%(\s\a\+\)*}" contained
syn match   pythonEscape	"\\$"

" It is very important to understand all details before changing the
" regular expressions below or their order.
" The word boundaries are *not* the floating-point number boundaries
" because of a possible leading or trailing decimal point.
" The expressions below ensure that all valid number literals are
" highlighted, and invalid number literals are not.  For example,
"
" - a decimal point in '4.' at the end of a line is highlighted,
" - a second dot in 1.0.0 is not highlighted,
" - 08 is not highlighted,
" - 08e0 or 08j are highlighted,
"
" and so on, as specified in the 'Python Language Reference'.
" https://docs.python.org/reference/lexical_analysis.html#numeric-literals
if !exists("python_no_number_highlight")
  " numbers (including longs and complex)
  syn match   pythonNumber	"\<0[oO]\=\o\+[Ll]\=\>"
  syn match   pythonNumber	"\<0[xX]\x\+[Ll]\=\>"
  syn match   pythonNumber	"\<0[bB][01]\+[Ll]\=\>"
  syn match   pythonNumber	"\<\%([1-9]\d*\|0\)[Ll]\=\>"
  syn match   pythonNumber	"\<\d\+[jJ]\>"
  syn match   pythonNumber	"\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
  syn match   pythonNumber
	\ "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
  syn match   pythonNumber
	\ "\%(^\|\W\)\zs\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"
endif

" Sync at the beginning of class, function, or method definition.
syn sync match pythonSync grouphere NONE "^\%(def\|class\)\s\+\h\w*\s*[(:]"

" The default highlight links.  Can be overridden later.
hi def link tslStatement	Statement
hi def link tslConditional	Conditional
hi def link tslRepeat		Repeat
hi def link tslOperator		Operator
hi def link tslException	Exception
hi def link tslFunction		Function
hi def link tslComment		Comment
hi def link tslTodo		Todo
hi def link tslString		String
hi def link tslRawString	String
hi def link tslQuotes		String
hi def link tslTripleQuotes	pythonQuotes
hi def link tslEscape		Special

let b:current_syntax = "tsl"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 noet:
