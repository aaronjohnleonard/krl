ruleset send_text {
	meta {
        key twilio {"account_sid" : “AC0884af1dd8f5d21d96239238558a056c",
                    "auth_token"  : “2c1e24966e48e23ee3ac1885ec082b97"
                    }
    	name "Send Text"
    	description <<
    	THis will send texts when I'm nearby
    	>>
    	author "Aaron"
    	logging off
         
        use module a8x115 alias twilio with twiliokeys = keys:twilio()
    	use module b505201x5 alias location_data
    	use module a169x676 alias pds
    	use module a169x701 alias CloudRain
    	use module a41x186  alias SquareTag
  	}
  	dispatch {
  	}
  	global {
  	}
  	rule send_text{
  	select when location nearby
      twilio:send_sms(event:attr("8018704233"), event:attr("3852356308"), event:attr("Wow, this worked..."));
  	}
}