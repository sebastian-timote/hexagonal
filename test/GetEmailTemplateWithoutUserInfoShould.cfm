<!---	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

		Name:	GetEmailTemplateWithoutUserInfoShould.cfc
		Author:	Luis Carlos Rodriguez
		Date:	10-Marzo-2020
		Desc:	#5913: Archivo que se encarga de testear la funcionalidad del caso de uso "GetEmailTemplateWithoutUserInfo" que 
				se encuentra en la carpeta "application".
				
		*****	Revision History
		By:		Luis Carlos Rodriguez
		Date:	12-Marzo-2020
		Desc:	#5913: Para utilizar los test, debe de copiar la carpeta "test" en "DEVEL" .	
					
--->

<cfscript>


	import "SPservices.InterpreterTemplate.application.GetEmailTemplateWithoutUserInfo";
	import "SPservices.InterpreterTemplate.Infraestructure.UserDataRepositoryMysql";
	import "SPservices.InterpreterTemplate.Infraestructure.TemplateRepositoryMySql";

	params 				= structNew(); // It contains the necessary parameters to build the email.
	params.codeTemplate	= "EnterDebtAccount";
	params.lang 		= "es";   
	params.plat 		= "User";

	function should_return_an_error_when_sending_an_invalid_template_code( Required dataTemplate )
	{

		try{

			ARGUMENTS.dataTemplate.codeTemplate = "TEST8";
			templateRepositoryMySql  	= new TemplateRepositoryMySql();	
			interpreteObjet   			= new GetEmailTemplateWithoutUserInfo( templateRepositoryMySql);
			templateEmail 				= interpreteObjet.execute( ARGUMENTS.dataTemplate);

			writeOutput("<br>"); 
			writeOutput("---------Subject---------"); 
			writeOutput("<br>"); 
			writeDump(templateEmail.getSubject()); 
			
			writeOutput("<br>"); 
			writeOutput("---------Message---------"); 
			writeOutput("<br>"); 
			writeDump(templateEmail.getMessage()); 


		}catch( any e){
			writeDump(e); abort;
		}

	}

	function should_return_an_error_if_you_do_not_pass_the_basic_data()
	{

		try{
			templateRepositoryMySql  	= new TemplateRepositoryMySql();	
			interpreteObjet   			= new GetEmailTemplateWithoutUserInfo(templateRepositoryMySql);
			templateEmail 				= interpreteObjet.execute( );

			writeOutput("<br>"); 
			writeOutput("---------Subject---------"); 
			writeOutput("<br>"); 
			writeDump(templateEmail.getSubject()); 
			
			writeOutput("<br>"); 
			writeOutput("---------Message---------"); 
			writeOutput("<br>"); 
			writeDump(templateEmail.getMessage()); 

		}catch( any e){
			writeDump(e); abort;
		}
	}

	function should_return_an_error_if_the_empty_structure_passes( )
	{

		try{

			dataTemplate = {};
			templateRepositoryMySql  	= new TemplateRepositoryMySql();	
			interpreteObjet   			= new GetEmailTemplateWithoutUserInfo( templateRepositoryMySql);
			templateEmail 				= interpreteObjet.execute( dataTemplate );

			writeOutput("<br>"); 
			writeOutput("---------Subject---------"); 
			writeOutput("<br>"); 
			writeDump(templateEmail.getSubject()); 
			
			writeOutput("<br>"); 
			writeOutput("---------Message---------"); 
			writeOutput("<br>"); 
			writeDump(templateEmail.getMessage()); 			

		}catch( any e){
			writeDump(e); abort;
		}

	}

	function should_return_a_structure_with_the_data_to_send_an_email( Required dataTemplate )
	{

		try{
			templateRepositoryMySql  	= new TemplateRepositoryMySql();	
			interpreteObjet   			= new GetEmailTemplateWithoutUserInfo( templateRepositoryMySql);
			templateEmail 				= interpreteObjet.execute( ARGUMENTS.dataTemplate );

			writeOutput("<br>"); 
			writeOutput("---------Subject---------"); 
			writeOutput("<br>"); 
			writeDump(templateEmail.getSubject()); 
			
			writeOutput("<br>"); 
			writeOutput("---------Message---------"); 
			writeOutput("<br>"); 
			writeDump(templateEmail.getMessage()); 			

		}catch( any e){
			writeDump(e); abort;
		}

	}


//	should_return_an_error_when_sending_an_invalid_template_code( params );
//	should_return_an_error_if_you_do_not_pass_the_basic_data();
//  should_return_an_error_if_the_empty_structure_passes();
	should_return_a_structure_with_the_data_to_send_an_email(  params );

	



</cfscript>