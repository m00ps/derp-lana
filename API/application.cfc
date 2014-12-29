/**
 * application
 *
 * @author CA
 * @date 10/13/14
 **/
component accessors=true output=false persistent=false extends="taffy.core.api" {

	//the name can be anything you like
	this.name = 'Vernis';

	function onApplicationStart()
	{
		return super.onApplicationStart();
//		application.objPolish = createObject('component', '')
	}

	function onRequestStart()
	{
		return super.onRequestStart();
	}

	function onTaffyRequest(verb,cfc,requestArguments, mimeExt){
			return true;
	}
}
