function getXChangeFromAction(action){
	if(action == Actions.LEFT){
		return -1;
	} 
	if(action == Actions.RIGHT){
		return 1;
	} 
	return 0;
}

function getYChangeFromAction(action){
	if(action == Actions.UP){
		return -1;
	} 
	if(action == Actions.DOWN){
		return 1;
	} 
	return 0;
}