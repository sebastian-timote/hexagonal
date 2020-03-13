/*

	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	InterpretedAssistant.cfc
	Author:	Luis Carlos Rodriguez
	Date:	11-Marzo-2020
	Desc:	#5913: Servicio de dominio que se encarga de obtener el valor del replace del contenedor de variables. 
			Devuelve el array con las variables relacionadas con la plantilla, con su regex y replace por cada variable.

	*****	Revision History
	
	By:		
	Date:	
	Desc:	
		
*/

component displayname="InterpretedAssistant"
{

pageencoding "UTF-8";


	public function init( Required array listVarTemplate , Required string lang, struct data = {} )
	{
		VARIABLES.templateVars 	=  ARGUMENTS.listVarTemplate;	
		VARIABLES.lang 			=  ARGUMENTS.lang;
		VARIABLES.data 			=  ARGUMENTS.data;
	}

	public array function getTemplateVars()
	{
		var arrayChecked   = getVarsChecked( VARIABLES.templateVars , VARIABLES.data );
		return arrayChecked;
	}

 	// Return array with each var checked
	 private array function getVarsChecked( Required array arrayVars, struct Args = {} )
	 {
		 if( structIsEmpty(Args) ){
			 ARGUMENTS.Args = {
				 plat = "User",
				 lang = #VARIABLES.lang#
			 };
		 }
 
		 var plat    	 = ARGUMENTS.Args.plat;
		 var lang		 = ARGUMENTS.Args.Lang;
		 var checkedVars = ARGUMENTS.arrayVars;
		 
		 for( item in checkedVars ){
			 
			 var replaceVar 	= item.replace;
			 var myResult 	= "";
			 var myReplace 	= "";
			 var realValue   = "";
 
			 try{
				 realValue = evaluate( replaceVar );
			 }catch(any e){
				 
				 var patternRegex = '##(.|\n)*?##';
				 var check = reFindMatches(regex=patternRegex, str=replaceVar);
				
				 if( arraylen(check) > 0 ){
				 
					 for(i=1; i<=arraylen( check ); i++){
						 try{
 
							 myResult = evaluate( check[i] );
							 myReplace = i == 1 ? REReplace(replaceVar,"##(.|\n)*?##", myResult) : REReplace(myReplace,"##(.|\n)*?##", myResult);
 
						 } catch(any e){
							 writeoutput("<table border = '1'><tr><td>Not a CF function: </td><td>" & e.message & "</td></tr></table>");
						 }
					 }
 
					 realValue = myReplace;
				 } else {
 
					 realValue = replaceVar;
				 }
		 
			 }
 
			 item.replace = realValue;
		 }
 
		 return checkedVars;
	 }
 
	 // Call function reFindMatches that returns array with all elements that match the pattern
	 private array function reFindMatches( required string regex, required string str ) 
	 {
		 var start 	= 1;
		 var result 	= [];
		 var matches = [];
		 var match 	= '';
		 do {
			 matches = ReFind(ARGUMENTS.regex, ARGUMENTS.str, start, true);
			 if ( matches.pos[1] ) {
				 match = matches.len[1] ? Mid(ARGUMENTS.str, matches.pos[1], matches.len[1]) : '';
				 ArrayAppend(result, match);
				 start = matches.pos[1] + matches.len[1];
			 }
 
		 } while(matches.pos[1]);
 
		 return result;
	 }
 
	 // Function getYear Gets year from current date
	 private any function getYear()
	 {
		 todayDate = now();
		 curYear = DatePart("yyyy", todayDate);
 
		 return curYear;
	 }
 
	 // Function getYear Gets year from current date
	 private any function getProductDate(required string plat)
	 {
		 switch (plat) {
			 case "Supp":
				 startYear = "2013";
				 break;
			 default:
				 startYear = "2016";
				 break;
		 }
 
		 todayDate = now();
		 currentYear = DatePart("yyyy", todayDate);
 
		 if (startYear != currentYear) {
			 returnYear = startYear & "-" & currentYear;
		 } else {
			 returnYear = currentYear;
		 }
 
		 return returnYear;
	 }
 
	 // Function getFirstName Extracts first name from theName
	 private any function getFirstName(theName)
	 {
		 firstSpace	= find(" ",theName);
		 if (firstSpace) {
			 ret.first	= left(theName,firstSpace-1);
		 } else {
			 ret.first	= theName;
		 }
		 
		 return ret.first;
	 }
 
	 // Function separateName Separates theName argument into first,middle,last
	 private any function separateName(theName)
	 {
		 ret.first	= "";
		 ret.middle	= "";
		 ret.last	= "";
 
		 firstSpace	= find(" ",theName);
		 if (firstSpace) {
			 ret.first	= left(theName,firstSpace-1);
			 secondSpace	= find(" ",theName,firstSpace+1);
			 if (secondSpace) {
				 ret.middle	= mid(theName,firstSpace+1,secondSpace-firstSpace-1);
				 ret.last	= right(theName,len(theName)-secondSpace);
			 } else {
				 ret.last	= right(theName,len(theName)-firstSpace);
			 }
		 } else {
			 ret.first	= theName;
		 }
 
		 return ret;
	 }


}