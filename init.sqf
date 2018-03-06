DSInteractionObject = objNull;
DSInteractionHandles = [];
DSInteractionLastHookTime = 0;

test = {
	while {true} do {
		[] call HG_fnc_interactionUpdate;
		sleep 0.01;
	};
};

[] spawn test;

_action = ["TestAction","Test Action","ui\keyBlack.paa",{hint "Test";},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
["Car", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
["Car", 1, ["ACE_SelfActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;