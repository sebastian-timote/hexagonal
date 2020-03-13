
<!---	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	GetDataForSendEmailFacadeShould.cfc
	Author:	Luis Carlos Rodriguez
	Date:	10-Marzo-2020
	Desc:	#5913: Archivo que se encarga de testear la funcionalidad del caso de uso "GetDataForSendEmailFacade" que 
			se encuentra en la carpeta "application".
			
	*****	Revision History
	By:		Luis Carlos Rodriguez
	Date:	12-Marzo-2020
	Desc:	#5913: Para utilizar los test, debe de copiar la carpeta "test" en "DEVEL" .
			
--->

<cfscript>

	import "SPservices.InterpreterTemplate.application.GetDataForSendEmailFacade";

	params 				= structNew(); 
	params.codeTemplate	= "EnterDebtAccount";
	params.lang 		= "es";   
	params.plat 		= "User";
	params.emailRef 	= "128EDE45-9287-E25B-2CD03B974CC795D7";	

	function should_return_an_error_when_sending_an_invalid_template_code( Required dataTemplate )
	{
		
		try{

			ARGUMENTS.dataTemplate.codeTemplate = "TEST8";		
			dataForSendEmailObjt  = new GetDataForSendEmailFacade();
			dataForSendEmail 	  = dataForSendEmailObjt.getDataForSendEmail(ARGUMENTS.dataTemplate);
			writeDump(dataForSendEmail); 

		}catch( any e){
			writeDump(e); abort;
		}

	}

	function should_return_an_error_when_sending_the_invalid_code_emailRef( Required dataTemplate )
	{
		
		try{
			ARGUMENTS.dataTemplate.emailRef = "123338";
			dataForSendEmailObjt  = new GetDataForSendEmailFacade();
			dataForSendEmail 	  = dataForSendEmailObjt.getDataForSendEmail(ARGUMENTS.dataTemplate);
			writeDump(dataForSendEmail); 
		}catch( any e){
			writeDump(e); abort;
		}

	}

	function should_return_an_error_if_you_do_not_pass_the_basic_data(){

		try{		
			dataForSendEmailObjt  = new GetDataForSendEmailFacade();
			dataForSendEmail 	  = dataForSendEmailObjt.getDataForSendEmail();
			writeDump(dataForSendEmail); 		
		}catch( any e){
			writeDump(e); abort;
		}
	}

	function should_return_an_error_if_the_empty_structure_passes()
	{
	
		try{	

			dataTemplate =	{};
			dataForSendEmailObjt  = new GetDataForSendEmailFacade();
			dataForSendEmail 	  = dataForSendEmailObjt.getDataForSendEmail(dataTemplate);			 
		
		}catch( any e){
			writeDump(e); abort;
		}
	
	}

	function should_return_a_structure_with_the_data_to_send_an_email( Required dataTemplate )
	{

		try{		
			dataForSendEmailObjt  = new GetDataForSendEmailFacade();
			dataForSendEmail 	  = dataForSendEmailObjt.getDataForSendEmail(ARGUMENTS.dataTemplate);
			writeDump(dataForSendEmail); 
		
		}catch( any e){
			writeDump(e); abort;
		}
	}


//	should_return_an_error_when_sending_an_invalid_template_code( params );
//	should_return_an_error_when_sending_the_invalid_code_emailRef(params);
//	should_return_an_error_if_you_do_not_pass_the_basic_data();
//	should_return_an_error_if_the_empty_structure_passes();
	should_return_a_structure_with_the_data_to_send_an_email(  params );

	
</cfscript>