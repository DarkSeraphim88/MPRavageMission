DSInteractionObject = objNull;
DSInteractionHandles = [];
DSInteractionLastHookTime = 0;

private ["_month", "_day", "_hour", "_minute" ];
_month = (floor random 11) + 1;
_day = (floor random 27) + 1;
_hour = floor random 23;
_minute = floor random 59;

setDate [2018, _month, _day, _hour, _minute];

[] spawn {
	while {true} do {
		[] call HG_fnc_interactionUpdate;
		sleep 0.01;
	};
};

"MPRavage" execVM "vehicleSpawnerAndSaver.sqf";

private ["_lockAction", "_unlockAction"];

_lockAction = ["DSLockAction","Lock vehicle","ui\keyBlack.paa",{(_this select 0) lock true;},{((locked (_this select 0)) isEqualTo 1) and (((_this select 0)) call HG_fnc_canUnLock)},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
_unlockAction = ["DSUnlockAction","Unlock vehicle","ui\keyBlack.paa",{(_this select 0) lock false;},{((locked (_this select 0)) isEqualTo 2) and (((_this select 0)) call HG_fnc_canUnLock)},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

["Car", 0, ["ACE_MainActions"], _lockAction, true] call ace_interact_menu_fnc_addActionToClass;
["Car", 1, ["ACE_SelfActions"], _lockAction, true] call ace_interact_menu_fnc_addActionToClass;

["Car", 0, ["ACE_MainActions"], _unlockAction, true] call ace_interact_menu_fnc_addActionToClass;
["Car", 1, ["ACE_SelfActions"], _unlockAction, true] call ace_interact_menu_fnc_addActionToClass;