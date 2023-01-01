for (var i = 0; i < level_width; i++;)
{
    for (var j = 0; j < level_height; j++;)
    {
        var thingsToMove = level_grid[i][j];
		
		for(var k = 0; k < array_length(thingsToMove); k++){
			var thingToMove = thingsToMove[k];
			thingToMove.x = i * global.GRID_SIZE;
			thingToMove.y = j * global.GRID_SIZE;
		}
    }
}