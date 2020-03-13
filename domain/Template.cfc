/*

	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	Template.cfc
	Author:	Juan Pablo Victoria - Luis Carlos Rodriguez
	Date:	11-Feb-2020
	Desc:	#5913: Modelo de datos para el el objeto de tipo Template

	*****	Revision History
	
	By:		Luis carlos rodriguez
	Date:	03-Mar-2020
	Desc:	#5913: Se encapsula las propiedades del componente y se crea los metodos getSubject y getMessage.
	
*/

component displayname = "Template" 
{
	
pageencoding "UTF-8";


	VARIABLES.subject = "";
	VARIABLES.message = "";
	VARIABLES.to 	  = "";
	
	public function init( required String subject, 
						  required String message )
	{
		VARIABLES.subject      = ARGUMENTS.subject;
		VARIABLES.message      = ARGUMENTS.message;
		return this;
	}

	void function setTo( Required string email )
	{
		VARIABLES.to = ARGUMENTS.email;		
	}

	String function getSubject()
	{
		return VARIABLES.subject;
	}

	String function getMessage()
	{
		return VARIABLES.message;
	}

	String function getTo()
	{		
		return VARIABLES.to;
	}

	public void function interpret( array emailVars )
	{
	
		for ( item in ARGUMENTS.emailVars)
		{
			try {				
				VARIABLES.message = REReplaceNoCase(VARIABLES.message, item.regex, item.replace, "all");
			}
			catch( any e) {
				var type="interpreterTemplate.domain.Interpret.interpret";
				var message="Unexpected " & " : " & "interpret : " & e.message & " : " & e.detail;
				throw( type=type , message=message);
			}
		}
		
	}


}

