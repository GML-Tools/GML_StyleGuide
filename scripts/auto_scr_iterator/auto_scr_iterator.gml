
// f = function(index, count, data)
function apiIteratorRange(f, data) {
	if (argument_count == 3) {
		var i = 0, j = argument[2], step = 1;
	} 
	else
	if (argument_count == 4) {
		var i = argument[2], j = argument[3], step = 1;
	} 
	else {
		var i = argument[2], j = argument[3], step = argument[4];
	}
	if (sign(j - i) == sign(step)) {
		var count = 0;
		while (i <= j) {
			
			f(i, count++, data);
			i += step;
		}
	}
}


