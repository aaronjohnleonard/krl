
ruleset HelloWorldApp {
  meta {
  }
  rule notify1{
    select when pageview ".*" setting ()
      every {
        notify("Notify","You have been notified") with sticky=true;
        notify("Notify","You have been notified again") with sticky=true;
      }
  }
  rule notify2{
    select when pageview ".*" setting ()
    pre {
      name = page:url("query") => page:url("query") | "Monkey";
      names = name.split(re/&/);
    }
    {
        notify("notification", "hello " + names) with sticky=true;
    }
  }
}