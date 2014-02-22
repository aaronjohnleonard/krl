
ruleset HelloWorldApp {
  meta {
    name "Hello World"
    description <<
      Hello World
    >>
    author ""
    logging off
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
  }
  dispatch {
  }
  global {
    findMovie = function(query) {
      http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json",
                    {"apikey":"mgnbn7adagrz2pqxhrqnr36u",
                     "q" : query,
                     "page_limit":"1"}).pick("$.content").decode();
    }
  }
  rule HelloWorld is active {
    select when web cloudAppSelected
    pre {
      my_html = <<
        </br>
        <div id="movieInfo"></div>
        <form id="movieForm" onsubmit="return false">
          Movie Title: <input type="text" name="title"><br>
          <input type="submit" value="Search!">
        </form>
      >>;
    }
    {
      SquareTag:inject_styling();
      CloudRain:createLoadPanel("Hello World!", {}, my_html);
      watch("#movieForm", "submit");
    }
  }
  rule submit{
    select when web submit "#movieForm"
    {
      notify("asd","query");
    }
  }
}