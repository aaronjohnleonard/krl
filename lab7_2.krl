ruleset send_text {
	meta {
        key twilio {"account_sid" : "AC0884af1dd8f5d21d96239238558a056c",
                    "auth_token"  : "2c1e24966e48e23ee3ac1885ec082b97"
                    }

        use module a8x115 alias twilio with twiliokeys = keys:twilio()
  	}
  	rule send_text{
  		select when explicit location_nearby
  		pre{
  			dist = event:attr("distance");
  		}
  		{
			send_directives("hello");
			twilio:send_sms("8018704233", "3852356308", "this distance = " + dist);
    	}
  	}
}