/*

	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	IUserDataRepository.cfc
	Author:	Luis Carlos Rodriguez
	Date:	11-Marzo-2020
	Desc:	#5913: Interface that will be used for get the external data belong to the template

	*****	Revision History
	
*/

interface displayname="IUserDataRepository"
{
	public any function getGeneralInfo( struct initData );	
}
