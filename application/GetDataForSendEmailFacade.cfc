/*	
	
	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	GetDataForSendEmailFacade.cfc
	Author:	Luis Carlos Rodriguez
	Date:	11-Marzo-2020
	Desc:	#5913: Caso de uso "GetDataForSendEmailFacade" se encarga de obtener 
			los datos basicos para enviar un correo con informacion del usuario. 

			Las variables que reemplaza y dependiendo de tipo de plantilla seran: 
				* Nombre del usuario,password,emailRef,userName...ect
				* Los estilos, html como el footer,fecha, palabras reservadas como settleitsoft..ect	

	*****	Revision History
	
	By:		Luis Carlos Rodriguez
	Date:	12-Marzo-2020
	Desc:	#5913: "El objetivo de este componente es simplificar la complejidad 
			que pueda tener el programa "intepretar una plantilla de email" y que el cliente
			tenga un solo punto de acceso muy facil y poder utilizar el sistema sin que sepa que hay por dentro."

*/	

import "SPservices.InterpreterTemplate.Infraestructure.UserDataRepositoryMysql";
import "SPservices.InterpreterTemplate.Infraestructure.TemplateRepositoryMySql";
import "SPservices.InterpreterTemplate.application.GetEmailTemplateWithUserInfo";

component  name="GetDataForSendEmailFacade" 
displayname="GetDataForSendEmailFacade" 
output=false
{
	
pageencoding "UTF-8";



	public function init(){
		templateRepositoryMySql  	= new TemplateRepositoryMySql();
		userDataRepositoryMysql  	= new UserDataRepositoryMysql();	
	}

	public struct function getDataForSendEmail( Required tempateDatos = {} )
	{

		var type ="interpreterTemplate.application.GetDataForSendEmailFacade.getDataForSendEmail";
		var message ="you need the following data in the structure {codetemplate,lang, plat,emailRef}";

		if( StructIsEmpty(ARGUMENTS.tempateDatos) ){
			throw( type=type , message=message);
		}
		
		interpreteObjet   	= new GetEmailTemplateWithUserInfo( templateRepositoryMySql , userDataRepositoryMysql);
		templateEmail 		= interpreteObjet.execute( ARGUMENTS.tempateDatos );
		
		var email = {			
			subject = templateEmail.getSubject(),
			message = templateEmail.getMessage(),
			to 	    = templateEmail.getTo()
		};

		return email;

	}

}