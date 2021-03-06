
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
    pre {
      json = findMovie(event:attr("title"));
      output = <<
        Thumbnail : <img id="thumbnail"></img> </br>
        Title : <div id="title"></div></br>
        Release Year : <div id="release"></div></br>
        Synopsis : <div id="synopsis"></div></br>
        Critic Ratings : <div id="ratings"></div></br>
      >>;
      badOutput = << <h3> Sorry no movie with that title was found <h3> >>;

    }
    if (json{"total"} > 0) then {
      replace_inner("#movieInfo", output);
      replace_image_src("#thumbnail", json{["movies", 0, "posters", "thumbnail"]});
      replace_inner("#title",json{["movies", 0 , "title"]});
      replace_inner("#release",json{["movies", 0 , "year"]});
      replace_inner("#synopsis",json{["movies", 0 , "synopsis"]});
      replace_inner("#ratings",json{["movies", 0 , "ratings", "critics_rating"]});
    } always {
      set ent:info json;
    }
  }
  rule submit2{
    select when web submit "#movieForm"
    pre{
      json = ent:info;
      output = << <h3> Sorry no movie with that title was found <h3> >>;
    }
    if (json{"total"} == 0) then {
      replace_inner("#movieInfo", output);
    }
  }
}






















