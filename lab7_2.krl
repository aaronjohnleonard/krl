ruleset send_text {
	meta {
    	name "Send Text"
    	description <<
    	THis will send texts when I'm nearby
    	>>
    	author "Aaron"
    	logging off
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
      twilio:send_sms(event:attr("8018704233"), event:attr("3606520305"), event:attr("Wow, this worked..."));
  	}
}