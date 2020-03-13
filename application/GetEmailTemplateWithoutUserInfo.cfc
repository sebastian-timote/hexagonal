/*	

	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	GetEmailTemplateWithoutUserInfo.cfc
	Author:	Luis Carlos Rodriguez
	Date:	11-Marzo-2020
	Desc:	#5913: Caso de uso "GetEmailTemplateWithoutUserInfo" se encarga de obtener 
			los datos basicos para enviar un correo sin la informacion del usuario. 

			Las variables que reemplaza y dependiendo de tipo de plantilla seran:
				* los estilos, html como el footer,fecha, palabras reservadas como settleitsoft..ect

	*****	Revision History
	
	By:		
	Date:	
	Desc:
	
*/

import "SPservices.InterpreterTemplate.Domain.Interpret";
import "SPservices.InterpreterTemplate.Domain.TemplateFinder";
import "SPservices.InterpreterTemplate.Domain.Template";
import "SPservices.InterpreterTemplate.Domain.TemplateVarsFinder";


component name="GetEmailTemplateWithoutUserInfo" 
displayname="GetEmailTemplateWithoutUserInfo" 
output=false
{

pageencoding "UTF-8";


	public function init( Required ITemplateRepository templateRepository )
	{
		VARIABLES.templateFinder 		= new TemplateFinder( templateRepository ); 
		VARIABLES.templateVarsFinder 	= new TemplateVarsFinder( templateRepository ); 
		return this;
	}

	// Return struct with Subject - Message
	public Template function execute( Required struct tempateDatos = {}  )
	{		

		var type ="interpreterTemplate.application.GetDataForSendEmailFacade.getDataForSendEmail";
		var message ="you need the following data in the structure {codetemplate,lang, plat}";

		if( StructIsEmpty(ARGUMENTS.tempateDatos) ){
			throw( type=type , message=message);
		}

		var template 			= VARIABLES.templateFinder.execute(ARGUMENTS.tempateDatos.codeTemplate, ARGUMENTS.tempateDatos.lang);
		var templateVars 		= VARIABLES.templateVarsFinder.execute(ARGUMENTS.tempateDatos.codeTemplate,ARGUMENTS.tempateDatos.lang , ARGUMENTS.tempateDatos);	

		template.interpret( templateVars );
		return template;
	}
	
}
