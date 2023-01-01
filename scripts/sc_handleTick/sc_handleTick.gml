function handleTick(boardManager){
	with(boardManager){
	playerInputMovement = getPlayerMovement();
	array_push(current_player_action_history, playerInputMovement);
	
	var currentActionInput = Actions.NONE;
	if(array_length(playerInputMovement) == 1){
		currentActionInput = playerInputMovement[0];
	}
	
	if(currentActionInput != Actions.NONE){
		var requestedActions = getRequestedActions(boardManager, currentActionInput);
		resolveRequestedActions(boardManager, requestedActions);
	}

	current_tick++;
	}
}

function getRequestedActions(boardManager, requestedAction){
	with(boardManager){
		var requestedActions = [];
		for(var i = 0; i < array_length(current_objects_controlled_by_player); i++;){
			var playerControlledObject = current_objects_controlled_by_player[i];
			if(canObjectsAct(current_tick, [playerControlledObject])){
				array_push(requestedActions, {requestingObject: playerControlledObject, requestedAction: requestedAction});
			}
		}
		return requestedActions;
	}
}

function resolveRequestedActions(boardManager, requestedActions){
	with(boardManager){
		var failedActions = [];
		var succeededActions = [];
		
		while(array_length(requestedActions)>0){
			show_debug_message(requestedActions);
			var requestedAction = requestedActions[0];
			array_delete(requestedActions, 0, 1);
			
			if(resolveRequestedAction(boardManager, requestedAction)){
				array_push(succeededActions, requestedAction);
				requestedActions = array_concat(failedActions, requestedActions);
			}
			else{
				array_push(failedActions, requestedAction);
			}
		}
		/*
		if(currentAction == Actions.DOWN){
		var totalObjs = array_length(current_objects_controlled_by_player);
		
		for(var i = 0; i< totalObjs; i++;){
			current_objects_controlled_by_player[i].y += global.GRID_SIZE; 
		}
	}
	
		if(currentAction == Actions.UP){
		var totalObjs = array_length(current_objects_controlled_by_player);
		
		for(var i = 0; i< totalObjs; i++;){
			current_objects_controlled_by_player[i].y -= global.GRID_SIZE; 
		}
	}
	
		if(currentAction == Actions.LEFT){
		var totalObjs = array_length(current_objects_controlled_by_player);
		
		for(var i = 0; i< totalObjs; i++;){
			current_objects_controlled_by_player[i].x -= global.GRID_SIZE; 
		}
	}
		if(currentAction == Actions.RIGHT){
		var totalObjs = array_length(current_objects_controlled_by_player);
		
		for(var i = 0; i< totalObjs; i++;){
			current_objects_controlled_by_player[i].x += global.GRID_SIZE; 
		}
	}
	*/
	}
}

// Handles all possible actions
function resolveRequestedAction(boardManager, requestedAction){
	with(boardManager){
		var actionObject = requestedAction.requestingObject;
		var action = requestedAction.requestedAction;

		if(action == Actions.UP 
			|| action == Actions.DOWN
			|| action == Actions.RIGHT
			|| action == Actions.LEFT){
				return resolveMoveAction(boardManager, requestedAction);
			}
	}
}

function resolveMoveAction(boardManager, requestedMoveAction){
	with(boardManager){
		if(isMoveActionValid(boardManager, requestedMoveAction)){
			doMoveAction(boardManager, requestedMoveAction);
			return true;
		} 
		if(isPushValid(boardManager, requestedMoveAction)){
			doPushAction(boardManager, requestedMoveAction);
			return true;
		}
		return false;
	}
}

function isMoveActionValid(boardManager, requestedMoveAction){
	with(boardManager){
		if(doesObjectOccupyCell(requestedMoveAction.requestingObject)){
			var newX = requestedMoveAction.requestingObject.getBoardX() + getXChangeFromAction(requestedMoveAction.requestedAction);
			var newY = requestedMoveAction.requestingObject.getBoardY() + getYChangeFromAction(requestedMoveAction.requestedAction);
			if(!isCellOccupyed(level_grid[newX][newY])){
				return true;
			} else {
				return false;
			}
		} 
		return true;
	}
}

function doPushAction(boardManager, reuqestingMoveAction){
	with(boardManager){
		var pushingObject = reuqestingMoveAction.requestingObject;
		var moverNewX = reuqestingMoveAction.requestingObject.getBoardX() + getXChangeFromAction(reuqestingMoveAction.requestedAction);
		var moverNewY = reuqestingMoveAction.requestingObject.getBoardY() + getYChangeFromAction(reuqestingMoveAction.requestedAction);
		
		var objectInWay = getOccupyingObjects(level_grid[moverNewX][moverNewY])[0]; // JANK assume 1 object in way only possible
		
		var moveeNewX = reuqestingMoveAction.requestingObject.getBoardX() + getXChangeFromAction(reuqestingMoveAction.requestedAction) * 2;
		var moveeNewY = reuqestingMoveAction.requestingObject.getBoardY() + getYChangeFromAction(reuqestingMoveAction.requestedAction) * 2;
		
		moveObject(boardManager, pushingObject, moverNewX, moverNewY);
		moveObject(boardManager, objectInWay, moveeNewX, moveeNewY);
		
		pushingObject.actionStart = current_tick;
		objectInWay.actionStart = current_tick;
		pushingObject.actionEnd = current_tick + pushingObject.getTicksPerMove() * 2;
		objectInWay.actionEnd = pushingObject.actionEnd;
	}
}

function isPushValid(boardManager, requestedMoveAction){
	with(boardManager){
		
		var moverNewX = requestedMoveAction.requestingObject.getBoardX() + getXChangeFromAction(requestedMoveAction.requestedAction);
		var moverNewY = requestedMoveAction.requestingObject.getBoardY() + getYChangeFromAction(requestedMoveAction.requestedAction);
		
		var objectInWay = getOccupyingObjects(level_grid[moverNewX][moverNewY])[0]; // JANK assume 1 object in way only possible
		
		if(canObjectBePushed(objectInWay) && canObjectPush(requestedMoveAction.requestingObject) && canObjectsAct(current_tick, [objectInWay])){
			var moveeNewX = requestedMoveAction.requestingObject.getBoardX() + getXChangeFromAction(requestedMoveAction.requestedAction) * 2;
			var moveeNewY = requestedMoveAction.requestingObject.getBoardY() + getYChangeFromAction(requestedMoveAction.requestedAction) * 2;
			if(array_inbounds_2D(level_grid, moveeNewX, moveeNewY) && !isCellOccupyed(level_grid[moveeNewX][moveeNewY])){
				return true;
			}
		}

		return false;
	}
}

// Does not check for collision, just does the actual movement.
function doMoveAction(boardManager, requestedAction){
		with(boardManager){
		var actionObject = requestedAction.requestingObject;
		var action = requestedAction.requestedAction;
		

		var boardX = actionObject.getBoardX();
		var boardY = actionObject.getBoardY();
		
		var xChange = getXChangeFromAction(action);
		var yChange = getYChangeFromAction(action);
		
		var newX = boardX + xChange;
		var newY = boardY + yChange;
		
		if(array_inbounds_2D(level_grid, newX, newY)){
			actionObject.actionStart = current_tick;
			actionObject.actionEnd = current_tick + actionObject.getTicksPerMove();
			moveObject(boardManager, actionObject, newX, newY);
		}
	}
}

// The lowest level move, it moves the object from one cell to another no checks. Nothing else.
function moveObject(boardManager, objectToMove, newX, newY){
	with(boardManager){
		var oldX = objectToMove.getBoardX();
		var oldY = objectToMove.getBoardY();
		
		level_grid[oldX][oldY] = array_delete_item(level_grid[oldX][oldY], objectToMove);
		array_push(level_grid[newX][newY], objectToMove);
		
		objectToMove.boardX = newX;
		objectToMove.boardY = newY;
	}
}
