function defineGlobals(){
	defineGlobalConstants();
	defineGlobalStructs();
}

function defineGlobalConstants(){
	global.GRID_SIZE = 64;
	global.FRAME_RATE = 60;
	global.TICKS_PER_SECOND = 8;
	global.TICKS_PER_BASE_ACTION = 2;
	global.MAX_EVENT_GROUPS = 100;
}

function defineGlobalStructs(){
	global.defaultStructs = {};
	global.eventStructs = {};
	
	global.defaultStructs.basic = function(cellX, cellY) constructor {
		boardX = cellX;
		boardY = cellY;
		getBoardX = function(){
			return boardX;
			};
		getBoardY = function(){
			return boardY;
			};
		actionStart = 0;
		actionEnd = 0;
		// doesOccupyCell = function(){return false};
	};
	
	global.defaultStructs.boulder = function(cellX, cellY) constructor {
		boardX = cellX;
		boardY = cellY;
		getBoardX = function(){
			return boardX;
			};
		getBoardY = function(){
			return boardY;
			};
		actionStart = 0;
		actionEnd = 0;
		canPush = function(){return false};
		canBePushed = function(){return true};
		doesOccupyCell = function(){return true};
	};
	
	global.defaultStructs.player = function(cellX, cellY) constructor {
		boardX = cellX;
		boardY = cellY;
		getBoardX = function(){
			return boardX;
			};
		getBoardY = function(){
			return boardY;
			};
		getTicksPerMove = function(){return global.TICKS_PER_BASE_ACTION};
		previousAction = Actions.NONE;
		currentAction = Actions.NONE;
		actionStart = 0;
		actionEnd = 0;
		doesOccupyCell = function(){return true};
		canPush = function(){return true};
		canBePushed = function(){return false};
	};
	
	global.defaultStructs.wall = function(cellX, cellY) constructor {
		boardX = cellX;
		boardY = cellY;
		getBoardX = function(){
			return boardX;
			};
		getBoardY = function(){
			return boardY;
			};
		doesOccupyCell = function(){return true};
		canBePushed = function(){return false};
	}
	
	global.defaultStructs.basicButton = function(cellX, cellY) constructor {
		boardX = cellX;
		boardY = cellY;
		getBoardX = function(){
			return boardX;
			};
		getBoardY = function(){
			return boardY;
			};
		actionStart = 0;
		actionEnd = 0;
		doesOccupyCell = function(){return false};
		canBePushed = function(){return false};
		isPressed = false;
	};
	
	global.defaultStructs.basicGate = function(cellX, cellY) constructor {
		boardX = cellX;
		boardY = cellY;
		getBoardX = function(){
			return boardX;
			};
		getBoardY = function(){
			return boardY;
			};
		actionStart = 0;
		actionEnd = 0;
		doesOccupyCell = function(){return isClosed};
		canBePushed = function(){return false};
		isClosed = true;
		
	};
	
	enum EventGroupTriggers {
		onMove
	};
	
	global.eventStructs.eventTriggerQueueItem = function(theGroupId, theTrigger) constructor {
		eventGroupId = theGroupId;
		objects = [];
		trigger = theTrigger;
	}
	
	global.eventStructs.eventGroup = function(theGroupId) constructor {
		eventGroupId = theGroupId;
		functions = [];
		objects = [];
		triggers = [];
		
		triggerEventGroup = function(boardManager, eventGroupTrigger, objectsThatTriggeredEvents){
			// JANK runs all functions for any trigger which is wrong.
			for(var i = 0; i < array_length(functions); i++) {
				functions[i](boardManager, objects, objectsThatTriggeredEvents);
			}
		}
	}

}