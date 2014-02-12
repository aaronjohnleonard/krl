
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
    foreach page:url("query").split(re/&/) setting (name)

    {
        notify("notification", "hello " + name) with sticky=true;
    }
  }
}