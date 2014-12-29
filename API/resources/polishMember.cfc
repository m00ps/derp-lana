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
			taffy_uri="/polish/{polishID}" {


	public function get(numeric polishID) output="false" {
		/* TODO: Implement Method */

		queryservice = new query();
		queryservice.setdatasource("vernis");
		queryservice.setname('qryPolish');
		queryservice.setSQL("SELECT *
							FROM   vw_products
							WHERE  product_id = #arguments.polishID#");
		result = queryService.execute();
		qrypolish = result;

		return representationOf('#qryPolish#').withStatus(200);
	}

	public function put(required struct polishDetails) output="false" {
		/* TODO: Implement Method */

		queryservice = new query();
		queryservice.setdatasource("vernis");
		queryservice.setname('qryPolishUpdate');
		queryservice.addparam(name="id", value=arguments.polishid, cfsqltype="cf_sql_int");
		queryservice.addparam(name="product_brand_id", value=arguments.polishdetails.product_brand_id, cfsqltype="cf_sql_int");
		queryservice.addparam(name="product_name", value=arguments.polishdetails.product_name, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="barcode", value=arguments.polishdetails.barcode, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="price", value=arguments.polishdetails.price, cfsqltype="cf_sql_numeric");
		queryservice.addparam(name="description", value=arguments.polishdetails.description, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="image", value=arguments.polishdetails.image, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="imgsrc", value=arguments.polishdetails.imgsrc, cfsqltype="cf_sql_varchar");
		queryservice.setSQL("UPDATE product
							SET 	product_name = :product_name
									,barcode = :barcode
									,price = :price
									,description = :description
									,image = :image
									,imgsrc = :imgsrc
							WHERE	id = :id");
		result = queryService.execute();
		genKey = result.getPrefix();

		return noData().withStatus(200);
	}

	public function post(required struct polishDetails) output="false" {

		queryservice = new query();
		queryservice.setdatasource("vernis");
		queryservice.setname('qryPolishInsert');
		queryservice.addparam(name="product_brand_id", value=arguments.polishdetails.product_brand_id, cfsqltype="cf_sql_int");
		queryservice.addparam(name="product_name", value=arguments.polishdetails.product_name, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="description", value=arguments.polishdetails.description, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="barcode", value=arguments.polishdetails.barcode, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="price", value=arguments.polishdetails.price, cfsqltype="cf_sql_numeric");
		queryservice.addparam(name="image", value=arguments.polishdetails.image, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="imgsrc", value=arguments.polishdetails.imgsrc, cfsqltype="cf_sql_varchar");
		queryservice.setSQL("INSERT INTO product (product_brand_id, barcode, product_name, price, description, image, imgsrc)
							SELECT :product_brand_id, :barcode, :product_name, :price, :description, :image, :imgsrc");
		result = queryService.execute();
		genKey = result.getPrefix().generatedkey;

		return noData().withStatus(204).withHeaders(
			{"X-INSERTED-ID"= genkey}
		);
	}
}