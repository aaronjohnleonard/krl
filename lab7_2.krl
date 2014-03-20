ruleset send_text {
  	rule send_text{
  	select when location nearby
      send_directive("hello");
      //twilio:send_sms("8018704233", "3852356308", "Wow, this worked...l");
  	}
}