params["_player"];
private["_vehicle", "_GUID", "_GUIDS"];

_vehicle = vehicle player;

_GUIDS = _vehicle getVariable["DS_GUIDS",[]];
_GUID = getPlayerUID _player;

if (!(_GUID in _GUIDS)) then {
	_GUIDS = _GUIDS + [_GUID];
	_vehicle setVariable ["DS_GUIDS", _GUIDS];
};

if (!( "ACE_key_customKeyMagazine" in magazines _player)) then {
	_player addItem "ACE_key_customKeyMagazine";
};
/*
if (_isKeysFound isEqualTo false) then {
	_vehicle setVariable["keys_found",true];
	[_player, _vehicle, true] call ace_vehiclelock_fnc_addKeyForVehicle;
	hint "You're found a keys for this car";
} else {
	hint "Nothing found";
};
*/
false;