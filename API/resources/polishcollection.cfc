	/**
 * polishMember
 *
 * @author CA
 * @date 10/13/14
 **/
component extends="taffy.core.resource"
			accessors=true
			output=false
			persistent=false
			taffy_uri="/polishes/{polish}" {


	public function get(numeric polishID) output="false" {
		/* TODO: Implement Method */

		queryservice = new query();
		queryservice.setdatasource("vernis");
		queryservice.setname('qryPolish');
		queryservice.setSQL("SELECT *
							FROM   vw_products
							WHERE  product_name like '%#arguments.polishID#%'");
		result = queryService.execute();
		qrypolish = result;

		return representationOf('#qryPolish#').withStatus(200);
	}

	public function put( string polishDetails )
			output="false" {
		/* TODO: Implement Method */
		return representationOf(#Arguments.polishDetails#);
	}

	public function update(required numeric polishID
							, required struct PolishDetails
							, required string AdminStatus=true){

		if ( AdminStatus EQ false){
			return noData().withStatus(401);
		}
		PolishDetails = newlist();
		if (!isStruct(PolishDetails)){
			return setData({error="The polish details are missing."}).withStatus(403);
		}

		queryservice = new query();
		queryservice.setdatasource("vernis");
		queryservice.setname('qryUpdate');
		try{
		queryservice.setSQL("SELECT *
							FROM   vw_products
							WHERE  product_name like '%#arguments.polishID#%'");
		result = queryService.execute();
		}catch(any e){
			return noData().withStatus(500);
		}

		return noData().withStatus(204);
	}
}