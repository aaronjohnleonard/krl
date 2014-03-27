ruleset foursquare{
	meta {
    name "Foursquare"
    description <<
      Foursquare
    >>
    author ""
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
  }
  dispatch {
  }
  global {
    subscription_maps = {
      "map1": {
        "name":"Aaron",
        "cid":"8A4A9D98-B5AA-11E3-A281-BD81E71C24E1"
      },
      
      "map2": {
        "name":"Leonard",
        "cid":"0BEAAE84-B5AA-11E3-A80D-C77087B7806A"
      }
  }
  rule display_checkin{
    select when web cloudAppSelected
    pre {
  		thisVenue = ent:venue;
  		thisShout = ent:shout;
  		thisTime = ent:time;
  		thisCity = ent:city;
      	my_html = <<
      	  </br>
      	  <h1>Foursquare</h1>
      	  #{thisVenue}<br>
      	  #{thisShout}<br>
      	  #{thisTime}<br>
      	  #{thisCity}<br>
      	>>;
    }
    {
      	SquareTag:inject_styling();
      	CloudRain:createLoadPanel("Foursquare!", {}, my_html);
    }
  }
  rule process_fs_checkin {
  	select when foursquare checkin
    foreach subscription_maps setting(key, val)
  	pre {
  		response = event:param("checkin").decode();
      thisVenue = response.pick("$.venue.name").encode();
      thisShout = response.pick("$.shout").encode();
      thisCity = response.pick("$.venue.location.city").encode();
      thisLat = response.pick("$.venue.location.lat");
      thisLong = response.pick("$.venue.location.lng");
      thisTime = response.pick("$.createdAt").encode();
      myMap = { "venue" : thisVenue ,
                "shout" : thisShout ,
                "city"  : thisCity,
                "time"  : thisTime,
                "lat"   : thisLat,
                "lng"   : thisLong };
  	}
    {
    send_directive(thisVenue) with key = "checkin" and value = myMap;
    event:send(val, "location", "notification")
      with attrs =  {
        "lat": latitude,
         "long": longitude
       };
    }
  	always{
  		set ent:venue thisVenue;
  		set ent:shout thisShout;
  		set ent:city  thisCity;
  		set ent:time  thisTime;
      set ent:lat   thisLat;
      set ent:lng   thisLong;
      raise pds event new_location_data for b505201x5
        with key = "fs_checkin"
        and value = myMap;
  	}
  }
  rule dispatcher {

  }
}














