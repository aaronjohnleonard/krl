
ruleset HelloWorldApp {
  meta {
  }
  rule notify1{
    select when pageview ".*" setting ()
      notify("Notify","You have been notified");
      notify("Notify","You have been notified again");
  }
  rule notify2{
    select when pageview ".*" setting ()
    pre {
      name = page:url("query") => page:url("query") | "Monkey";
    }
    {
        notify("notification", "hello " + name) with sticky=true;
    }
  }
}