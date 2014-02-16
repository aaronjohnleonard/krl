
ruleset lab3 {
  meta {
  }
  rule show_form{
    select when pageview ".*" setting ()
    pre {
      html = <<
        </br>
        <form id='myForm'>
          First Name: <input type="text" name="firstName"><br>
          Last Name: <input type="text" name="lastName"></br>
          <input type="submit" value="Submit">
        </form>
        >>;
    }
    {
      replace_html("#main", html);
      watch("#myForm", "click");
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
}