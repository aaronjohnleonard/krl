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
      myMap = { "venue" : thisVenue ,
                "shout" : thisShout };
  	}
  	always{
  		set ent:venue thisVenue;
  		set ent:shout thisShout;
  		set ent:city  response.pick("$.venue.location.city").encode();
  		set ent:time  response.pick("$.createdAt").encode();
      raise explicit event pds:new_location_data for b505201x5
        with key = "fs_checkin"
        and value = "map";
  	}
  }
}














