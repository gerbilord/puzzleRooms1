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

	if (keyboard_check(vk_up) || keyboard_check(ord("W"))){array_push(actions, Actions.UP);}
	if (keyboard_check(vk_down)|| keyboard_check(ord("S"))){array_push(actions, Actions.DOWN);}
	if (keyboard_check(vk_left)|| keyboard_check(ord("A"))){array_push(actions, Actions.LEFT);}
	if (keyboard_check(vk_right)|| keyboard_check(ord("D"))){array_push(actions, Actions.RIGHT);}
	
	if(array_length(actions) == 1)
	{
		return actions;
	}
}