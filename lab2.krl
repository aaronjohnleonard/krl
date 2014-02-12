
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
      names = allNames.append(["name=Monkey"]).filter(function(x){x.match(re/name=/)});
    }
    {
        notify("notification", "hello " + names[0].substr(5)) with sticky=true;
    }
  }
  rule notify3{
    select when pageview ".*" setting ()
    pre {
      count = ent:count + 1
    }
    {
      notify ("notification", count) with sticky=true;
    }
  }
}