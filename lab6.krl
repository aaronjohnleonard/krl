ruleset location_data{
	meta {
    name "Location Data"
    description <<
      Location Data
    >>
    author "Aaron"
    logging off
    provide get_location_data
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
  }
  dispatch {
  }
  global {
    get_location_data = function(key) {
    	ent:test;
    }
  }
  rule add_location_data{
  select when pds new_location_data
  pre{
  	thisMap = ent:myMap;
  	newMap = { event:attr("key") : event:attr("value") }	;
  	thisMap = thisMap.put(newMap);
  }
  always{
  	set ent:myMap thisMap;
  	set ent:test "event worked!";
  }
  }
}