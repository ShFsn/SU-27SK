######################## Disable VHF comms by default #############################
settimer(func() {
	props.globals.getNode("instrumentation/comm[0]/serviceable").setBoolValue(0);
	props.globals.getNode("instrumentation/comm[1]/serviceable").setBoolValue(0);
	props.globals.getNode("instrumentation/comm[0]/frequencies/selected-mhz").setDoubleValue(0.0);
	props.globals.getNode("instrumentation/comm[1]/frequencies/selected-mhz").setDoubleValue(0.0);
	props.globals.getNode("controls/lighting/landing-lights").setBoolValue(0);
}, 1);

######################### Direct Mode tooltip ##############################
var sdu_10 = props.globals.getNode("su-27/SDU-10/active", 1);
var help_win = screen.window.new( 0, 0, 1, 5 );
help_win.fg = [0,1,1,1];
setlistener(sdu_10.getPath(), func() {
	if (sdu_10.getValue()) help_win.write(sprintf("Direct Mode: OFF"));
	else help_win.write(sprintf("Direct Mode: ON"));
}, 0, 0);

########################### Load exterior model on startup ##########################
setlistener("sim/signals/fdm-initialized", func {
	     settimer( func() {
	     	setprop("/sim/current-view/view-number", 1);
	     	settimer( func() {
	     		setprop("/sim/current-view/view-number", 0);
	     		}, 0.1);
	     	}, 0.1);
	    });
