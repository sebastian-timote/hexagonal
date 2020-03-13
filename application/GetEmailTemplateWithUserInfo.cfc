/*

	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	GetEmailTemplateWithUserInfo.cfc
	Author:	Luis Carlos Rodriguez
	Date:	11-Marzo-2020
	Desc:	#5913: Caso de uso "GetEmailTemplateWithUserInfo" se encarga de obtener 
			los datos basicos para enviar un correo con la informacion del usuario. 
			
			Las variables que reemplaza y dependiendo de tipo de plantilla seran:
				* Nombre del usuario,password,emailRef,userName...ect
				* Los estilos, html como el footer,fecha, palabras reservadas como settleitsoft..ect		

	*****	Revision History
	
	By:		
	Date:	
	Desc:	
	
*/

import "SPservices.InterpreterTemplate.Domain.Interpret";
import "SPservices.InterpreterTemplate.Domain.TemplateFinder";
import "SPservices.InterpreterTemplate.Domain.Template";
import "SPservices.InterpreterTemplate.Domain.TemplateVarsFinder";
import "SPservices.InterpreterTemplate.Domain.UserFinder";


component name="GetEmailTemplateWithUserInfo" 
displayname="GetEmailTemplateWithUserInfo" 
output=false
{

pageencoding "UTF-8";


	public function init( Required ITemplateRepository templateRepository, Required IUserDataRepository userDataRepository )
	{
		VARIABLES.templateFinder 		= new TemplateFinder( templateRepository ); 
		VARIABLES.templateVarsFinder 	= new TemplateVarsFinder( templateRepository ); 
		VARIABLES.userFinder 			= new UserFinder( userDataRepository ); 
		return this;
	}

	// Return struct with Subject - Message
	public Template function execute(  Required struct templateDatos )
	{	
			
		var type ="interpreterTemplate.application.GetDataForSendEmailFacade.getDataForSendEmail";
		var message ="you need the following data in the structure dataTemplate = {codetemplate,lang, emailRef}";

		if( StructIsEmpty(ARGUMENTS.templateDatos) ){
			throw( type=type , message=message);
		}

		var template 			= VARIABLES.templateFinder.execute(ARGUMENTS.templateDatos.codeTemplate, ARGUMENTS.templateDatos.lang);
		var userData 			= VARIABLES.userFinder.execute(ARGUMENTS.templateDatos);	
		var templateVars 		= VARIABLES.templateVarsFinder.execute(ARGUMENTS.templateDatos.codeTemplate,ARGUMENTS.templateDatos.lang, userData.getUserData() );	
		template.interpret(templateVars);
		template.setTo(userData.getUserEmail());
		return template;
	}

}
