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
  	pre {
  		response = event:param("checkin").decode();
      thisVenue = response.pick("$.venue.name").encode();
      thisShout = response.pick("$.shout").encode();
      thisCity = response.pick("$.venue.location.city").encode();
      thisLat = response.pick("$.venue.location.lat").encode();
      thisLong = response.pick("$.venue.location.lng").encode();
      thisTime = response.pick("$.createdAt").encode();
      myMap = { "venue" : thisVenue ,
                "shout" : thisShout ,
                "city"  : thisCity,
                "time"  : thisTime,
                "lat"   : thisLat,
                "lng"   : thisLong };
  	}
    send_directive(thisVenue) with key = "checkin" and value = myMap;
  	always{
  		set ent:venue thisVenue;
  		set ent:shout thisShout;
  		set ent:city  thisCity;
  		set ent:time  thisTime;
      set ent:lat   thisLat.as("num");
      set ent:lng   thisLong.as("num");
      raise pds event new_location_data for b505201x5
        with key = "fs_checkin"
        and value = myMap;
  	}
  }
}














