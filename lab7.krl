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
  		select when location new_current
  		pre {
  			old_checkin = location_data:get_location_data("fs_checkin");

			r90   = math:pi()/2;      
			rEk   = 6378;         // radius of the Earth in km
 
			// point a
			lata  = event:attr("lat");
			lnga  = event:attr("lng");
 
			// point b
			latb  = old_checkin.pick("$..lat").as("num");
			lngb  = old_checkin.pick("$..lng").as("num");
 
			// convert co-ordinates to radians
			rlata = math:deg2rad(lata);
			rlnga = math:deg2rad(lnga);
			rlatb = math:deg2rad(latb);
			rlngb = math:deg2rad(lngb);
 
			// distance between two co-ordinates in kilometers
			dE = math:great_circle_distance(rlnga,r90 - rlata, rlngb,r90 - rlatb, rEk);
  		}
      if dE < 20 then {
        raise explicit event location_nearby with distance=dE;
      }
  		//fired{
  		//	raise explicit event location_nearby with distance=dE;
  		//}
  		else{
  			raise explicit event location_far with distance=dE;
  		}
  	}
    rule display{
      select when web cloudAppSelected
      {
        SquareTag:inject_styling();
        CloudRain:createLoadPanel("Foursquare!", {}, "hello");
      }
    }
}
























