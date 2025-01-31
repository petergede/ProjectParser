/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    CMD_ANDROIDWIDTH = 258,
    CMD_ANDROIDHEIGHT = 259,
    CMD_ANDROIDID = 260,
    CMD_ANDROIDORIENTATION = 261,
    CMD_ANDROIDTEXT = 262,
    CMD_ANDROIDTEXTCOLOR = 263,
    CMD_ANDROIDCHECKEDBUTTON = 264,
    CMD_ANDROIDMAX = 265,
    CMD_ANDROIDPROGRESS = 266,
    CMD_ANDROIDSRC = 267,
    CMD_ANDROIDPADDING = 268,
    CMD_ANDROIDLENGTH = 269,
    CMD_LINEARLAYOUT = 270,
    CMD_CLS_LINEARLAYOUT = 271,
    CMD_RELATIVELAYOUT = 272,
    CMD_CLS_RELATIVELAYOUT = 273,
    CMD_RADIOGROUP = 274,
    CMD_CLS_RADIOGROUP = 275,
    CMD_TEXTVIEW = 276,
    CMD_IMAGEVIEW = 277,
    CMD_RADIOBUTTON = 278,
    CMD_BUTTON = 279,
    CMD_PROGRESSBAR = 280,
    CMD_CLS_ENDTASK = 281,
    NUMBER = 282,
    STRING_TEXT = 283,
    TEXT = 284
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 17 "parser.y" /* yacc.c:1909  */

    int number;

#line 88 "parser.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
