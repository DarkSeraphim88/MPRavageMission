params ["_vehicle"];
private ["_has_key","_GUIDS","_GUID","_result"];

_has_hey = "ACE_key_customKeyMagazine" in magazines player;

_GUIDS = _vehicle getVariable["DS_GUIDS",[]];
_GUID = getPlayerUID _player;

_result = false;

if (!(_GUID in _GUIDS)) then {
	_result = true;
};

_result;