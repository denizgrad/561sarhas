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
import com.google.appengine.api.datastore.Query;

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
}
