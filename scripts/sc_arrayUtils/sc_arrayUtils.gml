/*function array_concat(array1, array2){
	for(var i = 0; i < array_length(array2); i++;){
		array_push(array1, array2[i]);
	}
	return array1;
}*/

// find the first instance and delete it, return the new array.
function array_delete_item(array1, object1){
	for(var i = 0; i < array_length(array1); i++;){
		if(array1[i] == object1){
			array_delete(array1, i, 1);
		}
	}
	return array1;
}

function array_inbounds_2D(array2D, xx, yy){
	var arrayWidth = array_length(array2D)
	if( xx >= 0 && xx < arrayWidth){
		var arrayHeight = array_length(array2D[xx]);
		if(yy >= 0 && yy < arrayHeight){
			return true;
		}
	}
	return false;
}

/*function array_filter(array1, filterFunction){
	var filterArray = [];
	for(var i = 0; i < array_length(array1); i++;){
		if(filterFunction(array1[i])){
			array_push(filterArray, array1[i]);
		}
	}
	return filterArray;
}*/