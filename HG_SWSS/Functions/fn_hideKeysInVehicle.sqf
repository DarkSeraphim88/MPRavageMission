params ["_vehicle","_player"];
private ["_GUID", "_keys"];

_GUID = getPlayerUID (_player select 0);
_keys = _vehicle getVariable ["ace_vehiclelock_customkeys",[]];
{
	diag_log format ["_x = %1", _x ];
	
	{
		// Current result is saved in variable _x
		_player removeItem _x;
	} forEach _x;
} forEach _keys;
_vehicle setVariable ["DS_OwnerGUID", _GUID];

false;