/*

	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	UserFinder.cfc
	Author:	Luis Carlos Rodriguez
	Date:	11-Marzo-2020
	Desc:	#5913: Servicio de dominio que se encarga de buscar la información del usuario(por medio del "emailRef") al que se le envía el correo.
			Devuelve una estructura con la informacion del usuario : UserData = { Email,FullName,UserName...etc}

	*****	Revision History
	By:		
	Date:	
	Desc:	
		
*/	

component displayname ="UserFinder"
{

pageencoding "UTF-8";


	public function init( IUserDataRepository  userDataRepository  )
	{
		VARIABLES.repository = ARGUMENTS.userDataRepository;	
	}

	public userData function execute( Required struct userData )
	{		
		var userInformation = VARIABLES.repository.getGeneralInfo( ARGUMENTS.userData );

		if( !isdefined("userInformation") ){
			throw( type="interpreterTemplate.domain.UserFinder.execute", message="No user found with emailRef::"&ARGUMENTS.userData.emailRef);
		}

		return userInformation;
	}

} 