vim9script

# Vim9 syntax file for TSL language
if exists("b:current_syntax")
  finish
endif

var cpo_save = &cpo
set cpo&vim

syn case ignore

# Keywords
syn keyword tslHeader program function procedure nextgroup=tslFuncName skipwhite
syn keyword tslBuiltinVar paramcount realparamcount params
syn keyword tslBuiltinVar system thisfunction tslassigning
syn keyword tslBuiltinVar likeeps likeepsrate

syn keyword tslConditional else if
syn keyword tslStatement begin end then
syn keyword tslStatement this with exit
syn keyword tslStatement weakref autoref namespace
syn keyword tslInterface unit uses implementation interface initalization finalization
syn keyword tslRepeat for while do downto step until repeat to
syn keyword tslBranch break continue
syn keyword tslReturn return debugreturn debugrunenv debugrunenvdo
syn keyword tslLabel case of goto label

syn keyword tslOperator write read
syn keyword tslOperator union minus union2
syn keyword tslShiftOperator ror rol shr shl
syn keyword tslLogicOperator and in is not or
syn keyword tslArithmOperator div mod

syn keyword tslException except raise try finally exceptobject
syn keyword tslBoolean false true
syn keyword tslNil nil

syn keyword tslType string integer boolean int64 real array
syn keyword tslBuiltins echo mtic mtoc this
syn keyword tslBuiltins inf nan
syn keyword tslBuiltins external const out var

syn keyword tslSql select vselect sselect update delete mselect set
syn keyword tslSqlOperator sqlin from where group by like order

syn keyword tslOther setuid sudo
syn keyword tslCallFunc cdecl pascal stdcall safecall fastcall register
syn keyword tslScope global static
syn keyword tslClass type class fakeclass new
syn keyword tslClassModifier override overload virtual property self inherited
syn keyword tslConstruct create destroy operator
syn keyword tslAccess public protected private published
syn keyword tslTodo FIXME NOTE NOTES TODO XXX contained

# Function definitions
syn match tslFuncName       '\%(\h\w*\.\)\?\h\w*' contained nextgroup=tslFuncParams skipwhite contains=tslTypeNameInFunc,tslDotInFunc,tslFuncNamePart
syn match tslTypeNameInFunc '\h\w*\ze\.\h\w*' contained
syn match tslDotInFunc      '\.' contained
syn match tslFuncName       '\.\@<=\h\w*' contained

syn region tslFuncParams
    \ start='('
    \ end=')'
    \ contained
    \ contains=tslParam,tslParamType,tslParamSep
    \ nextgroup=tslReturnType skipwhite

syn match tslParam          '\h\w*' contained nextgroup=tslParamType skipnl skipwhite
syn match tslParamType      ':\s*[^;,)]*' contained contains=tslColon
syn match tslReturnType     ':\s*[^;]*' contained contains=tslColon
syn match tslParamSep       '[;,]' contained
syn match tslColon          ':' contained

syn match tslVarDecl        '^\s*\h\w*\s*:=\@!\s*[^;?]*;' contains=tslVarName,tslVarType
syn match tslVarName        '^\s*\h\w*\ze\s*:=\@!' contained
syn match tslVarType        ':=\@!\s*[^;?]*' contained contains=tslColon

# 匹配完整的属性链
syn match tslPropertyChain  '\h\w*\%(\.\h\w*\)\+' contains=tslObjectName,tslPropertyDot,tslPropertyName
syn match tslObjectName     '\h\w*\ze\.\h\w*' contained
syn match tslPropertyDot    '\.' contained
syn match tslPropertyName   '\.\@<=\h\w*\%(\ze\.\|\ze\s*[^(]\|\ze\s*$\)' contained

# Function calls
syn match tslFuncCallName   '\%(\<\%(function\|procedure\)\s\+\%(\h\w*\.\)\?\)\@<!\h\w*\ze\s*('
    \ containedin=ALLBUT,tslFuncParams,tslPropertyChain,tslFunction,tslFuncName,tslFuncNamePart

syn region tslFuncCall
    \ start='\%(\<\h\w*\s*(\)'
    \ end=')'
    \ contains=tslCallParams,tslCallSep,tslCallValue,tslCallParam,tslString,tslNumber,tslIdentifier,tslOperator
    \ transparent

syn region tslCallParams
    \ start='\%(\<\h\w*\s*(\)\zs'
    \ end='\ze)'
    \ contained
    \ contains=tslCallParam,tslCallValue,tslCallSep,tslString,tslNumber,tslIdentifier,tslOperator,tslFuncCall

syn match tslCallParam      '\h\w*\ze\s*:' contained
syn match tslCallValue      ':\s*\zs[^;)]*' contained
syn match tslCallValue
    \ ':\s*\zs\\%([^;,)]\+\|.\{-}\%([;,)]\|$\))'
    \ contained
    \ contains=tslString,tslNumber,tslIdentifier,tslOperator,tslFunctionCall
syn match tslCallSep        '[;,]' contained

# Operators and delimiters
syn match tslOperator       '[+\-*/<>=!&|^~%]'
syn match tslOperator       ':='
syn match tslDelimiter      '[()[\]{},;:.@?]'

# Comments
syn match tslComment '//.*$' contains=tslTodo,@Spell
syn region tslComment start='(\*' end='\*)' contains=tslTodo,@Spell keepend
syn region tslComment start='{' end='}' contains=tslTodo,@Spell keepend

# Strings
syn region tslString start=+[uU]\=\z(['"]\)+ end='\z1' skip='\\\\\|\\\z1'
syn region tslRawString start=+[uU]\=[rR]\z(['"]\)+ end='\z1' skip='\\\\\|\\\z1'

# Numbers
syn match tslNumber '\<0[oO]\=\o\+[Ll]\=\>'
syn match tslNumber '\<0[xX]\x\+[Ll]\=\>'
syn match tslNumber '\<0[bB][01]\+[Ll]\=\>'
syn match tslNumber '\<\%([1-9]\d*\|0\)[Ll]\=\>'
syn match tslNumber '\<\d\+[jJ]\>'
syn match tslNumber '\<\d\+[eE][+-]\=\d\+[jJ]\=\>'
syn match tslNumber '\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@='
syn match tslNumber '\%(^\|\W\)\zs\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>'

# Highlight links
hi def link tslClassName Type
hi def link tslDot Operator
hi def link tslPropertyName Special

hi def link tslHeader Statement
hi def link tslFuncName Function
hi def link tslTypeNameInFunc Type
hi def link tslParam Identifier
hi def link tslParamType Type
hi def link tslReturnType Type
hi def link tslParamSep Delimiter
hi def link tslColon Delimiter

hi def link tslVarName Identifier
hi def link tslVarType Type

hi def link tslFuncCallName Function
hi def link tslCallParam Identifier
hi def link tslCallValue Type
hi def link tslCallSep Delimiter

hi def link tslBuiltinVar Constant
hi def link tslConditional Conditional
hi def link tslStatement Statement
hi def link tslInterface Statement
hi def link tslRepeat Repeat
hi def link tslBranch Conditional
hi def link tslReturn Statement
hi def link tslLabel Label
hi def link tslOperator Operator
hi def link tslDelimiter Delimiter
hi def link tslException Exception
hi def link tslBoolean Boolean
hi def link tslNil Constant
hi def link tslBuiltins Constant
hi def link tslShiftOperator Operator
hi def link tslLogicOperator Operator
hi def link tslArithmOperator Operator
hi def link tslSql Keyword
hi def link tslSqlOperator Special
hi def link tslOther Special
hi def link tslScope StorageClass
hi def link tslClass Statement
hi def link tslClassModifier Identifier
hi def link tslConstruct Special
hi def link tslAccess Statement
hi def link tslTodo Todo
hi def link tslComment Comment
hi def link tslString String
hi def link tslRawString String
hi def link tslQuotes String
hi def link tslNumber Number
hi def link tslType Type

b:current_syntax = "tsl"

&cpo = cpo_save
