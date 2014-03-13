ruleset examine_location{
	meta {
    	name "Location Data"
    	description <<
    	Location Data
    	>>
    	author "Aaron"
    	logging off
    	use module b505201x5 alias location_data
    	use module a169x701 alias CloudRain
    	use module a41x186  alias SquareTag
  	}
  	dispatch {
  	}
  	global {
  	}
  	rule show_fs_location{
  	select when web cloudAppSelected
  	pre{
  		info = location_data:get_location_data("venue");
  		html = <<
  			</br>
  			<h1>Foursquare</h1>
  			<div id="info">
  				#{info}
  			</div>
  			>>;
  	}
  	{
     	SquareTag:inject_styling();
     	CloudRain:createLoadPanel("FS Checkin!", {}, html);
     	replace_inner("#info",info);
  	}
  }
}