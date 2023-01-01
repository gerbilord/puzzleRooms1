/// @description Insert description here
// You can write your code in this editor

function debugLevelFile(){
	var xx = 32;
	var yy = 32;
	for (var i = 0; i < level_width; i++;)
	{
	    for (var j = 0; j < level_height; j++;)
	    {
	        draw_text(xx, yy, string(file_grid[# i, j]));
	        yy += 32;
	    }
	    yy = 32;
	    xx += 32;
	}
}

function drawTick() {
	draw_text(32, 32, string(current_tick));
}

drawTick();