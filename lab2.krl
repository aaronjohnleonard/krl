
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
        ( page:url("query") == "value=hello") => hello=page:url("query") | hello="Monkey";
    }
    {
        notify("notification", hello) with sticky=true;
    }
  }
}
