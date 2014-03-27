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
    	lat = ent:lat;
    	long = ent:long;

    	my_html = <<
    	<br>
    	<h3>Location</h3></br>
    	latitude : #{lat}
    	longitude : #{long}

    	>>
    }
    {
      	SquareTag:inject_styling();
      	CloudRain:createLoadPanel("Foursquare!", {}, my_html);
    }
  }
  rule location_catch {
  	select when location notification
  	pre{
  		lat = event:attr("lat");
  		long = event:attr("long");
  	}
  	always{
  		set ent:lat lat;
  		set ent:long long;
  	}
  }
}