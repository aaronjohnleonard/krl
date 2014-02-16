
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
      watch("#myForm", "submit");
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
    append("#myForm", "Hello #{username}");
    fired {
      set ent:username username;
    }
  }
}