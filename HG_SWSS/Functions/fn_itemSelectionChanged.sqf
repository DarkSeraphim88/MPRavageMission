#include "HG_Macros.h"
/*
    Author - HoverGuy
    Description - Called when selection in listbox has changed
    © All Fucks Reserved
*/
params["_ctrl","_index"];
private["_item","_price","_itemClass","_itemType","_itemPicture","_itemDescription"];

disableSerialization;

try 
{
	_item = _ctrl lbData _index;
	_itemClass = [_item] call HG_fnc_getConfig;
	_itemType = [_item] call BIS_fnc_itemType;

	player groupChat (format ["%1", _itemType] );
	player groupChat (format ["%1", _itemClass] );
	//player groupChat (format ["%1", _ctrl] );
	//player groupChat (format ["%1", _index] );

	_price = _ctrl lbValue _index;

	if (_item == "") then {
		HG_WEAPONS_ITEM_PICTURE ctrlSetText "";
		HG_WEAPONS_ITEM_TEXT ctrlSetStructuredText parseText format
		[
			"
				<t align='center' size='1'>Nothing to buy now</t>
			"
		];
	} else {
		_itemPicture = getText(configFile >> _itemClass >> _item >> "Picture");
		_itemDescription = getText(configFile >> _itemClass >> _item >> "descriptionShort");
		
		if (_price < 0) then { _price = -_price };
		
		HG_WEAPONS_ITEM_PICTURE ctrlSetText _itemPicture;
		HG_WEAPONS_ITEM_TEXT ctrlSetStructuredText parseText format
		[
			"
				<t align='center' size='1'>%1<br />Price: %2</t>
			"
			,_itemDescription,_price
		];
	}
} 
catch 
{
	HG_WEAPONS_ITEM_PICTURE ctrlSetText _itemPicture;
	HG_WEAPONS_ITEM_TEXT ctrlSetStructuredText parseText format
	[
		"
			<t align='center' size='1'>Nothing to buy now</t>
		"
	];
};
true;
