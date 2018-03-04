#include "HG_Macros.h"
/*
    Author - HoverGuy
    Description - Called when you click "Buy" button in dialog
    © All Fucks Reserved
*/
private "_price", "_sItem", "_itemType";

disableSerialization;

_price = HG_WEAPONS_ITEM_LIST lbValue (lbCurSel HG_WEAPONS_ITEM_LIST);

//player groupChat (format ["%1", _itemType] );

if (_price >= 0) then {
	if([_price] call HG_fnc_hasEnoughMoney) then
	{
		private "_selectedItem";
		_selectedItem = HG_WEAPONS_ITEM_LIST lbData (lbCurSel HG_WEAPONS_ITEM_LIST);
		if([_selectedItem,true] call HG_fnc_handleItems) then
		{
			private["_itemClass","_displayName"];
			_itemClass = [_selectedItem] call HG_fnc_getConfig;
			_displayName = getText(configFile >> _itemClass >> _selectedItem >> "displayName");
			[_price,1] call HG_fnc_addOrSubCash;
			hint format[(localize "STR_HG_ITEM_BOUGHT"),_displayName,[_price] call BIS_fnc_numberText,(getText(missionConfigFile >> "CfgClient" >> "currencyType"))];
		};
	} else {
		hint format[(localize "STR_HG_NOT_ENOUGH_MONEY"),[_price] call BIS_fnc_numberText,[(player getVariable "HG_myCash")] call BIS_fnc_numberText,(getText(missionConfigFile >> "CfgClient" >> "currencyType"))];
	};
} else {
	private "_selectedItem";
	_selectedItem = HG_WEAPONS_ITEM_LIST lbData (lbCurSel HG_WEAPONS_ITEM_LIST);
	[_selectedItem,false] call HG_fnc_handleItems;
	[_price,1] call HG_fnc_addOrSubCash;
	
	[((findDisplay 5000) displayCtrl 5004), 0] call HG_fnc_xItemSelectionChanged;
};

true;
