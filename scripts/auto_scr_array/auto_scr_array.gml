
/*
	Тестируется в "auto_test_array"
*/


#region modify

function apiArrayFill(array, arrayFill) {
	var size = array_length(arrayFill);
    array_resize(array, size);
	array_copy(array, 0, arrayFill, 0, size);
	return array;
}

/// @function apiArrayPlace(array, index, ...value);
function apiArrayPlace(array, index) {
	var count = argument_count - 2;
	if (count > 0) {
		
		var size = array_length(array);
		if (is_undefined(index)) index = size;
		
		array_resize(array, max(size, index + count));
		for (var i = 0; i < count; i++) array_set(array, index + i, argument[i + 2]);
	}
}

/// @function apiArrayPlaceExt(array, index, ...arrayOrValue);
function apiArrayPlaceExt(array, index) {
	if (argument_count > 2) {
		
		var value, jsize, j, temp;
		var baseSize = array_length(array);
		var size = (is_undefined(index) ? baseSize : index);
		
		for (var i = 2; i < argument_count; i++) {
			value = argument[i];
			
			if (is_array(value)) {
				
				jsize = array_length(value);
				temp  = size + jsize;
				array_resize(array, max(temp, baseSize));
				
				for (j = 0; j < jsize; j++) array_set(array, size + j, value[j]);
				
				size = temp;
			} else {
				
				array_set(array, size, value);
				size += 1;
			}
		}
	}
}

/// @function apiArrayInsertEmpty(array, index, count, _value);
function apiArrayInsertEmpty(array, index, count) {
    if (count > 0) {
		
        var length = array_length(array), size = length - index, _insert = (size > 0);
        array_resize(array, max(length, index + count));
		
        if (_insert) {
			
            var shift = index + count;
            while (size--) array_set(array, size + shift, array_get(array, size + index));
        }
        if (argument_count > 3) {
            if (_insert) {
                
				while (count--) array_set(array, index + count, argument[3]);
                return true;
            }
            
			size = array_length(array);
            length -= 1;
            while (++length < size) array_set(array, length, argument[3]);
        }
        return true;
    }
    return false;
}

function apiArrayShift(array) {
    if (array_length(array)) {
		
        var _value = array_get(array, 0);
        array_delete(array, 0, 1);
        return _value;
    }
    return undefined;
}

/// @function apiArrayUnshift(array, ...value);
function apiArrayUnshift(array) {
    if (apiArrayInsertEmpty(array, 0, argument_count - 1)) {
		
        var i = 0;
        while (++i < argument_count) array_set(array, i - 1, argument[i]);
		
		return (argument_count - 1);
    }
	return 0;
}

function apiArrayShuffle(array) {
    var size = array_length(array);
    if (size > 1) {
		
        var i = -1, swap, j;
        while (++i < size) {
			
            j = irandom(size - 1);
            swap = array_get(array, i);
            array_set(array, i, array_get(array, j));
            array_set(array, j, swap);
        }
	}
}

function apiArrayClear(array) {
	array_resize(array, 0);
}

function apiArrayResizeUp(array, sizeup) {
	array_resize(array, array_length(array) + sizeup);
}

function apiArrayCopy(dest, src, _dest_index, _src_index, _length) {
    var dest_length = array_length(dest);
    var src_length = array_length(src);
    if (is_undefined(dest_length)) _dest_index = dest_length;
    if (is_undefined(_src_index))  _src_index  = 0;
    if (is_undefined(_length)) {
		
		_length = src_length - _src_index;
	} else {
		
		_length = min(_length, src_length - _src_index);
	}
    if (_length > 0) {
		
        array_resize(dest, max(dest_length, _dest_index + _length));
        if (dest == src) {
			
            if (_dest_index == _src_index) exit;
            if (_dest_index > _src_index) {
                while (_length--) array_set(dest, _length + _dest_index, array_get(src, _length + _src_index));
                exit;
            }
        }
        var i = 0;
        do {
            array_set(dest, i + _dest_index, array_get(src, i + _src_index));
        } until (++i == _length);
    }
}

function apiArrayInsert(dest, scr, _dest_index, _src_index, _length) {
    var _dest_length = array_length(dest);
    var _src_length = array_length(scr);
    if (is_undefined(_dest_length)) _dest_index = 0;
    if (is_undefined(_src_index))   _src_index  = 0;
    if (is_undefined(_length)) {
		
		_length = _src_length - _src_index;
	} else {
		
		_length = min(_length, _src_length - _src_index);
	}
    if (_length > 0) {
		
        array_resize(dest, _dest_length + _length);
        var size = _dest_length - _dest_index;
        if (size > 0) {
			
            var _dest_shift = _dest_index + _length;
            if (dest == scr) {
				
                var _temp = array_create(_length), i = -1;
                while (++i < _length)  array_set(_temp, i                 , array_get(scr,   i + _src_index)); i = -1;
                while (size--)         array_set(dest,  size + _dest_index, array_get(dest,  size + _dest_shift));
                while (++i < _length)  array_set(dest,  i + _dest_index   , array_get(_temp, i));
                exit;
            }
            while (size--) array_set(dest, size + _dest_index, array_get(dest, size + _dest_shift));
        }
        while (_length--) array_set(dest, _length + _dest_index, array_get(scr , _length + _src_index));
    }
}

function apiArrayReverse(array) {
	var size = array_length(array);
	if (size > 1) {
        var _swap, i = -1;
        repeat (size div 2) {
            _swap = array_get(array, ++i);
            array_set(array, i, array_get(array, --size));
            array_set(array, size, _swap);
        }
    }
}

function apiArrayRemoveNoOrder(array, index) {
	var size = array_length(array) - 1;
	array_set(array, index, array_get(array, size));
	array_resize(array, size);
}

#endregion

#region build

function apiArrayBuildDup1d(array) {
	return apiArrayFill([], array);
}

function apiArrayBuildReverse(array) {
	var size = array_length(array);
	var _new_array = array_create(size);
	for (var i = 0; i < size; i++) array_set(_new_array, i, array_get(array, --size));
	return _new_array;
}

function apiArrayBuildConcat() {
	var build = [];
	if (argument_count > 0) {
		
		var value, jsize, j, temp, size = 0;
		for (var i = 0; i < argument_count; i++) {
			value = argument[i];
			
			if (is_array(value)) {
				
				jsize = array_length(jsize);
				temp = size + jsize;
				
				array_resize(build, temp);
				
				for (j = 0; j < jsize; j++) array_set(build, size + j, value[j]);
				
				size = temp;
			} else {
				size += 1;
				array_push(build, value);
			}
		}
	}
	return build;
}

/// @function apiArrayBuildRange(size|indexBegin, _indexEnd, _step);
function apiArrayBuildRange() {
	if (argument_count == 0) {
		return [];
	}
	else
	if (argument_count == 1) {
		if (argument[0] > 0) {
			
			return array_build_gen(0, argument[0] - 1, 1, functor_id);
		}
		return [];
	}
	else
	if (argument_count == 2) {
		var step = -real(ComparatorNumber(argument[0], argument[1]));
		return array_build_gen(argument[0], argument[1] - 1, step, functor_id);
	}
	return array_build_gen(argument[0], argument[1] - 1, argument[2], functor_id);
}

#endregion

#region find

function array_find_index(array, value, _reverse, _index, _step) {
	return array_find(array, generator_compare_eq(value), undefined, _reverse, _index, _step);
}

function array_exists(array, value) {
	return (array_find_index(array, value) != -1);
}

#endregion

#region range

function array_range_get(array, index, length) {
	var range = [];
	array_copy(range, 0, array, index, length);
	return range;
}

function array_range_set(array, index, range) {
	array_ext_copy(array, range, index, 0, array_length(range));
}

function array_range_insert(array, index, range) {
	array_ext_insert(array, range, index, 0, array_length(range));
}

#endregion


