/*

	Copyright 2013-2020 AITECH SOFTWARE CORPORATION, INC., all rights reserved

	Name:	ITemplateRepository.cfc
	Author:	Juan Pablo Victoria - Luis Carlos Rodriguez
	Date:	07-Feb-2020
	Desc:	#5913: Interface that will be used for set the implicit data in the template

	*****	Revision History
		
*/

interface displayname="ITemplateRepository"
{	
	public any function getTemplate( Required string templateCode ,Required string lang );
	public any function getTemplateVars( required string templateCode );
}
