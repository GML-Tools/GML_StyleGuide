
window_set_size(1366, 768);

timers = new ApiTimerHandler();

timer = timers.append(new ApiTimerAsyncTimeout(500, 
	function() {
		show_debug_message("end");
	},
	function() {
		show_debug_message(" << end");
	})
);

timers.append(new ApiTimerAsyncTimeout(5000, 
	function() {
		show_debug_message("hello");
	},
	function() {
		show_debug_message(" << hello");
	})
);

timer.rem();
timers.clear();
