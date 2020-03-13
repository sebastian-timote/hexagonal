/*

	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	UserData.cfc
	Author:	Luis Carlos Rodriguez
	Date:	11-Marzo-2020
	Desc:	#5913: Modela de datos para encapsular la informacion del usuario.

	*****	Revision History
			
*/
	
component displayname = "UserData" 
{

pageencoding "UTF-8";	


	VARIABLES.userPwd = "";

	public function init( 
						String Plat,
						String Lang,
						String Email,
						String EmailType,
						String EmailTypeDesc,
						String EmailRef,
						String RelType,
						String RelTypeDesc,
						String fullName,
						String UserName				
	 				)	
	{
		VARIABLES.Plat      		= ARGUMENTS.Plat;
		VARIABLES.Lang      		= ARGUMENTS.Lang;
		VARIABLES.Email      		= ARGUMENTS.Email;
		VARIABLES.EmailType      	= ARGUMENTS.EmailType;
		VARIABLES.EmailTypeDesc     = ARGUMENTS.EmailTypeDesc;
		VARIABLES.EmailRef      	= ARGUMENTS.EmailRef;
		VARIABLES.RelType      		= ARGUMENTS.RelType;
		VARIABLES.RelTypeDesc       = ARGUMENTS.RelTypeDesc;
		VARIABLES.fullName      	= ARGUMENTS.fullName;
		VARIABLES.UserName      	= ARGUMENTS.UserName;
		return this;
	}

	public void function setUserpassword( String password )
	{
		VARIABLES.userPwd    = ARGUMENTS.password;
	}

	public string function getUserEmail()
	{
		return VARIABLES.Email;
	}

	public struct function getUserData()
	{
		var userData = structNew(); // Contains decrypted data
		userData.Plat			= VARIABLES.Plat;
		userData.Lang			= VARIABLES.Lang;
		userData.Email			= VARIABLES.Email;
		userData.EmailType 		= VARIABLES.EmailType;
		userData.EmailTypeDesc	= VARIABLES.EmailTypeDesc;
		userData.EmailRef		= VARIABLES.EmailRef;
		userData.RelType	    = VARIABLES.RelType;
		userData.RelTypeDesc	= VARIABLES.RelTypeDesc;
		userData.fullName		= VARIABLES.RelType;
		userData.UserName		= VARIABLES.RelTypeDesc;
		userData.fullName		= VARIABLES.fullName;
		userData.UserName		= VARIABLES.UserName;
		userData.userPwd		= VARIABLES.userPwd;
		return userData;
	}
	
}

