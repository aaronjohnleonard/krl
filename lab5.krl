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
  rule HelloWorld is active {
    select when web cloudAppSelected
    pre {
      my_html = <<
        </br>
        <h1>Foursquare</h1>
        <div id="insertHere"></div>
      >>;
  		input = <<INPUT2>>;
    }
    {
      SquareTag:inject_styling();
      CloudRain:createLoadPanel("Foursquare!", {}, my_html);
  		replace_inner("#insertHere",input);
    }
  }
  rule process_fs_checkin {
  	select when foursquare checkin
  	pre {
  		input = <<INPUT>>;
  	}
  	{
  		replace_inner("#insertHere",input);
  	}
  }
}