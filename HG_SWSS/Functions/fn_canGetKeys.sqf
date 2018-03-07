params ["_vehicle","_player"];
private ["_keys", "_returnValue","_GUIDS","_GUID"];

_returnValue = false;

if (!(alive _player)) exitWith { false; };
if (!(_vehicle isKindOf "Car")) exitWith { false; };

//diag_log( format [ "Vehicle: %1; Player: %2", _vehicle, _player ] );

_GUIDS = _vehicle getVariable["DS_GUIDS",[]];
_GUID = getPlayerUID _player;

if (!("ACE_key_customKeyMagazine" in magazines _player)) then {
	if (_player == driver _vehicle) then {
		_returnValue = true;
	};
};

_returnValue;