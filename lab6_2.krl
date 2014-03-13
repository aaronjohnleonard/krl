ruleset examine_location{
	meta {
    	name "Location Data"
    	description <<
    	Location Data
    	>>
    	author "Aaron"
    	logging off
    	use module location_data
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
  		html = <<
  			</br>
  			<h1>Foursquare</h1>
  			<div id="info"></div>
  			>>
  	}
  	{
     	SquareTag:inject_styling();
     	CloudRain:createLoadPanel("FS Checkin!", {}, html);
  	}
  }
}