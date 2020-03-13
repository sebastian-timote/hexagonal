/*

	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	TemplateRepositoryMySql.cfc
	Author:	Luis Carlos Rodriguez
	Date:	10-Marzo-2020
	Desc:	#5913: Repositorio encargado de consultar en la base de datos y traer la informacion,
			que corresponde a una plantilla de correo.
			
	*****	Revision History
	By:		
	Date:	
	Desc:	
					
*/	

import "SPservices.InterpreterTemplate.Domain.Template";
component displayname="TemplateRepositoryMySql"
implements = "SPservices.InterpreterTemplate.Domain.ITemplateRepository" 
{

pageencoding "UTF-8";	

	
	any function getTemplate( Required string templateCode ,Required string lang )
	{

		var emailTemplateObj = entityLoad( "TemplateEmailUser" ,{ 
			TemplateEmailCode = ARGUMENTS.templateCode,
			FK_LangCode	= ARGUMENTS.lang,
			Active = true
		}, true);
	
		if( !isDefined( "emailTemplateObj")){
			return;
		}	

		subject = emailTemplateObj.getEmailSubject();
		message = emailTemplateObj.getEmailText();

		return new Template(
			subject = subject,
			message = message
		);

	}

	public any function  getTemplateVars( required string templateCode )
	{
		var listVarsCod		= getRelationshipTemplateVars( 	ARGUMENTS.templateCode );
		var emailVarArray	= []; // Contains the vars that belong to the template

		if( ! arrayIsEmpty( listVarsCod )){

			var filterEmailVarsCodeList = listVarsCod.map( function( item ){ return "'#item#'"; }).toList(); // Where to ormExecuteQuery
			var EmailVars = "EmailVars";
			
			var emailVarsObjList = ormExecuteQuery("
				FROM 
					#EmailVars#
				WHERE
					EmailVarsCode IN ( 
						#filterEmailVarsCodeList#
					)
					AND Active = true
			");

			if( !isDefined( 'emailVarsObjList' ) ) {
				return;
			}

			for( item in emailVarsObjList ){ // Add each struct with a regex and replace
				emailVarArray.add({
					regex: item.getEmailVarsRegex(),
					replace: item.getEmailVarsReplacePlat()
				});
			}
		}

		return emailVarArray;	
	}

	// Returns with array with the vars that must be replace in the template
	private array function getRelationshipTemplateVars( Required string templateCode)
	{
		var arrayVarsTemplate = []; // Contains the vars that exist in the template
		var emailTempVarLnkObj = entityLoad( "TemplateEmail$EmailVars" , { 
			FK_TemplateEmailCode = ARGUMENTS.templateCode,
			Active = true 
		});
		
		if( !isDefined( 'emailTempVarLnkObj' ) ) {
			return;
		}

		for(  item in emailTempVarLnkObj ){ 
			arrayVarsTemplate.append(item.getFK_EmailVarsCode());
		}

		return arrayVarsTemplate;
	}	

}