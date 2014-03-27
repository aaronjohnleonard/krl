ruleset location_listener {
	meta {
    name "Location Listener"
    author ""
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
  }
  rule location_show{
    select when web cloudAppSelected
    pre {
    	x = 5;
    }
    {
      	SquareTag:inject_styling();
      	CloudRain:createLoadPanel("Foursquare!", {}, ent:lat);
    }
  }
  rule location_catch {
  	select when location notification
  	pre{
  		lat = 5;
  		long = 10;
  	}
  	always{
  		set ent:lat lat;
  		set ent:long long;
  	}
  }
}