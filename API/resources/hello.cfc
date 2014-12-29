/**
 * hello
 *
 * @author CA
 * @date 10/13/14
 **/

component extends="taffy.core.resource" taffy_uri="/hello" {

		function get(){
				return representationOf(['hello','world']);
		}

		function put(){
				return representationOf(['world','put']);
		}

}