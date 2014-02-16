
ruleset lab3 {
  meta {
  }
  rule show_form{
    select when pageview ".*" setting ()
    pre {
      html = <<
        <h1> BIG TEXT <h1>
        >>
    }
    {
      replace_html("#main", html)
    }
  }
}