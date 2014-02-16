
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
    if (not ent:username) then {
      replace_inner("#main", html);
      watch("#myForm", "submit");
    }
    fired {
      last;
    }
  }
  rule respond_submit{
    select when web submit "#myForm"
    notify("notify","notify");
  }
  rule show_name{
    select when pageview ".*" setting ()
    pre {
      username = current ent:username;
    }
    append("#main", "Hello, #{username}")
  }
}