" Vim syntax file
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn keyword tslHeader		program function procedure nextgroup=tslClassName skipwhite
syn keyword tslBuiltinVar	paramcount realparamcount params
syn keyword tslBuiltinVar	system thisfunction tslassigning
syn keyword tslConditional	else if
syn keyword tslStatement	begin end then
syn keyword tslStatement	this with exit
syn keyword tslStatement	weakref namespace
syn keyword tslInterface        unit uses implementation interface
syn keyword tslRepeat		for while do downto step until repeat to
syn keyword tslBranch           break continue
syn keyword tslReturn		return debugreturn debugrunenv debugrunenvdo
syn keyword tslLabel		case of goto label
syn keyword tslOperator		write read
syn keyword tslOperator		union minus union2
syn keyword tslException	except raise try finally exceptobject
syn keyword tslBoolean          false true
syn keyword tslNil		nil
syn keyword tslType             string integer boolean int64 real
syn keyword tslBuiltins         echo mtic mtoc this
syn keyword tslBuiltins         inf nan
syn keyword tslBuiltins		external const out var
syn keyword tslShiftOperator	ror rol shr shl
syn keyword tslLogicOperator	and in is not or
syn keyword tslArithmOperator   div mod
syn keyword tslSql		select vselect sselect update delete mselect set
syn keyword tslSqlOperator	sqlin from where group by like
syn keyword tslBuiltinVar	likeeps likeepsrate
syn keyword tslOther		setuid sudo
syn keyword tslCallFunc		cdecl pascal stdcall safecall fastcall register
syn keyword tslScope		global static
syn keyword tslClass		type class fakeclass new
syn keyword tslClassModifier    override overload virtual property self
syn keyword tslConstruct	create destroy operator
syn keyword tslAccess           public protected private published
syn keyword tslTodo		FIXME NOTE NOTES TODO XXX contained

" 类型和类名
syn match   tslClassName  "\h\w*\ze\." display contained
syn match   tslTypeName	  "\h\w\*" display contained
syn match   tslType	  "\([^?:]*[^?: \t]\):\s*\zs[a-zA-Z_][^=;,()\[\]]*\ze[=;)]"

" 操作符和函数调用
syn match   tslDot	  "\.\zs\w\+"
syn match   tslFunc	  "\w\+\ze\s*("

" 注释
syn match   tslComment	  "{.\{-}}" containedin=ALL contains=@NoSpell
syn match   tslComment	  "//.*$" contains=tslTodo,@Spell
syn region  tslComment	  start="(\*" end="\*)"

" 字符串
syn region  tslString	  start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
syn region  tslRawString  start=+[uU]\=[rR]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"

" 数字
syn match   tslNumber	  "\<0[oO]\=\o\+[Ll]\=\>"
syn match   tslNumber	  "\<0[xX]\x\+[Ll]\=\>"
syn match   tslNumber	  "\<0[bB][01]\+[Ll]\=\>"
syn match   tslNumber	  "\<\%([1-9]\d*\|0\)[Ll]\=\>"
syn match   tslNumber	  "\<\d\+[jJ]\>"
syn match   tslNumber	  "\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
syn match   tslNumber	  "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
syn match   tslNumber	  "\%(^\|\W\)\zs\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"

" The default highlight links.  Can be overridden later.
hi def link tslHeader		Statement
hi def link tslBuiltinVar	Identifier
hi def link tslConditional	Conditional
hi def link tslStatement	Statement
hi def link tslInterface	Statement
hi def link tslRepeat		Repeat
hi def link tslBranch		Conditional
hi def link tslReturn		Statement
hi def link tslLabel		Label
hi def link tslOperator		Operator
hi def link tslException	Exception
hi def link tslBoolean		Boolean
hi def link tslNil		Identifier
hi def link tslType		Type
hi def link tslBuiltins         Identifier
hi def link tslShiftOperator	Operator
hi def link tslLogicOperator	Operator
hi def link tslArithmOperator	Operator
hi def link tslSql		Keyword
hi def link tslSqlOperator	Special
hi def link tslBuiltinVar	Special
hi def link tslOther		Special
hi def link tslCallFunc		Special
hi def link tslScope		Statement
hi def link tslClass		Statement
hi def link tslClassModifier	Identifier
hi def link tslConstruct	Special
hi def link tslAccess		Statement
hi def link tslTodo		Todo
hi def link tslMemVar		Constant
hi def link tslMacro		Special
hi def link tslFunc		Function
hi def link tslFuncVar		Constant
hi def link tslComment		Comment
hi def link tslString		String
hi def link tslRawString	String
hi def link tslQuotes		String
hi def link tslNumber           Number
hi def link tslPreProc		PreProc
hi def link tslClassName	Special
hi def link tslDot		Constant
hi def link tslClassName	Special
hi def link tslTypeName		Function

let b:current_syntax = "tsl"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 noet:
