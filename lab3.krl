
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
  rule submit{
    select when web submit "#myForm"
    pre {
      username = event:attr("firstName")+" "+event:attr("lastName");
    }
    every{
      after("#myForm", "Hello #{username}");
      notify("stored name", "hi");
    }
    fired {
      set ent:username username;
    }
  }
  rule notifying{
    select when pageview ".*" setting()
    pre{

    }
    notify("here","here");
    
  }
  rule show_name{
    select when pageview ".*" setting ()
    pre {
      username = ent:username;
    }
    every {
      notify ("here","here");
      after("#myForm", "#{username}");
    }
  }
  rule clearCount{
    select when pageview ".*" setting ()
    if page:url("query").split(re/&/).filter(function(x){x.match(re/clear/)}).length() > 0 then 
      notify ("cleared", "clear");
    fired{
      clear ent:username;
    }
  }
}