params["_player"];

private["_vehicle"];

_vehicle = vehicle player;

_isKeysFound = _vehicle getVariable["keys_found",false];

if (_isKeysFound isEqualTo false) then {
	_vehicle setVariable["keys_found",true];
	[_player, _vehicle, true] call ace_vehiclelock_fnc_addKeyForVehicle;
	hint "You're found a keys for this car";
} else {
	hint "Nothing found";
};

false;