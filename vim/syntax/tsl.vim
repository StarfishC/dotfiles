vim9script

# Vim9 syntax file for TSL language
if exists("b:current_syntax")
  finish
endif

var cpo_save = &cpo
set cpo&vim

syn case ignore

# Keywords
# 程序结构声明
syn keyword tslProgramStructure program function procedure nextgroup=tslFuncName skipwhite
syn keyword tslModuleStructure unit uses implementation interface initialization finalization

# 数据类型
syn keyword tslPrimitiveType string integer boolean int64 real array

# 类型系统和面向对象
syn keyword tslClassType type class fakeclass new
syn keyword tslClassModifier override overload virtual property inherited self
syn keyword tslAccessModifier public protected private published
syn keyword tslConstructor create destroy operator
syn keyword tslReferenceModifier weakref autoref
syn keyword tslPropertyAccessor read write

# 变量和常量修饰符
syn keyword tslVariableModifier external const out var
syn keyword tslScopeModifier global static

# 控制流
syn keyword tslConditional if else then case of
syn keyword tslLoop for while do downto step until repeat to
syn keyword tslBranch break continue goto label exit
syn keyword tslReturn return debugreturn debugrunenv debugrunenvdo

# 程序块结构
syn keyword tslBlock begin end with
syn keyword tslNamespace namespace

# 异常处理
syn keyword tslException except raise try finally exceptobject
# 运算符
syn keyword tslLogicOperator and in is not or
syn keyword tslArithmOperator div mod
syn keyword tslBitwiseOperator ror rol shr shl
syn keyword tslSetOperator union minus union2
# SQL相关关键字
syn keyword tslSqlCommand select vselect sselect update delete mselect
syn keyword tslSqlClause sqlin from where group by order distinct join
syn keyword tslSqlOperator like on set
# 系统相关
syn keyword tslSystemKeyword setuid sudo
syn keyword tslCallingConvention cdecl pascal stdcall safecall fastcall register
# 内置变量
syn keyword tslBuiltinVar paramcount realparamcount params
syn keyword tslBuiltinVar system tslassigning
syn keyword tslBuiltinVar likeeps likeepsrate
# 内置函数
syn keyword tslBuiltinFunction echo mtic mtoc

# 常量
syn keyword tslBoolean false true
syn keyword tslNull nil
syn keyword tslMathConstant inf nan

# todo
syn keyword tslTodo FIXME NOTE NOTES TODO XXX contained

# Function definitions
syn match tslFuncName        '\%(\h\w*\.\)\?\h\w*' contained nextgroup=tslFuncParams skipwhite contains=tslTypeNameInFunc,tslDotInFunc
syn match tslTypeNameInFunc  '\h\w*\ze\.\h\w*' contained
syn match tslDotInFunc       '\.' contained
syn match tslFuncName        '\.\@<=\h\w*' contained

syn region tslFuncParams
    \ matchgroup=Delimiter
    \ start='('
    \ end=')'
    \ contained
    \ contains=tslParam,tslParamType,tslParamSep,tslNumber,tslString,tslPropertyChain
    \ nextgroup=tslReturnType skipwhite

syn match tslParam          '\h\w*' contained nextgroup=tslParamType skipnl skipwhite
syn match tslParamType      ':\s*[^;,)=]*' contained contains=tslColon
syn match tslReturnType     ':\s*[^;]*' contained contains=tslColon
syn match tslParamSep       '[;,]' contained
syn match tslColon          ':' contained

# property chain
syn match tslPropertyChain  '\h\w*\%(\.\h\w*\)\+\>' contains=tslObjectName,tslPropertyDot,tslPropertyName
syn match tslObjectName     '\h\w*\ze\.\h\w*' contained
syn match tslPropertyDot    '\.' contained
syn match tslPropertyName   '\.\@<=\h\w*\%(\ze\.\|\ze\s*[^(]\|\ze\s*$\)' contained

# Function calls
syn match tslFuncCallName   '\%(\<\%(function\|procedure\)\s\+\%(\h\w*\.\)\?\)\@<!\h\w*\ze\s*('
    \ containedin=ALLBUT,tslFuncParams,tslPropertyChain,tslFunction,tslFuncName,tslFuncNamePart,tslComment,tslString,tslRawString

syn region tslFuncCall
    \ start='\h\w*\s*(\zs'
    \ end='\ze)'
    \ contains=tslFuncCallName,tslFuncCall,tslNamedParam,tslPositionalParam,tslString,tslRawString,tslNumber,tslIdentifier,tslOperator,tslParamSep
    \ transparent

syn match tslNamedParam     '\%((\|;\s*\)\zs\h\w*\s*:\s*[^;,)]*' contained
    \ contains=tslParamName,tslParamColon,tslParamValue

syn match tslParamName      '\h\w*\ze\s*:' contained
syn match tslParamColon     ':' contained
syn match tslParamValue     ':\s*\zs[^;,)]*' contained
    \ contains=tslString,tslNumber,tslIdentifier,tslOperator,tslFuncCall,tslFuncCallName

syn match tslPositionalParam '[^;,():]*' contained
    \ contains=tslString,tslNumber,tslIdentifier,tslOperator,tslFuncCall,tslFuncCallName

# variable declaration
syn match tslVarDeclWithTag '\]\@<=\s*\h\w*'
    \ nextgroup=tslVarTypeDecl skipwhite
    \ contains=tslVarName

syn match tslVarDeclStart   '\%(^\s*\|;\s*\)\zs\h\w*\%(\s*\[\)\@!'
    \ nextgroup=tslVarTypeDecl skipwhite
    \ contains=tslVarName

syn match tslVarName        '\h\w*' contained
syn region tslVarTypeDecl 
    \ matchgroup=tslVarDelimiter start=':\%(=\)\@!' end=';'
    \ contained keepend oneline
    \ contains=tslVarType
syn match tslVarType '[^;]*' contained

# Operators and delimiters
syn match tslOperator       '[+\-*/<>=!&|^~%]'
syn match tslDelimiter      '[()[\]{},;:.@?]'

# Comments
syn match  tslComment '//.*$' contains=tslTodo,@Spell
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
hi def link tslProgramStructure Statement
hi def link tslModuleStructure Statement
hi def link tslPrimitiveType Type
hi def link tslClassType Statement
hi def link tslClassModifier Identifier
hi def link tslAccessModifier Statement
hi def link tslPropertyAccessor Operator
hi def link tslConstructor Special
hi def link tslVariableModifier StorageClass
hi def link tslScopeModifier StorageClass
hi def link tslReferenceModifier StorageClass
hi def link tslConditional Conditional
hi def link tslLoop Repeat
hi def link tslBranch Conditional
hi def link tslReturn Statement
hi def link tslBlock Statement
hi def link tslNamespace Statement
hi def link tslException Exception
hi def link tslLogicOperator Operator
hi def link tslArithmOperator Operator
hi def link tslBitwiseOperator Operator
hi def link tslSetOperator Operator
hi def link tslSqlCommand Keyword
hi def link tslSqlClause Special
hi def link tslSqlOperator Special
hi def link tslSystemKeyword Special
hi def link tslCallingConvention Special
hi def link tslBuiltinVar Constant
hi def link tslBuiltinFunction Constant
hi def link tslBoolean Boolean
hi def link tslNull Constant
hi def link tslMathConstant Number

# 其他元素的高亮链接保持不变
hi def link tslObjectName Type
hi def link tslPropertyDot Operator
hi def link tslPropertyName Special

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

hi def link tslOperator Operator
hi def link tslDelimiter Delimiter
hi def link tslTodo Todo
hi def link tslComment Comment
hi def link tslString String
hi def link tslRawString String
hi def link tslQuotes String
hi def link tslNumber Number

b:current_syntax = "tsl"

&cpo = cpo_save
