
ruleset HelloWorldApp {
  meta {
  }
  rule notify1{
    select when pageview ".*" setting ()
      notify("Notify","You have been notified")
  }
  rule notify2{
    select when pageview ".*" setting ()
    pre {
      hello = page:url("query") => page:url("query") | "Monkey";
    }
    {
        notify("notification", hello) with sticky=true;
    }
  }
}