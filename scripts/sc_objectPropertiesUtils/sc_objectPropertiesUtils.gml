function isCellOccupyed(cellArray){
	return array_length(getOccupyingObjects(cellArray)) > 0;
}

function getOccupyingObjects(cellArray){
	return array_filter(cellArray, doesObjectOccupyCell);
}

function doesObjectOccupyCell(object){
	var func = variable_instance_exists(object, "doesOccupyCell") ? object.doesOccupyCell: function(){return false};
	return func();
}

function canObjectPush(object){
	var func = variable_instance_exists(object, "canPush") ? object.canPush: function(){return false};
	return func();
}

function canObjectBePushed(object){
	var func = variable_instance_exists(object, "canBePushed") ? object.canBePushed: function(){return false};
	return func();
}

// return if all objects are able to act.
function canObjectsAct(currentTick, arrayOfObjects){
	if(!is_array(arrayOfObjects)){
		throw "canObjectsAct arrayOfObjects is not an array";
	}
	
	for(var i = 0; i < array_length(arrayOfObjects); i++;){
		if(arrayOfObjects[i].actionEnd > currentTick){
			return false;
		}
	}
	return true;
}
