function convertCellTextToObjects(cellX, cellY, cellTextRaw){
	
	cellText = string_lettersdigits(cellTextRaw)
	
	if(cellText == "player1") {
		// JANK
		var player1 = instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_person1, new global.defaultStructs.player(cellX, cellY));
		array_push(current_objects_controlled_by_player, player1);
		return [player1];
	} else if(cellText == "player2"){
		// JANK
		var player2 = instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_person2, new global.defaultStructs.player(cellX, cellY));
		// array_push(current_objects_controlled_by_player, player2);
		return [player2];
	} else if(cellText == "player3"){
		// JANK
		var player3 = instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_person3,  new global.defaultStructs.player(cellX, cellY));
		// array_push(current_objects_controlled_by_player, player3);
		return [player3];
	} else if(cellText == "boulder"){
		return [instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_boulder, new global.defaultStructs.boulder(cellX, cellY))];
	} else if(cellText == "goal"){
		return [instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_goal, new global.defaultStructs.basic(cellX, cellY))];
	} else if(cellText == "wall"){
		return [instance_create_layer(cellX * global.GRID_SIZE, cellY * global.GRID_SIZE, "Instances", obj_wall,  new global.defaultStructs.wall(cellX, cellY))];
	}
	else {
		return [];
	}
}