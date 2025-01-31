%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"
int lines;
int radiobuttons=0;
int term(int LABEL){
	printf("%s",yytext);
	return LABEL;
}
%}

%x COMMENTS

%%
"<!--"	{ term(0);}  BEGIN(COMMENTS);
<COMMENTS>[^-\n]* {term(0);}
<COMMENTS>'-'+[^-\n]* {term(0);}
<COMMENTS>\n  {term(0); lines++; }
<COMMENTS>"-->"  {term(0); } BEGIN(INITIAL);
[\n] {term(0); lines++; }
[ \t] term(0);
\"[0-9]+\" {printf("%s", yytext); yylval.number=atoi(yytext+1);  return NUMBER;}
"android:layout_width"	{return term(CMD_ANDROIDWIDTH);}
"android:layout_height"	{return term(CMD_ANDROIDHEIGHT);}
"android:orientation"	{return term(CMD_ANDROIDORIENTATION);}
"android:id"	{return term(CMD_ANDROIDID);}
"android:text"	{return term(CMD_ANDROIDTEXT);}
"android:textColor"	{return term(CMD_ANDROIDTEXTCOLOR);}
"android:src"	{return term(CMD_ANDROIDSRC);}
"android:padding"	{return term(CMD_ANDROIDPADDING);}
"android:checkedButton"	{return term(CMD_ANDROIDCHECKEDBUTTON);}
"android:max"	{return term(CMD_ANDROIDMAX);}
"android:progress"	{return term(CMD_ANDROIDPROGRESS);}
"android:length"	{return term(CMD_ANDROIDLENGTH);}
"<LinearLayout"	{return term(CMD_LINEARLAYOUT);}
"<RelativeLayout"	{return term(CMD_RELATIVELAYOUT);}
"<TextView"	{return term(CMD_TEXTVIEW);}
"<ImageView"	{return term(CMD_IMAGEVIEW);}
"<Button"	{return term(CMD_BUTTON);}
"<RadioGroup"	{return term(CMD_RADIOGROUP);}
"<RadioButton"	{radiobuttons++; return term(CMD_RADIOBUTTON);}
"<ProgressBar"	{return term(CMD_PROGRESSBAR);}
"</LinearLayout>"	{return term(CMD_CLS_LINEARLAYOUT);}
"</RelativeLayout>"	{return term(CMD_CLS_RELATIVELAYOUT);}
"/>"	{return term(CMD_CLS_ENDTASK);}
"</RadioGroup>"	{return term(CMD_CLS_RADIOGROUP);}
"=" {return term('=');}
[0-9a-zA-Z_]* 	{return term(TEXT);}
\"[^'\n]*\" 	{return term(STRING_TEXT); } 
%% 