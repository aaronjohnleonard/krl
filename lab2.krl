
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
    foreach names setting (name)
    pre {
      allNames = page:url("query").split(re/&/);
      names = allNames.filter(function(x){x.match(re/name=/)});
      length1 = allNames.length();
      length2 = names.length()
    }
    {
        notify("notification", "hello " + length1 + length2) with sticky=true;
    }
  }
}