

#region class

function ApiLListT() : ApiLListO() constructor {
	
	#region __private
	
	self.__lst = undefined;
	
	static __build = function(_value, _next, _prev) {
		
		return [_value, _next, _prev];
	}
	
	#endregion
	
	static insBegin = function(_value) {
		
		_value = self.__build(_value, self.__fst, undefined);
		
		if (self.__lst == undefined) {
			
			self.__lst = _value;
		}
		else {
			
			self.__fst[@ __API_LINK_LIST.PREV] = _value;
		}
		
		self.__fst = _value;
		return self.__fst;
	}
	
	static insEnd = function(_value) {
		
		_value = self.__build(_value, undefined, self.__lst);
		
		if (self.__fst == undefined) {
			
			self.__fst = _value;
		}
		else {
			
			self.__lst[@ __API_LINK_LIST.NEXT] = _value;
		}
		
		self.__lst = _value;
		return self.__lst;
	}
	
	static insAfter = function(_value, _cell) {
		
		_value = self.__build(value, _cell[__API_LINK_LIST.NEXT], _cell);
		_cell[@ __API_LINK_LIST.NEXT] = _value;
		
		if (_cell == self.__lst) {
			
			self.__lst = _cell;
		}
		
		return _value;
	}
	
	static insBefore = function(_value, _cell) {
		
		_value = self.__build(_value, _cell, _cell[__API_LINK_LIST.PREV]);
		_cell[@ __API_LINK_LIST.PREV] = _value;
		
		if (_cell == self.__fst) {
			
			self.__fst = _cell;
		}
		
		return _value;
	}
	
	static popBegin = function() {
		
		var _value = self.__fst;
		self.__fst = _value[__API_LINK_LIST.NEXT];
		
		if (self.__fst == undefined) {
			
			self.__lst = undefined;
		}
		else {
			
			self.__fst[@ __API_LINK_LIST.PREV] = undefined;
		}
		
		return _value;
	}
	
	static topEnd = function() {
		
		return self.__lst;
	}
	
	static popEnd = function() {
		
		var _value = self.__lst;
		self.__lst = _value[__API_LINK_LIST.PREV];
		
		if (self.__lst == undefined) {
			
			self.__fst = undefined;
		}
		else {
			
			self.__lst[@ __API_LINK_LIST.NEXT] = undefined;
		}
		
		return _value;
	}
	
	static rem = function(_cell) {
		
		var _next = _cell[__API_LINK_LIST.NEXT];
		var _prev = _cell[__API_LINK_LIST.PREV];
		
		if (_next != undefined) {
			
			_next[@ __API_LINK_LIST.PREV] = _prev;
		}
		else {
			
			self.__lst = _prev;
		}
		
		if (_prev != undefined) {
			
			_prev[@ __API_LINK_LIST.NEXT] = _next;
		}
		else {
			
			self.__fst = _next;
		}
	}
	
	static swpRef = function(_cell1, _cell2) {
		
		if (_cell1 == _cell2) exit;
		
		var _prev1 = _cell1[__API_LINK_LIST.PREV];
		var _next1 = _cell1[__API_LINK_LIST.NEXT];
		var _prev2 = _cell2[__API_LINK_LIST.PREV];
		var _next2 = _cell2[__API_LINK_LIST.NEXT];
		
		_cell1[@ __API_LINK_LIST.PREV] = _prev2;
		_cell1[@ __API_LINK_LIST.NEXT] = _next2;
		_cell2[@ __API_LINK_LIST.PREV] = _prev1;
		_cell2[@ __API_LINK_LIST.NEXT] = _next1;
		
		if (_prev1 != undefined)
			_prev1[@ __API_LINK_LIST.NEXT] = _cell2;
		
		if (_next1 != undefined)
			_next1[@ __API_LINK_LIST.PREV] = _cell2;
		
		if (_prev2 != undefined)
			_prev2[@ __API_LINK_LIST.NEXT] = _cell1;
		
		if (_next2 != undefined)
			_next2[@ __API_LINK_LIST.PREV] = _cell1;
		
		if (_cell1 == self.__fst) {
			
			self.__fst = _cell2;
		}
		else
		if (_cell2 == self.__fst) {
			
			self.__fst = _cell1;
		}
		
		if (_cell1 == self.__lst) {
			
			self.__lst = _cell2;
		}
		else
		if (_cell2 == self.__lst) {
			
			self.__lst = _cell1;
		}
	}
	
	static clear = function() {
		
		self.__fst = undefined;
		self.__lst = undefined;
	}
	
	static toClone = function(_f=apiFunctorId, _data) {
		
		var _clone = new ApiLListT();
		var _cell = self.__fst;
		if (_cell != undefined) {
			
			var _ceilBuild = _clone.insBegin(_f(_cell[__API_LINK_LIST.VALUE], _data));
			_cell          = _cell[__API_LINK_LIST.NEXT];
			
			while (_cell != undefined) {
				
				_ceilBuild = _clone.insAfter(_f(_cell[__API_LINK_LIST.VALUE], _data), _ceilBuild);
				_cell      = _cell[__API_LINK_LIST.NEXT];
			}
		}
		return _clone;
	}
	
}

#endregion

#region functions

function apiLListTGetPrev(_cell) {
		
	return _cell[__API_LINK_LIST.PREV];
}

#endregion
