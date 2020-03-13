/*

	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	TemplateFinder.cfc
	Author:	Luis Carlos Rodriguez
	Date:	11-Marzo-2020
	Desc:	#5913: Servicio de dominio que se encarga de buscar una plantilla de email y la devuelve.

	*****	Revision History
	By:		
	Date:	
	Desc:	
		
*/
	
component displayname ="TemplateFinder"
{

pageencoding "UTF-8";


	public function init( ITemplateRepository  templateRepository  )
	{
		VARIABLES.repository = ARGUMENTS.templateRepository;	
	}

	public Template function execute( Required string templateCode , Required string lang )
	{		
		var template = VARIABLES.repository.getTemplate( ARGUMENTS.templateCode ,  ARGUMENTS.lang );

		if( !isdefined("template") ){
			throw( type="interpreterTemplate.domain.TemplateFinder.execute", message="Template not found, enter a valid template code : " & ARGUMENTS.templateCode );
		}
		return  template;		
	}

} 