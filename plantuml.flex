package de.docksnet.puml;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import de.docksnet.puml.psi.PumlTypes;
import com.intellij.psi.TokenType;

%%

%public
%class _PumlLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}

EOL=\r|\n|\r\n
LINE_WS=[\ \t\f]
WHITE_SPACE=({LINE_WS}|{EOL})+

ALPHA=[:letter:]
DIGIT=[:digit:]

ID_BODY={ALPHA} | {DIGIT} | "_"
ID=({ID_BODY}) *
EXT_ID=({ID_BODY}|{LINE_WS}|\\) *

QUOTE=\"
CHAR={ALPHA} | {DIGIT} | "_" | {LINE_WS}
CHAR2=[^\n\r\f\\\"]
STRING={QUOTE}({CHAR2}|{LINE_WS}|{EOL})*{QUOTE}

%state INSIDE_COLONS
%state INSIDE_PARENTHESIS
%state STEREOTYPE
%%

<YYINITIAL> {
    "@startuml"{LINE_WS}*{EOL} {yybegin(YYINITIAL); return PumlTypes.UML_START; }
    "@enduml"{LINE_WS}*{EOL}? {yybegin(YYINITIAL); return PumlTypes.UML_END; }

    "actor" {yybegin(YYINITIAL); return PumlTypes.ACTOR; }
    "usecase" {yybegin(YYINITIAL); return PumlTypes.USECASE; }
    "as" {yybegin(YYINITIAL); return PumlTypes.AS; }

    ":" {yybegin(INSIDE_COLONS); return PumlTypes.COLON; }
    "(" {yybegin(INSIDE_PARENTHESIS); return PumlTypes.PAR_LEFT; }
    "<<" {yybegin(STEREOTYPE); return PumlTypes.STEREOTYPE_START; }
    "-" {yybegin(YYINITIAL); return PumlTypes.DASH; }
    ">" {yybegin(YYINITIAL); return PumlTypes.ANGLE_BRACKET_RIGHT; }

    {STRING} {yybegin(YYINITIAL); return PumlTypes.MULTI_LINE_STRING; }

     {ID} {yybegin(YYINITIAL); return PumlTypes.ID; }

     {LINE_WS} {yybegin(YYINITIAL); return com.intellij.psi.TokenType.WHITE_SPACE; }
     {EOL} {yybegin(YYINITIAL); return PumlTypes.EOL; }

      [^] {yybegin(YYINITIAL); return com.intellij.psi.TokenType.BAD_CHARACTER; }
}

<INSIDE_COLONS> {
    {EXT_ID} {yybegin(INSIDE_COLONS); return PumlTypes.ID; }
    ":" {yybegin(YYINITIAL); return PumlTypes.EOL; }
    [^] {yybegin(YYINITIAL); return com.intellij.psi.TokenType.BAD_CHARACTER; }
}

<INSIDE_PARENTHESIS> {
    {EXT_ID} {yybegin(INSIDE_PARENTHESIS); return PumlTypes.ID; }
    ")" {yybegin(YYINITIAL); return PumlTypes.PAR_RIGHT; }
    [^] {yybegin(YYINITIAL); return com.intellij.psi.TokenType.BAD_CHARACTER; }
}

<STEREOTYPE> {
    {CHAR}* {yybegin(STEREOTYPE); return PumlTypes.STRING; }
    ">>" {yybegin(YYINITIAL); return PumlTypes.STEREOTYPE_END; }
    [^] {yybegin(YYINITIAL); return com.intellij.psi.TokenType.BAD_CHARACTER; }
}


