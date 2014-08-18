
%token ACTOR
%token STARTUML
%token ENDUML
%token USECASE
%token ID
%token EOF
%token RECT
%token RARROW
%token LARROW
%token LBRACE
%token RBRACE

%token LINE
%token RDOTARROW
%token LDOTARROW
%token LPAREN
%token RPAREN 
%token COLON


%ebnf


%%

pumlFile  :   STARTUML (rectangle | actor | usecase )* ENDUML EOF
          ;

rectangle :   RECT ID LBRACE (entry)* RBRACE
          ;

entry     :   ( ID (LINE | RARROW  ) usecase)
          |   ( usecase (LINE | LARROW ) ID)
          |   ( usecase (LDOTARROW | RDOTARROW) usecase) COLON LABEL
          ;

actor     :    ACTOR ID 
          |   ':' ID ':' 
          |   ACTOR ':' ID ':'
          ;

usecase   :   USECASE ID 
          |   LPAREN ID RPAREN 
          |   USECASE LPAREN ID RPAREN
          ;

LABEL : ID ;
