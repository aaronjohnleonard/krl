
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
      allNames = page:url("query").split(re/&/);
      names = allNames.filter(function(x){x.match(re/name=/)});
    }
    {
        notify("notification", "hello " + names) with sticky=true;
    }
  }
}