%{
#include <stdio.h>
#include "admin-parser.y.h"
%}

%option reentrant
%option noyywrap
%option never-interactive
 /*yyin and yyout set to NULL*/
%option nostdinit
%option nodefault
%option warn
%option case-insensitive
%option prefix="adminyy"

%x COMMENT


%%

[ \t\n]+                    /* ignore whitespace */;
"("                 return TK_LP         ;
")"                 return TK_RP         ;
","                 return TK_COMMA      ;
"<>"        return TK_NE         ;
"!="        return TK_NE         ;
"="             return TK_EQ         ;
"=="        return TK_EQ         ;
">"                 return TK_GT         ;
"<="            return TK_LE         ;
"<"                 return TK_LT         ;
">="            return TK_GE         ;
"*" return TK_STAR;
"@" return TK_AT_SIGN;
":" return TK_COLON;
"[" return TK_LBRACKET;
"]" return TK_RBRACKET;
"." return TK_DOT;

"!" return TK_NOT;
"OR"            return TK_OR         ;
"AND"           return TK_AND        ;
"LIKE"          return TK_LIKE;
"FROM"          return TK_FROM       ;
"DELETE"        return TK_DELETE     ;
"WHERE"             return TK_WHERE      ;
"UPDATE"        return TK_UPDATE     ;
"SET"           return TK_SET        ;
"INTO"          return TK_INTO       ;
"VALUES"        return TK_VALUES     ;
"INSERT"        return TK_INSERT     ;
"SHOW"          return TK_SHOW;
"SELECT" return TK_SELECT;

"TRUE" return TK_TRUE;
"FALSE" return TK_FALSE;
"connectionlist" return TK_CONNECTIONLIST;
"groups" return TK_GROUPS;
"backends" return TK_BACKENDS;
"user_pwd" return TK_USER_PWD;
"app_user_pwd" return TK_APP_USER_PWD;
"allow_ip" return TK_ALLOW_IP;
"conn_details" return TK_CONN_DETAILS;
"version" return TK_VERSION;
"get" return TK_GET;
"user" return TK_USER;
"password" return TK_PASSWORD;
"help" return TK_HELP;
"stats" return TK_STATS;
"config" return TK_CONFIG;
"reset" return TK_RESET;
"reduce_conns" return TK_REDUCE_CONNS;
"add" return TK_ADD;
"master" return TK_MASTER;
"slave" return TK_SLAVE;
"maintain" return TK_MAINTAIN;
"status" return TK_STATUS;
"variables" return TK_VARIABLES;
"conn_num" return TK_CONN_NUM;
"backend_ndx" return TK_BACKEND_NDX;
"cetus" return TK_CETUS;
"create" return TK_CREATE;
"vdb" return TK_VDB;
"using" return TK_USING;
"hash" return TK_HASH;
"range" return TK_RANGE;
"sharded" return TK_SHARDED;
"table" return TK_TABLE;
"shardkey" return TK_SHARDKEY;

[0-9]+                 return TK_INTEGER; /*sign symbol is handled in parser*/

[0-9]*\.[0-9]+([eE][-+]?[0-9]+)? return TK_FLOAT;

[a-zA-Z][a-zA-Z0-9_]*  return TK_ID;

'([^'\\]|\\.|'')*'     return TK_STRING;
\"([^"\\]|\"\"|\\.)*\"   return TK_STRING;
`([^`]|``)*`   return TK_ID;

"/*" { BEGIN(COMMENT); }
<COMMENT>[^*]*
<COMMENT>"*"+[^*/]*
<COMMENT>"*"+"/" { BEGIN(INITIAL); }

"#".*  { /* useless comment */ }
"--"[ \t\n].*  { /* useless comment */ }

.   {printf("### flex: bad input character: 0x%02x\n", yytext[0]);return 0;}