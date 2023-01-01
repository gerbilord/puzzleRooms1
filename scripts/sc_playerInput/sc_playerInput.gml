// ACTION LIST
enum Actions {
	NONE,
	UP,
	DOWN,
	LEFT,
	RIGHT,
	PRIMARY,
	SECONDARY
}

function getPlayerMovement() {
	actions = []

	if (keyboard_check(vk_up)){array_push(actions, Actions.UP);}
	if (keyboard_check(vk_down)){array_push(actions, Actions.DOWN);}
	if (keyboard_check(vk_left)){array_push(actions, Actions.LEFT);}
	if (keyboard_check(vk_right)){array_push(actions, Actions.RIGHT);}
	
	if(array_length(actions) == 1)
	{
		return actions;
	}
}