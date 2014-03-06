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
      	my_html = <<
      	  </br>
      	  <h1>Foursquare</h1>
      	  #{thisVenue}
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
  	}
  	always{
  		set ent:venue response.pick("$.venue.name").encode();
  	}
  }
}














