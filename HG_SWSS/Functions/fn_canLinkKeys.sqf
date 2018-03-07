params ["_vehicle","_player"];
private ["_keys", "_returnValue"];

_returnValue = false;

if (!(alive _player)) exitWith { false; };
if (!(_vehicle isKindOf "Car")) exitWith { false; };

if (
	("ACE_key_customKeyMagazine" in magazines _player) and 
	!(getPlayerUID _player in _vehicle getVariable ["DS_GUIDS", []]) and
	_player == driver _vehicle _player
	) then {
	_returnValue = true;
};

_returnValue;