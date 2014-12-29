/**
 * brand
 *
 * @author Acer
 * @date 11/18/14
 **/
component displayname="brand"
			extends="taffy.core.resource"
			accessors=true
			output=false
			persistent=true
			taffy_uri="/brand/{brandID}" {


	public function get(required numeric brandID) output="false" {

		queryservice = new query();
		queryservice.setdatasource("vernis");
		queryservice.setname('qryBrand');
		queryservice.setSQL("SELECT *
							FROM   product_brands
							WHERE  id = #arguments.brandID#");
		result = queryService.execute();
		qryBrand = result;

		return representationOf('#qryBrand#').withStatus(200);
	}

	public function post(required struct brandDetails) output="false" {
		/* TODO: Implement Method */

		queryservice = new query();
		queryservice.setdatasource("vernis");
		queryservice.setname('qryBrandInsert');
		queryservice.addparam(name="brand_name", value=arguments.branddetails.brand_name, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="website", value=arguments.branddetails.website, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="contact_name", value=arguments.branddetails.contact_name, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="contact_email", value=arguments.branddetails.contact_email, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="contact_phone", value=arguments.branddetails.contact_phone, cfsqltype="cf_sql_varchar");
		queryservice.setSQL("INSERT INTO product_brands (brand_name, website, contact_name, contact_email, contact_phone)
							SELECT :brand_name, :website, :contact_name, :contact_email, :contact_phone");
		result = queryService.execute();
		genKey = result.getPrefix().generatedkey;

		return noData().withStatus(204).withHeaders(
			{"X-INSERTED-ID"= genkey}
		);
	}

		public function put(required struct brandDetails) output="false" {
		/* TODO: Implement Method */

		queryservice = new query();
		queryservice.setdatasource("vernis");
		queryservice.setname('qryBrandInsert');
		queryservice.addparam(name="brand_name", value=arguments.branddetails.brand_name, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="website", value=arguments.branddetails.website, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="contact_name", value=arguments.branddetails.contact_name, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="contact_email", value=arguments.branddetails.contact_email, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="contact_phone", value=arguments.branddetails.contact_phone, cfsqltype="cf_sql_varchar");
		queryservice.addparam(name="id", value=arguments.brandid, cfsqltype="cf_sql_int");
		queryservice.setSQL("UPDATE product_brands
							SET 	brand_name = :brand_name
									,website = :website
									,contact_name = :contact_name
									,contact_email = :contact_email
									,contact_phone = :contact_phone
							WHERE	id = :id");
		result = queryService.execute();
		genKey = result.getPrefix();

		return noData().withStatus(200);
	}
}