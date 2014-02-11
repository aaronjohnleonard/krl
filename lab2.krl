
ruleset Lab2 {
    meta {
        name "notifications"
        author "Aaron Leonard"
        logging off
    }
    dispatch {
        // 
    }
    rule first_rule {
        select when pageview ".*" setting ()
        // Display notification that will not fade.
        notify("Notification", "Here is your notification.") with sticky = true;
    }
}