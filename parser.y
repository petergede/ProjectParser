%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	extern FILE *yyin;
	extern char* yytext;
	extern int lines;
	extern int radiobuttons;
	int errors;
	int rbErrors;
	int rButtons;
	int yylex();
	void yyerror(const char *s);
	int checkVal(int, int);
%}

%union{
    int number;
}

%token CMD_ANDROIDWIDTH
%token CMD_ANDROIDHEIGHT
%token CMD_ANDROIDID
%token CMD_ANDROIDORIENTATION
%token CMD_ANDROIDTEXT
%token CMD_ANDROIDTEXTCOLOR
%token CMD_ANDROIDCHECKEDBUTTON
%token CMD_ANDROIDMAX
%token CMD_ANDROIDPROGRESS
%token CMD_ANDROIDSRC
%token CMD_ANDROIDPADDING
%token CMD_ANDROIDLENGTH
%token CMD_LINEARLAYOUT
%token CMD_CLS_LINEARLAYOUT
%token CMD_RELATIVELAYOUT
%token CMD_CLS_RELATIVELAYOUT
%token CMD_RADIOGROUP
%token CMD_CLS_RADIOGROUP
%token CMD_TEXTVIEW
%token CMD_IMAGEVIEW
%token CMD_RADIOBUTTON
%token CMD_BUTTON
%token CMD_PROGRESSBAR
%token CMD_CLS_ENDTASK
%token <number>NUMBER
%token STRING_TEXT  
%token TEXT 


%%

program: linearlayout | relativelayout; 
			 
linearlayout: 	CMD_LINEARLAYOUT linearlayout_body_xml elements CMD_CLS_LINEARLAYOUT | 
				CMD_LINEARLAYOUT linearlayout_body_xml elements CMD_CLS_LINEARLAYOUT elements;

relativelayout: CMD_RELATIVELAYOUT relativelayout_body_xml CMD_CLS_RELATIVELAYOUT | 
				CMD_RELATIVELAYOUT relativelayout_body_xml elements CMD_CLS_RELATIVELAYOUT |
				CMD_RELATIVELAYOUT relativelayout_body_xml CMD_CLS_RELATIVELAYOUT elements | 
				CMD_RELATIVELAYOUT relativelayout_body_xml elements CMD_CLS_RELATIVELAYOUT elements;

elements: program | textview | imageview | button | progressbar | radiogroup | textview elements  | imageview elements  | button elements  | progressbar elements  | radiogroup elements;

textview: CMD_TEXTVIEW textview_body_xml CMD_CLS_ENDTASK;

imageview: CMD_IMAGEVIEW imageview_body_xml CMD_CLS_ENDTASK;

button: CMD_BUTTON button_body_xml CMD_CLS_ENDTASK;

radiogroup: CMD_RADIOGROUP radiogroup_body_xml radiobutton CMD_CLS_RADIOGROUP{
				radiobuttons=0; 
			};

radiobutton: CMD_RADIOBUTTON radiobutton_body_xml CMD_CLS_ENDTASK{
				if( checkVal(rButtons,radiobuttons) == 1 )
					yyerror("ERROR: Too many RadioButton blocks\n");
			}
			| 
			radiobutton CMD_RADIOBUTTON radiobutton_body_xml CMD_CLS_ENDTASK{
				if( checkVal(rButtons,radiobuttons) == 1 )
					yyerror("ERROR: Too many RadioButton blocks\n");
			 };

progressbar: CMD_PROGRESSBAR progressbar_body_xml CMD_CLS_ENDTASK;

main_xml: android_width android_height | android_height android_width;

linearlayout_body_xml:	main_xml | 
						main_xml android_id | 
						main_xml android_orientation | 
						main_xml android_id android_orientation | 
						main_xml android_orientation android_id ;
				
relativelayout_body_xml:	main_xml | 
							main_xml android_id;

textview_body_xml:  main_xml android_text | android_text main_xml |
					main_xml android_id android_text | main_xml android_text android_id |
					main_xml android_textcolor android_text | main_xml android_text android_textcolor |
					main_xml android_text android_id android_textcolor | 
					main_xml android_text android_textcolor android_id |
					main_xml android_textcolor android_id android_text |
					android_text android_id android_textcolor main_xml | 
					android_text android_textcolor android_id main_xml |
					android_textcolor android_id android_text main_xml;

imageview_body_xml: main_xml android_src | android_src main_xml |
					main_xml android_src android_id | android_src android_id main_xml |
					main_xml android_src android_padding | android_src android_padding main_xml |
					main_xml android_src android_id android_padding | 
					main_xml android_src android_padding android_id | 
					main_xml android_padding android_id android_src | 					
					main_xml android_id android_padding android_src |
					android_src android_id android_padding main_xml | 
					android_src android_padding android_id main_xml | 
					android_padding android_id android_src main_xml | 					
					android_id android_padding android_src main_xml;
					
button_body_xml: main_xml android_text | android_text main_xml |
					main_xml android_text android_id | android_text android_id main_xml |
					main_xml android_text android_padding | android_text android_padding main_xml |
					main_xml android_text android_id android_padding | 
					main_xml android_text android_padding android_id | 
					main_xml android_padding android_id android_text | 					
					main_xml android_id android_padding android_text |
					android_text android_id android_padding main_xml | 
					android_text android_padding android_id main_xml | 
					android_padding android_id android_text main_xml | 					
					android_id android_padding android_text main_xml;

radiogroup_main_xml : 	android_width android_height android_length | 
						android_height android_width android_length | 
						android_width android_height android_length android_checkbutton |
						android_checkbutton android_width android_height android_length |
						android_length android_width android_height android_checkbutton | 
						android_width android_height android_checkbutton android_length;

radiogroup_body_xml: radiogroup_main_xml | 
					 radiogroup_main_xml android_id | 
					 android_id radiogroup_main_xml; 


radiobutton_body_xml: main_xml android_text | 
					  android_text main_xml |
					  main_xml android_id android_text | 
					  main_xml android_text android_id |
					  android_id android_text main_xml | 
					  android_text android_id main_xml
					  android_id main_xml android_text | 
					  android_text main_xml android_id;

progressbar_body_xml: main_xml | 
					  main_xml android_id | android_id main_xml |
					  main_xml android_max | android_max main_xml |
					  main_xml android_progress | android_progress main_xml |
					  main_xml android_id android_max | main_xml android_max android_id | android_max main_xml android_id | android_id main_xml android_max |
					  main_xml android_id android_max android_progress |
					  main_xml android_id android_progress android_max |
					  main_xml android_max android_id android_progress |
					  main_xml android_max android_progress android_id |
					  main_xml android_progress android_id android_max |
					  main_xml android_progress android_max android_id;

android_width: 	CMD_ANDROIDWIDTH '=' STRING_TEXT | 
				CMD_ANDROIDWIDTH '=' STRING_TEXT '>' |
				CMD_ANDROIDWIDTH '=' NUMBER | 
				CMD_ANDROIDWIDTH '=' NUMBER '>';

android_height: CMD_ANDROIDHEIGHT '=' STRING_TEXT | 
				CMD_ANDROIDHEIGHT '=' STRING_TEXT '>'|
				CMD_ANDROIDHEIGHT '=' NUMBER | 
				CMD_ANDROIDHEIGHT '=' NUMBER '>';

android_id: CMD_ANDROIDID '=' STRING_TEXT | CMD_ANDROIDID '=' STRING_TEXT '>';
android_orientation: CMD_ANDROIDORIENTATION '=' STRING_TEXT | CMD_ANDROIDORIENTATION '=' STRING_TEXT '>' ;

android_text: CMD_ANDROIDTEXT '=' STRING_TEXT;
android_textcolor: CMD_ANDROIDTEXTCOLOR '=' STRING_TEXT;

android_src: CMD_ANDROIDSRC '=' STRING_TEXT;
android_padding: CMD_ANDROIDPADDING '=' NUMBER;

android_max: CMD_ANDROIDMAX '=' NUMBER;
android_progress: CMD_ANDROIDPROGRESS '=' NUMBER;
android_checkbutton: CMD_ANDROIDCHECKEDBUTTON '=' STRING_TEXT;

android_length: CMD_ANDROIDLENGTH '=' NUMBER {
		 rButtons = $3;
	}; 

%%

int main(int argc, char* argv[]){
		FILE *file;
		
		if(file = fopen(argv[1], "r")) {		
			yyin = file;
			yyparse();
		 	if (errors==0){
				printf("\n\n ------------------------------ \n");
				printf(" Android XML Syntax is correct! \n");
				printf(" ------------------------------ \n");
			}
		}else{
	   		printf("\n\n ----------------------- \n");
			printf(" The file doesn't exists \n");
			printf(" ----------------------- \n");
		}

}

void yyerror(const char *s) {
	printf("\n--------------------------------- \n");
	printf(" Android XML Syntax isn't correct! \n");
	printf(" --------------------------------- \n");
	printf("Syntax error in line %d \n",lines+1);
	errors++;
	if(rbErrors>0){
			printf("%s \n", s);
	}
	exit(1);
}

int checkVal(int val, int radiobuttons){
	
	//printf("Val= %d", val); //Val is OK!
	//printf("Radiobuttons = %d", radiobuttons);

	if(val<radiobuttons){
		rbErrors++;
		return 1;
	}else{
		return 0;
	}

}

 