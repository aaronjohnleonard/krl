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
    	venue = ent:venue;

    	my_html = <<
    	<br>
    	<h3>Location</h3>
    	venue: #{venue}</br>
    	latitude : #{lat} </br>
    	longitude : #{long}

    	>>
    }
    {
      	SquareTag:inject_styling();
      	CloudRain:createLoadPanel("Location Notification!", {}, my_html);
    }
  }
  rule location_catch {
  	select when location notification
  	pre{
  		lat = event:attr("lat");
  		long = event:attr("long");
  		venue = event:attr("venue");
  	}
  	always{
  		set ent:lat lat;
  		set ent:long long;
  		set ent:venue venue;
  	}
  }
}