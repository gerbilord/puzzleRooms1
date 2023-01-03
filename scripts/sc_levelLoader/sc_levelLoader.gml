function convertCellTextToObjects(cellX, cellY, cellTextRaw){
	var string_level_loader_filter_by_whitelist = function(___string)
	{
	    var __whitelist="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_,1234567890:"
	    var __letter=""
	    for(var i=1;i<string_length(___string);i++)
	    {
	        __letter=string_char_at(___string,i);
	        if string_pos(__letter,__whitelist)==0
	        {
	            ___string=string_replace_all(___string,__letter,"");
	        }
	    }
	    return ___string;
	}
	
	// Only ever returns 1 object in an array. Either [object] or [].
	var text_to_object = function(cellX, cellY, cellText)
	{
		var partsOfObject = string_split(cellText, ":", true, 10);
		var numOfParts = array_length(partsOfObject);
		var objectName = "";
		var eventId = -1;
		
		if(numOfParts > 0){
			objectName = partsOfObject[0];	
		}
		if(numOfParts > 1){
			eventId = real(string_digits(partsOfObject[1]));
		}
		
		var objectName = partsOfObject[0];
		
		var cellObject = []; // Only ever return one, but keep array for flexiblilty.
		if(objectName == "player1") {
			// JANK
			var player1 = instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_person1, new global.defaultStructs.player(cellX, cellY));
			array_push(current_objects_controlled_by_player, player1);
			array_push(cellObject, player1);
		} else if(objectName == "player2"){
			// JANK
			var player2 = instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_person2, new global.defaultStructs.player(cellX, cellY));
			// array_push(current_objects_controlled_by_player, player2);
			array_push(cellObject, player2);
		} else if(objectName == "player3"){
			// JANK
			var player3 = instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_person3,  new global.defaultStructs.player(cellX, cellY));
			// array_push(current_objects_controlled_by_player, player3);
			array_push(cellObject, player3);
		} else if(objectName == "boulder"){
			array_push(cellObject, instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_boulder, new global.defaultStructs.boulder(cellX, cellY)));
		} else if(objectName == "goal"){
			array_push(cellObject, instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_goal, new global.defaultStructs.basic(cellX, cellY)));
		} else if(objectName == "wall"){
			array_push(cellObject, instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_wall,  new global.defaultStructs.wall(cellX, cellY)));
		} else if(objectName == "basicGate"){
			array_push(cellObject, instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_basicGate,  new global.defaultStructs.basicGate(cellX, cellY)));
		} else if(objectName == "basicButton"){
			array_push(cellObject, instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_basicButton,  new global.defaultStructs.basicButton(cellX, cellY)));
		}
		
		if(array_length(cellObject) > 0 && eventId > -1){
			cellObject[0].eventGroupId = eventId; // set our newly created object with correct event ID
			array_push(event_groups[eventId].objects, cellObject[0]); // get the event group associated with the id, then push this into its objects
		};
		
		return cellObject;
	}

	var cellText = string_level_loader_filter_by_whitelist(cellTextRaw);
	
	var wordsInCell = string_split(cellText, ",", true);
	
	var objectsInCell = [];

	for(var i = 0; i < array_length(wordsInCell); i++){
		objectsInCell = array_concat(objectsInCell, text_to_object(cellX, cellY, wordsInCell[i]));
	}
	
	return objectsInCell;

}