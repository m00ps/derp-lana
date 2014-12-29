/**
 * tag Component
 *
 * @author Acer
 * @date 12/27/14
 **/
component displayname="tag"
			extends="taffy.core.resource"
			accessors=false
			output=false
			persistent=false
			taffy_uri="/tag/{client_id}/{product_id}" {


	public function get(required numeric clientid, required numeric productid) output="false" {

		queryservice = new query();
		queryservice.setdatasource("vernis");
		queryservice.setname('qryTags');
		queryservice.addparam(name="clientid", value=arguments.clientid, cfsqltype="cf_sql_int");
		queryservice.addparam(name="productid", value=arguments.productid, cfsqltype="cf_sql_int");
		queryservice.setSQL("SELECT *
							FROM   tag
							WHERE  client_id 	= :clientid
							AND	   product_id 	= :productid");
		result = queryService.execute();
		qryTags = result;

		return representationOf(qrytags).withStatus(200);
	};

	public function post(required numeric client_id, required numeric product_id, required string taglist) output="false" {

		queryservice = new query();
		queryservice.setdatasource("vernis");
		queryservice.setname('qryTagInsert');
		queryservice.addparam(name="client_id", value=arguments.client_id, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="product_id", value=arguments.product_id, cfsqltype="cf_sql_varchar");

		sql = "";
		for (i=1; i LTE ListLen(arguments.taglist); i++){

			queryservice.addparam(name="tag"&i, value=ListGetAt(arguments.taglist, i), cfsqltype="cf_sql_varchar");
			sql = sql & "insert into tag (client_id, product_id, tag) SELECT :client_id, :product_id, :tag#i# #chr(10)# #chr(13)#";
		};

		result = queryService.execute(sql=sql);

		return representationOf(sql).withStatus(204);
	};

	public function put(required numeric client_id, required numeric product_id, required string taglist) output="false" {
		/* TODO: Implement Method */

		queryservice = new query();
		queryservice.setdatasource("vernis");
		queryservice.setname('qryTagUpdate');
		queryservice.addparam(name="client_id", value=arguments.client_id, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="product_id", value=arguments.product_id, cfsqltype="cf_sql_varchar");

		sql = "";
		sql = "update tag set active = 0 where client_id = :client_id and product_id = :product_id #chr(10)# #chr(13)#;";
		for (i=1; i LTE ListLen(arguments.taglist); i++){

			queryservice.addparam(name="tag"&i, value=ListGetAt(arguments.taglist, i), cfsqltype="cf_sql_varchar");

			sql = sql & "insert into tag (client_id, product_id, tag) SELECT :client_id, :product_id, :tag#i# #chr(10)# #chr(13)#";
		};

		result = queryService.execute(sql=sql);

		return representationOf(sql).withStatus(200);
	};


	public function delete(required numeric client_id, required numeric product_id, required string taglist) output="false" {

		queryservice = new query();
		queryservice.setdatasource("vernis");
		queryservice.setname('qryTagDelete');
		queryservice.addparam(name="client_id", value=arguments.client_id, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="product_id", value=arguments.product_id, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="taglist", value=ListQualify(arguments.taglist, "'"), cfsqltype="cf_sql_varchar", list="true");

		sql = "";
		sql = "update tag set active = 0 where client_id = :client_id and product_id = :product_id and tag in (:taglist) #chr(10)# #chr(13)#;";

		result = queryService.execute(sql=sql);

		return representationOf(sql).withStatus(200);

	};
}