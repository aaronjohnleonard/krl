
ruleset lab3 {
  meta {
  }
  rule show_form{
    select when pageview ".*" setting ()
    pre {
      html = <<
        </br>
        <form id="myForm" onsubmit="return false">
          First Name: <input type="text" name="firstName"><br>
          Last Name: <input type="text" name="lastName"></br>
          <input type="submit" value="Submit">
        </form>
        >>;
    }
    every{
      replace_inner("#main", html);
      watch("#myForm", "submit");
    }
  }
  rule clearCount{
    select when pageview ".*" setting ()
    if page:url("query").split(re/&/).filter(function(x){x.match(re/clear/)}).length() > 0 then 
      notify ("cleared", "clear");
    fired{
      clear ent:username;
      last;
    }
  }
  rule submit{
    select when web submit "#myForm"
    pre {
      username = event:attr("firstName")+" "+event:attr("lastName");
    }
    after("#myForm", "<p>Hello, #{username}</p>");
    fired {
      set ent:username username;
    }
  }
  rule show_name{
    select when pageview ".*" setting ()
    pre {
      username = current ent:username;
    }
    if (ent:username) then {
      notify ("here","#{username}");
      after("#myForm", "<p>Hello, #{username}</p>");
    }
  }
}