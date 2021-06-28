
//
if (variable_global_exists("__apiLoaderBase")) exit;

//
global.__apiLoaderBase = { 
	api: ds_priority_create(), 
	project: ds_priority_create()
};

//
function apiLoader(_intPriority, _loader) {
	
	apiScrLoader();
	ds_priority_add(global.__apiLoaderBase.project, _loader, _intPriority);
}

function __apiLoader(_intPriority, _loader) {
	
	apiScrLoader();
	ds_priority_add(global.__apiLoaderBase.api, _loader, _intPriority);
}

function __apiLoaderLoad() {
	var _heap;
	
	_heap = global.__apiLoaderBase.api;
	while (!ds_priority_empty(_heap)) {
		ds_priority_delete_min(_heap)();
	}
	ds_priority_destroy(_heap);
	
	_heap = global.__apiLoaderBase.project;
	while (!ds_priority_empty(_heap)) {
		ds_priority_delete_min(_heap)();
	}
	ds_priority_destroy(_heap);
}













