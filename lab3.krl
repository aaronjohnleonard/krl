
ruleset lab3 {
  meta {
  }
  rule show_form{
    select when pageview ".*" setting ()
    pre {
      html = <<
        <form>
          First Name: <input type="text" name="firstName"><br>
          Last Name: <input type="text" name="lastName">
        </form>
        >>
    }
    {
      replace_html("#main", html)
    }
  }
}