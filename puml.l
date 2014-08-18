
digit                       [0-9]
id                          [a-zA-Z][a-zA-Z0-9]*

%%
"//".*                      /* ignore comment */
"@startuml"                 {return 'STARTUML';}
"@enduml"                   {return 'ENDUML';}
"actor"                     {return 'ACTOR';}
"usecase"                   {return 'USECASE';}
"as"                        {return 'AS';}
"rectangle"                 {return 'RECT';}
{digit}+                    {return 'NATLITERAL';}
{id}                        {return 'ID';}
"->"                        {return 'RARROW';}
"<-"                        {return 'LARROW';}
"--"                        {return 'LINE';}
".>"                        {return 'RDOTARROW';}
"<."                        {return 'LDOTARROW';}
"!"                         {return 'NOT';}
"."                         {return 'DOT';}
"{"                         {return 'LBRACE';}
"}"                         {return 'RBRACE';}
"("                         {return 'LPAREN';}
")"                         {return 'RPAREN';}
";"                         {return 'SEMICOLON';}
":"                         {return 'COLON';}
\s+                         /* skip whitespace */
"."                         {throw 'Illegal character';}
<<EOF>>                     {return 'EOF';}


