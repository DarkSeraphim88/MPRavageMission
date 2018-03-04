/*
    Author - HoverGuy
    © All Fucks Reserved
*/
if(!hasInterface) exitWith {}; // If headless then exit
params["_player"];

/*
    Init money variable
*/
if((getNumber(missionConfigFile >> "CfgClient" >> "enableSave")) isEqualTo 1) then
{
    if((isNil {profileNamespace getVariable "HG_Save"}) OR ((getNumber(missionConfigFile >> "CfgClient" >> "resetSavedMoney")) isEqualTo 1)) then
	{
	    profileNamespace setVariable["HG_Save",(getNumber(missionConfigFile >> "CfgClient" >> "HG_MoneyCfg" >> (rank _player) >> "startCash"))];
	};
} else {
    _player setVariable["HG_myCash",(getNumber(missionConfigFile >> "CfgClient" >> "HG_MoneyCfg" >> (rank _player) >> "startCash"))];
};

/*
    Add action to player
*/
//_player addAction["<img image='HG_SWSS\UI\gun.paa' size='1.5'/><t color='#FF0000'>Open Weapons Shop</t>",{_this call HG_fnc_dialogOnLoadItems},"HG_DefaultShop",0,false,false,"",'(alive player) && !dialog'];
_player addAction["<img image='HG_SWSS\UI\money.paa' size='1.5'/><t color='#FF0000'>Give Money</t>",{HG_CURSOR_OBJECT = cursorObject; createDialog "HG_GiveMoney"},"",0,false,false,"",'(alive player) AND (cursorObject isKindOf "Man") AND (alive cursorObject) AND (player distance cursorObject < 2) AND !dialog'];
_player addAction["<t color='#FFFFFF'>Search for keys</t>",{_this call HG_fnc_searchForKeys},"",0,false,false,"",'(alive player) AND (vehicle player != player) AND (player == driver vehicle player)'];
_player addAction["<t color='#FFFFFF'>Hide keys in vehicle</t>",{[cursorObject, _this] call HG_fnc_hideKeysInVehicle},"",0,false,false,"",'[cursorObject,_this] call HG_fnc_canPutKeys'];
_player addAction["<t color='#FFFFFF'>Take keys from vehicle</t>",{[cursorObject, _this] call HG_fnc_takeKeysFromVehicle},"",0,false,false,"",'(alive player) AND (cursorObject isKindOf "Car") AND (cursorObject getVariable ["DS_Owner_GUID",""] isEqualTo getPlayerUID player)'];

/*
    Init HUD if applicable
*/
if((getNumber(missionConfigFile >> "CfgClient" >> "enableHUD")) isEqualTo 1) then
{
    [0] call HG_fnc_HUD;
};

/*
    Init paycheck thread if applicable
*/
if((getNumber(missionConfigFile >> "CfgClient" >> "enablePaycheck")) isEqualTo 1) then
{
	HG_PAYCHECK_THREAD = [] spawn HG_fnc_paycheck;
	_player addEventHandler
    [
        "Respawn",
        {
            if(scriptDone HG_PAYCHECK_THREAD) then 
	        {
	            HG_PAYCHECK_THREAD = [] spawn HG_fnc_paycheck;
	        }
	    }
    ];
};
