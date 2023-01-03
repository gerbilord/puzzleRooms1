// STATIC VARIABLES
defineGlobals();

// LOAD LEVEL FILE
file_grid = load_csv(levelFile)
level_width = ds_grid_width(file_grid);
level_height = ds_grid_height(file_grid);

// PARSE LEVEL FILE INTO OBJECT GRID
level_grid[level_width-1][level_height-1] = []


// DEFINE SPECIAL LISTS
clone_actions = [] // array of actions
current_player_action_history = [] // list of actions
current_objects_controlled_by_player = [] // list of objects that will act on player input
event_groups = create_array_with_initializer(100, function(iValue){
	var newEventGroup = new global.eventStructs.eventGroup(iValue);
	array_push(newEventGroup.functions, triggerBasicButtonGate);
	return newEventGroup;
	});
current_event_triggers = [];


current_tick = 0; // tick and turn are the same thing.

for (var i = 0; i < level_width; i++;)
{
    for (var j = 0; j < level_height; j++;)
    {
        level_grid[i][j] = convertCellTextToObjects(i, j,  string(file_grid[# i, j]));
    }
}

tickSystem = time_source_create(time_source_game, 1/global.TICKS_PER_SECOND, time_source_units_seconds, handleTick, [self], -1);
time_source_start(tickSystem);