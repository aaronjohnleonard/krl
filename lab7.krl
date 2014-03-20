ruleset lab7 {
	meta {
    	name "Lab 7"
    	description <<
    	I'm not sure
    	>>
    	author "Aaron"
    	logging off
    	use module b505201x5 alias location_data
    	use module a169x676 alias pds
    	use module a169x701 alias CloudRain
    	use module a41x186  alias SquareTag
  	}
  	dispatch {
  	}
  	global {
  	}
  	rule nearby {
  	select when new_current location{

  	}
  	}
}