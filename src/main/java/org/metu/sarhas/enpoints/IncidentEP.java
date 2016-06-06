package org.metu.sarhas.enpoints;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import javax.inject.Named;

import org.apache.commons.lang.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.api.server.spi.config.Api;
import com.google.api.server.spi.config.ApiMethod;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;

@Api(name = "incident", version = "v1")
public class IncidentEP {
	/**
	 * 
	 * @return as json
	 * 
{
  "items" : [ {
    "key" : {
      "kind" : "Incident",
      "appId" : "metu561sarhas",
      "id" : "5066549580791808",
      "namespace" : "",
      "complete" : true
    },
    "appId" : "metu561sarhas",
    "namespace" : "",
    "kind" : "Incident",
    "properties" : {
      "type" : "fname",
      "incidentDate" : "fname",
      "title" : "fname"
    }
  } ]
}
	 */
	@ApiMethod(name = "test", httpMethod = ApiMethod.HttpMethod.GET, path = "test")
	public Collection<Entity> getIncidents() {
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		// id //create update depends on id
		Entity e = new Entity("Incident");
//		e.setProperty("id", 123);
		e.setProperty("title", "fname");
		e.setProperty("incidentDate", "fname");
		e.setProperty("type", "fname");
		ds.put(e);
		Key key = KeyFactory.createKey("Incident", e.getKey().getId());
		Entity getE = null;
		try {
			getE = ds.get(key);
			System.out.println(getE);
		} catch (EntityNotFoundException e5) {
			System.out.println("ENTITY NOT FOUND");
		}
		List<Entity> rel = new ArrayList<Entity>();
		rel.add(getE);
		return rel;
	}

	@ApiMethod(name = "save", httpMethod = ApiMethod.HttpMethod.POST, path = "save")
	public Entity saveIncident(@Named("jsonIncident") String jsonIncident) {
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		if (StringUtils.isEmpty(jsonIncident)) {
			return null;
		}
		JSONObject jsonObj = null;
		Entity entIncident = new Entity("Incident");
		try {
			jsonObj = new JSONObject(jsonIncident.trim());

			if(jsonObj.has("id")){ //onden gelirken direk id olsun.
				Key key = KeyFactory.createKey("Incident", Long.valueOf(jsonObj.getString("id")));
				try {
					entIncident = ds.get(key);
				} catch (EntityNotFoundException e) {
					System.out.println("ENTITY NOT FOUND");//patlatma gec
				}
			}
			Iterator<?> keys = jsonObj.keys();
			
			while (keys.hasNext()) { //gelen her ozelligi degeriyle entity'ye set eder. GENERIC
				String key = (String) keys.next();
				if(key.equals("id")){
					continue;
				}
				String value = (String) jsonObj.get(key);
				entIncident.setProperty(key,value);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		ds.put(entIncident);
		return entIncident;
	}
	
	@ApiMethod(name = "delete", httpMethod = ApiMethod.HttpMethod.POST, path = "delete")
	public void deleteIncident(@Named("incidentOid") String incidentOid) {
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		incidentOid = incidentOid.replaceAll("\"", "");
		if (StringUtils.isEmpty(incidentOid)) {
			return;
		}
		Key key = KeyFactory.createKey("Incident", Long.valueOf(incidentOid));
		ds.delete(key);
	}
	/**
	 * 
	 * @return
{
  "items" : [ {
    "key" : {
      "kind" : "Incident",
      "appId" : "metu561sarhas",
      "id" : "5066549580791808",
      "namespace" : "",
      "complete" : true
    },
    "namespace" : "",
    "appId" : "metu561sarhas",
    "kind" : "Incident",
    "properties" : {
      "type" : "fname",
      "incidentDate" : "fname",
      "title" : "fname"
    }
  }, {
    "key" : {
      "kind" : "Incident",
      "appId" : "metu561sarhas",
      "id" : "5629499534213120",
      "namespace" : "",
      "complete" : true
    },
    "namespace" : "",
    "appId" : "metu561sarhas",
    "kind" : "Incident",
    "properties" : {
      "type" : "fname",
      "incidentDate" : "fname",
      "title" : "fname"
    }
  }, {
    "key" : {
      "kind" : "Incident",
      "appId" : "metu561sarhas",
      "id" : "6192449487634432",
      "namespace" : "",
      "complete" : true
    },
    "namespace" : "",
    "appId" : "metu561sarhas",
    "kind" : "Incident",
    "properties" : {
      "type" : "test",
      "title" : "test",
      "incidentTime" : "2016-04-30T21:00:00.000Z",
      "completed" : "true"
    }
  } ]
}
	 */
	@ApiMethod(name = "listAll", httpMethod = ApiMethod.HttpMethod.GET, path = "listAll")
	public List<Entity> listIncident() {
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		
		Query q = new Query("Incident");
		List<Entity> results = ds.prepare(q).asList(FetchOptions.Builder.withDefaults());
		
		return results;
	}
	
	@ApiMethod(name = "listAllPersonel", httpMethod = ApiMethod.HttpMethod.GET, path = "listAllPersonel")
	public List<Entity> listAllPersonel() {
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		
		Query q = new Query("Personel");
		List<Entity> results = ds.prepare(q).asList(FetchOptions.Builder.withDefaults());
		
		return results;
		
	}
	@ApiMethod(name = "savePersonel", httpMethod = ApiMethod.HttpMethod.POST, path = "savePersonel")
	public Entity savePersonel(@Named("jsonPersonel") String jsonPersonel) {
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		if (StringUtils.isEmpty(jsonPersonel)) {
			return null;
		}
		JSONObject jsonObj = null;
		Entity entPersonel = new Entity("Personel");
		
		try {
			jsonObj = new JSONObject(jsonPersonel);
			//String personelStr = (String) jsonObj.get("jsonPersonel");
			//personelStr = StringEscapeUtils.unescapeJava(personelStr);
			//JSONObject personel = new JSONObject(personelStr);
			
			if(((String)(jsonObj.get("isNew"))).equals("true"))
			{
				entPersonel.setProperty("name", jsonObj.get("name"));
				entPersonel.setProperty("surname", jsonObj.get("surname"));
				entPersonel.setProperty("idNumber", jsonObj.get("idNumber"));
				entPersonel.setProperty("birthDate", jsonObj.get("birthDate"));
				entPersonel.setProperty("homeNumber", jsonObj.get("homeNumber"));
				entPersonel.setProperty("mobileNumber", jsonObj.get("mobileNumber"));
				entPersonel.setProperty("emergency1Number", jsonObj.get("emergency1Number"));
				entPersonel.setProperty("emergency2Number", jsonObj.get("emergency2Number"));
				entPersonel.setProperty("emailPersonel", jsonObj.get("emailPersonel"));
				entPersonel.setProperty("emailOrganization", jsonObj.get("emailOrganization"));
				entPersonel.setProperty("personalInsurance", jsonObj.get("personalInsurance"));
				entPersonel.setProperty("passportInformation", jsonObj.get("passportInformation"));
				entPersonel.setProperty("personalInformation", jsonObj.get("personalInformation"));
				entPersonel.setProperty("foreignLanguage", jsonObj.get("foreignLanguage"));
				ds.put(entPersonel);
			}
			else
			{
				Query q = new Query("Personel").setFilter(new FilterPredicate("name", FilterOperator.EQUAL, (String)jsonObj.get("name")));
				PreparedQuery pq = ds.prepare(q);
			    Entity result = pq.asSingleEntity();
			    
			    result.setProperty("name", jsonObj.get("name"));
			    result.setProperty("surname", jsonObj.get("surname"));
			    result.setProperty("idNumber", jsonObj.get("idNumber"));
			    result.setProperty("birthDate", jsonObj.get("birthDate"));
			    result.setProperty("homeNumber", jsonObj.get("homeNumber"));
			    result.setProperty("mobileNumber", jsonObj.get("mobileNumber"));
			    result.setProperty("emergency1Number", jsonObj.get("emergency1Number"));
			    result.setProperty("emergency2Number", jsonObj.get("emergency2Number"));
			    result.setProperty("emailPersonel", jsonObj.get("emailPersonel"));
			    result.setProperty("emailOrganization", jsonObj.get("emailOrganization"));
			    result.setProperty("personalInsurance", jsonObj.get("personalInsurance"));
			    result.setProperty("passportInformation", jsonObj.get("passportInformation"));
			    result.setProperty("personalInformation", jsonObj.get("personalInformation"));
			    result.setProperty("foreignLanguage", jsonObj.get("foreignLanguage"));
			    
			    ds.put(result);
			}
			
				
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		
		return entPersonel;
	}
	
	@ApiMethod(name = "savePersonelHcInfo", httpMethod = ApiMethod.HttpMethod.POST, path = "savePersonelHcInfo")
	public Entity savePersonelHcInfo(@Named("personelHcInfo") String jsonPersonelHcInfo) {
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		if (StringUtils.isEmpty(jsonPersonelHcInfo)) {
			return null;
		}
		JSONObject jsonObj = null;
		Entity entPersonel = new Entity("Personel");
		
		try {
			jsonObj = new JSONObject(jsonPersonelHcInfo);
			//String personelStr = (String) jsonObj.get("jsonPersonel");
			//personelStr = StringEscapeUtils.unescapeJava(personelStr);
			//JSONObject personel = new JSONObject(personelStr);
			
			Query q = new Query("Personel").setFilter(new FilterPredicate("name", FilterOperator.EQUAL, (String)jsonObj.get("name")));
			PreparedQuery pq = ds.prepare(q);
		    Entity result = pq.asSingleEntity();
		    
		    result.setProperty("bloodtype", jsonObj.get("bloodtype"));
		    result.setProperty("antihavigg", jsonObj.get("antihavigg"));
		    result.setProperty("antihbs", jsonObj.get("antihbs"));
		    result.setProperty("antihcv", jsonObj.get("antihcv"));
		    result.setProperty("antihiv", jsonObj.get("antihiv"));
		    result.setProperty("hbs", jsonObj.get("hbs"));
		    result.setProperty("docsInterpreps", jsonObj.get("docsInterpreps"));
		    
		    ds.put(result);				
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		
		return entPersonel;
	}
	
	@ApiMethod(name = "deletePersonel", httpMethod = ApiMethod.HttpMethod.POST, path = "deletePersonel")
	public void deletePersonel(@Named("name") String name) {
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		
		Query q = new Query("Personel").setFilter(new FilterPredicate("name", FilterOperator.EQUAL, name));
		PreparedQuery pq = ds.prepare(q);
	    Entity result = pq.asSingleEntity();
	    
	    ds.delete(result.getKey());
	}
}
