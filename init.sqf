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

private ["_lockAction", "_unlockAction"];

_lockAction = ["DSLockAction","Lock vehicle","ui\keyBlack.paa",{_this lock true;},{(locked _this) isEqualTo 1},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
_unlockAction = ["DSUnlockAction","Unlock vehicle","ui\keyBlack.paa",{_this lock false;},{(locked _this) isEqualTo 2},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
["Car", 0, ["ACE_MainActions"], _lockAction, true] call ace_interact_menu_fnc_addActionToClass;
["Car", 1, ["ACE_SelfActions"], _lockAction, true] call ace_interact_menu_fnc_addActionToClass;

["Car", 0, ["ACE_MainActions"], _unlockAction, true] call ace_interact_menu_fnc_addActionToClass;
["Car", 1, ["ACE_SelfActions"], _unlockAction, true] call ace_interact_menu_fnc_addActionToClass;