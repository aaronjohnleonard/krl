
ruleset lab3 {
  meta {
  }
  rule show_form{
    select when pageview ".*" setting ()
    pre {
      html = <<
        </br>
        <form id='myForm' onsubmit="return false">
          First Name: <input type="text" name="firstName"><br>
          Last Name: <input type="text" name="lastName"></br>
          <input type="submit" value="Submit">
        </form>
        >>;
    }
    if (not ent:username) then {
      replace_inner("#main", html);
      watch("#myForm", "click");
    }
    fired {
      last;
    }
  }
  rule submit{
    select when web submit "#myForm"
    pre {
      username = event:attr("firstName")+" "+event:attr("lastName");
    }
    every {
      notify("notify","notify");
      replace_html("#myForm", "Hello #{username}");
    }
    fired {
      set ent:username username;
    }
  }
  rule submit{
    select when pageview ".*" setting ()
    pre {
      username = current ent:username;
    }
    append("#main", "Hello, #{username}")
  }
}