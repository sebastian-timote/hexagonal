/*

	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	UserDataRepositoryMysql.cfc
	Author:	Luis Carlos Rodriguez
	Date:	10-Marzo-2020
	Desc:	#5913: Repositorio encargado de consultar en la base de datos y traer la informacion,
			que corresponde a una usuario de la apliacion.
			
	*****	Revision History
	By:		
	Date:	
	Desc:	
					
*/
	
import "SPservices.InterpreterTemplate.Domain.UserData";

component  displayname ="UserDataRepositoryMysql" 
implements	="SPservices.InterpreterTemplate.Domain.IUserDataRepository"
{

pageencoding "UTF-8";

	// Returns general info about user and email
	public any function getGeneralInfo( struct initData )
	{
		var emailInfObj = entityload( "Link_EmailUserProfile", { EmailUUID = ARGUMENTS.initData.emailRef }, true);	// UserData from EmailUserProfile

		if ( !isDefined("emailInfObj") ) { // Validate if the query failed
			return ;
		}
	
		var generalInfo = structNew(); // Contains decrypted data

		var lang = ARGUMENTS.initData.lang ==""? SESSION.lang : ARGUMENTS.initData.lang;
		var plat = ARGUMENTS.initData.plat ==""? APPLICATION.productCode : ARGUMENTS.initData.plat;
	
		userData = new UserData(
								plat,
								lang,
								emailInfObj.getEmail(),
								emailInfObj.getEmailTypeCode(),
								emailInfObj.getEmailTypeDesc(),
								emailInfObj.getEmailUUID(),
								emailInfObj.getRelTypeCode(),
								emailInfObj.getRelTypeDesc(),
								emailInfObj.getFullName(),
								emailInfObj.getUserName()
							);
		
		if ( ARGUMENTS.initData.codeTemplate == "PasswordChange" ) {			
			var ormExtendFuncSvc = createObject("component","SPorm.event._ExtendFunctions");//Instanciamos el componente _ExtendFunctions
			var userPwd  = ormExtendFuncSvc.securePropertiesData("g", "SPP", SESSION.up);// Asigna la contrasenia al usuario.
			userData.setUserpassword(userPwd);
		}
	
		return userData;
	}

}
