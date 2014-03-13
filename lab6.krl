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
    	thisMap = ent:myMap{key};
    	thisMap.encode();
    }
  }
  rule add_location_data{
  select when pds new_location_data
  pre{
  	thisMap = ent:myMap;
  	key = event:attr("key");
  	value = event:attr("value");
  	otherMap = thisMap.put([key], value);
  }
  always{
  	set ent:myMap otherMap;
  	set ent:val value;
  	set ent:key key;
  }
  }
}