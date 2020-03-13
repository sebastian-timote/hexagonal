/*

	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	TemplateVarsFinder.cfc
	Author:	Luis Carlos Rodriguez
	Date:	11-Marzo-2020
	Desc:	#5913: Servicio de dominio que se encarga de buscar las variables pertenecientes a una plantilla de correo.
			Devuelve el array con las variables relacionadas con la plantilla, cada variable tiene su regex y replace.

	*****	Revision History
	By:		
	Date:	
	Desc:	
		
*/

import "SPservices.InterpreterTemplate.Domain.InterpretedAssistant";

component displayname ="TemplateVarsFinder"
{
	
pageencoding "UTF-8";


	public function init( ITemplateRepository  templateRepository  )
	{
		VARIABLES.repository = ARGUMENTS.templateRepository;	
	}

	public array function execute( Required string templateCode , Required string lang, Required struct userData)
	{		
		 var templateVars = VARIABLES.repository.getTemplateVars( ARGUMENTS.templateCode );
		
		if( !isdefined("templateVars") ){
			throw( type="interpreterTemplate.domain.TemplateVarsFinder.execute", message="Not found template");
		}
		var interpretedAssistant = new InterpretedAssistant( templateVars , ARGUMENTS.lang , ARGUMENTS.userData ); 	
		return interpretedAssistant.getTemplateVars();
		
	}

} 