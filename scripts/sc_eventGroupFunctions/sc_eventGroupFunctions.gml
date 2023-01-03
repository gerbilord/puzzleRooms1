// Open all gates if any button is pressed. Gates do not close if blocked.
function triggerBasicButtonGate(boardManager, objects, objectsThatTriggeredEvents){

	var basicButtons = array_filter(objects, function(object){return object.object_index == obj_basicButton;});
	var basicGates = array_filter(objects, function(object){return object.object_index == obj_basicGate;});
	
	var isAnyButtonPressed = false;
	
	for(var i = 0; i < array_length(basicButtons); i++){
		var buttonToCheck = basicButtons[i];
		if(isCellOccupyed(boardManager.level_grid[buttonToCheck.getBoardX()][buttonToCheck.getBoardY()])){
			isAnyButtonPressed = true;
			if(!buttonToCheck.isPressed){
				buttonToCheck.isPressed = true;
				buttonToCheck.actionStart = boardManager.current_tick;
				buttonToCheck.actionEnd = boardManager.current_tick + 1;
			}
		} else{
			if(buttonToCheck.isPressed){
				buttonToCheck.isPressed = false;
				buttonToCheck.actionStart = boardManager.current_tick;
				buttonToCheck.actionEnd = boardManager.current_tick + 1;
			}
		}
	}
	
	for(var i = 0; i < array_length(basicGates); i++){
		var gateToCheck = basicGates[i];
		if(isAnyButtonPressed){
			if(gateToCheck.isClosed){
				gateToCheck.isClosed = false;
				gateToCheck.actionStart = boardManager.current_tick;
				gateToCheck.actionEnd = boardManager.current_tick + 1;
			}
		} else{
			if(!gateToCheck.isClosed){
				if(!isCellOccupyed(boardManager.level_grid[gateToCheck.getBoardX()][gateToCheck.getBoardY()])){
					gateToCheck.isClosed = true;
					gateToCheck.actionStart = boardManager.current_tick;
					gateToCheck.actionEnd = boardManager.current_tick + 1;
				}
			}
		}
	}
}