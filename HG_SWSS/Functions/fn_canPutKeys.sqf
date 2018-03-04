params ["_vehicle","_player"];
private ["_keys", "_returnValue"];

_returnValue = false;

if (!(alive _player)) exitWith { false; };
if (!(_vehicle isKindOf "Car")) exitWith { false; };

_keys = _vehicle getVariable ["ace_vehiclelock_customkeys",[]];
{
	// Current result is saved in variable _x
	if (_x in (magazinesDetail _player) ) then { _returnValue = true };
} forEach _keys;

_returnValue;