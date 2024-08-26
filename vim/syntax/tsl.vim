" Vim syntax file
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn keyword tslStatement	begin end then
syn keyword tslStatement	return with
syn keyword tslStatement	class function type nextgroup=tslFunction skipwhite
syn keyword tslStatement	this
syn keyword tslStatement        unit uses implementation interface
syn keyword tslAccess           public protected private
syn keyword tslModifier         override overload virtual property
syn keyword tslLabel		case of
syn keyword tslConditional	else if
syn keyword tslRepeat		for while do downto step until repeat
syn keyword tslOperator		and in is not or
syn keyword tslOperator		write read
syn keyword tslOperator		union minus
syn keyword tslException	except raise try
syn keyword tslBoolean          false true
syn keyword tslBranch           break continue
syn keyword tslNil		nil
syn keyword tslType             string integer boolean int64 real tslobj
syn keyword tslSql              from where group by to values
syn keyword tslBuiltins         select vselect sselect update delete thisrowindex
syn keyword tslBuiltins         echo mtic mtoc self this
syn keyword tslBuiltins         inf nan
syn keyword tslBuiltins		new

syn match   tslFunction	"\h\w*" display contained

syn keyword tslTodo		FIXME NOTE NOTES TODO XXX contained
syn match   tslComment	"//.*$" contains=tslTodo,@Spell
syn match   tslFunc     "\w\+\ze\s*("

" Triple-quoted strings can contain doctests.
syn region  tslString matchgroup=tslQuotes
      \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=tslEscape,@Spell
syn region  tslRawString matchgroup=tslQuotes
      \ start=+[uU]\=[rR]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=@Spell

syn match   tslEscape	+\\[abfnrtv'"\\]+ contained
syn match   tslEscape	"\\\o\{1,3}" contained
syn match   tslEscape	"\\x\x\{2}" contained
syn match   tslEscape	"\%(\\u\x\{4}\|\\U\x\{8}\)" contained
" Python allows case-insensitive Unicode IDs: http://www.unicode.org/charts/
syn match   tslEscape	"\\N{\a\+\%(\s\a\+\)*}" contained
syn match   tslEscape	"\\$"

syn match   tslNumber	"\<0[oO]\=\o\+[Ll]\=\>"
syn match   tslNumber	"\<0[xX]\x\+[Ll]\=\>"
syn match   tslNumber	"\<0[bB][01]\+[Ll]\=\>"
syn match   tslNumber	"\<\%([1-9]\d*\|0\)[Ll]\=\>"
syn match   tslNumber	"\<\d\+[jJ]\>"
syn match   tslNumber	"\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
syn match   tslNumber
      \ "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
syn match   tslNumber
      \ "\%(^\|\W\)\zs\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"

" The default highlight links.  Can be overridden later.
hi def link tslStatement	Statement
hi def link tslAccess           Statement
hi def link tslSql              Statement
hi def link tslFunction		Function
hi def link tslFunc             Function
hi def link tslConditional	Conditional
hi def link tslBranch           Conditional
hi def link tslString		String
hi def link tslRawString	String
hi def link tslQuotes		String
hi def link tslType	        Type
hi def link tslModifier         Type
hi def link tslRepeat		Repeat
hi def link tslOperator		Operator
hi def link tslException	Exception
hi def link tslComment		Comment
hi def link tslTodo		Todo
hi def link tslEscape		Special
hi def link tslNumber           Number
hi def link tslLabel            Label
hi def link tslNil              Keyword
hi def link tslBoolean          Boolean
hi def link tslBuiltins         Identifier

let b:current_syntax = "tsl"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 noet:
