#include "HG_Macros.h"
/*
    Author - HoverGuy
    Description - Called when selection in xListbox has changed
    © All Fucks Reserved
*/
params["_ctrl","_index"];
private["_shopType","_shopItems","_itemClass","_itemName","_ind","_itemType","_price","_typeOfShop"];

//player groupChat (format ["%1", _ctrl] );
//player groupChat (format ["%1", _index] );

disableSerialization;

_shopType = _ctrl lbData _index;
_shopType = _shopType splitString "/";

if ((_shopType select 1) == "Sell" ) then {
	_shopItems = (uniformItems player) + (vestItems player) + (backpackItems player) + (assignedItems player) + (weapons player) + [ headGear player, goggles player, uniform player, vest player, backpack player ] ;
	lbClear HG_WEAPONS_ITEM_LIST;
	
	{
		if ( _x != "" and _x != " " ) then {
			_itemType = [_x] call BIS_fnc_itemType;
			_itemClass = [_x] call HG_fnc_getConfig;
			_itemName = getText(configFile >> _itemClass >> _x >> "displayName");
			_ind = HG_WEAPONS_ITEM_LIST lbAdd _itemName;
			
			_price = 0;
			switch(_itemType select 0) do
			{
				case "Weapon":
				{
					_price = floor ([_x] call HG_fnc_getWeaponCost) * 10;
				};
				case "Magazine":
				{
					_price = floor ([_x] call HG_fnc_getMagazineCost);
				};
				default
				{
					_price = 50;
				};
			};
			
			_price = _price * -1;
			
			HG_WEAPONS_ITEM_LIST lbSetData[_ind,_x];
			HG_WEAPONS_ITEM_LIST lbSetValue[_ind,_price];
			HG_WEAPONS_ITEM_LIST lbSetTooltip[_ind,format[(localize "STR_HG_DLG_PRICE_TAG"),([_price] call BIS_fnc_numberText),(getText(missionConfigFile >> "CfgClient" >> "currencyType"))]];
		};
	} forEach _shopItems;
	
	HG_WEAPONS_ITEM_LIST lbSetCurSel 0;
	
} else {

	_typeOfShop = getText(missionConfigFile >> "CfgClient" >> "HG_WeaponsShopCfg" >> (_shopType select 0) >> (_shopType select 1) >> "type");
	
	if (_typeOfShop == "List") then {
		_shopItems = getArray(missionConfigFile >> "CfgClient" >> "HG_WeaponsShopCfg" >> (_shopType select 0) >> (_shopType select 1) >> "items");
			
		lbClear HG_WEAPONS_ITEM_LIST;
			
		{
			_itemClass = [(_x select 0)] call HG_fnc_getConfig;
			_itemName = getText(configFile >> _itemClass >> (_x select 0) >> "displayName");
			_ind = HG_WEAPONS_ITEM_LIST lbAdd _itemName;
			_itemType = [(_x select 0)] call BIS_fnc_itemType;
			
			_price = 0;
			switch(_itemType select 0) do
			{
				case "Weapon":
				{
					_price = floor ([(_x select 0)] call HG_fnc_getWeaponCost) * 10;
				};
				case "Magazine":
				{
					_price = floor ([(_x select 0)] call HG_fnc_getMagazineCost);
				};
				default
				{
					_price = (_x select 1);
				};
			};
			
			HG_WEAPONS_ITEM_LIST lbSetData[_ind,(_x select 0)];
			HG_WEAPONS_ITEM_LIST lbSetValue[_ind,_price];
			HG_WEAPONS_ITEM_LIST lbSetTooltip[_ind,format[(localize "STR_HG_DLG_PRICE_TAG"),([_x select 1] call BIS_fnc_numberText),(getText(missionConfigFile >> "CfgClient" >> "currencyType"))]];
		} forEach _shopItems;
			
		HG_WEAPONS_ITEM_LIST lbSetCurSel 0;
	} else {
		private ["_randomClass"];
		player groupChat (format ["%1", _typeOfShop]);
		_randomClass = getArray(missionConfigFile >> "CfgClient" >> "HG_WeaponsShopCfg" >> (_shopType select 0) >> (_shopType select 1) >> "randomClass");
		_CfgClass = getText(missionConfigFile >> "CfgClient" >> "HG_WeaponsShopCfg" >> (_shopType select 0) >> (_shopType select 1) >> "CfgClass");
		player groupChat (format ["%1", _randomClass]);
		
		_shopItems = [];
		_weaponsConfig = configFile >> _CfgClass;//"CfgWeapons";
		
		_rseed = floor (time /10+1)*10000;
		// player groupChat (format ["%1", _rseed]);
		
		for[{_i = 0},{_i < count(_weaponsConfig)},{_i = _i + 1}] do
		// for[{_i = 0},{_i < 2},{_i = _i + 1}] do
		{
			_nxtrand = _rseed + _i;
			_randomval = _nxtrand random 1;
			// player groupChat (format ["%1", _randomval]);
			if (_randomval > 0.9) then 
			{
				_currentWeapon = _weaponsConfig select _i;
				if(isClass _currentWeapon) then {
					_className = configName(_currentWeapon);
					_itemType = [_className] call BIS_fnc_itemType;
					
					// player groupChat (format ["%1", (str _itemType) == (str _randomClass)]);
					// player groupChat (format ["%1", _itemType]);
					_picture = getText(_currentWeapon >> "picture");
					if (_picture != "") then {
						_price = 0;
						switch(_itemType select 0) do
						{
							case "Weapon":
							{
								_price = floor ([_className] call HG_fnc_getWeaponCost) * 10;
							};
							case "Magazine":
							{
								_price = floor ([_className] call HG_fnc_getMagazineCost);
							};
							default
							{
								_price = 0;
							};
						};
						if (_price > 0) then {
							if ((str _itemType) == (str _randomClass)) then 
							{
								_shopItems = _shopItems + [_className];
							};
						};
					};
				};
			};
		};
		// player groupChat (format ["%1", _shopItems]);
		
		lbClear HG_WEAPONS_ITEM_LIST;
			
		{
			_itemClass = [_x] call HG_fnc_getConfig;
			_itemName = getText(configFile >> _itemClass >> _x >> "displayName");
			_ind = HG_WEAPONS_ITEM_LIST lbAdd _itemName;
			_itemType = [_x] call BIS_fnc_itemType;
			
			_price = 0;
			switch(_itemType select 0) do
			{
				case "Weapon":
				{
					_price = floor ([_x] call HG_fnc_getWeaponCost) * 10;
				};
				case "Magazine":
				{
					_price = floor ([_x] call HG_fnc_getMagazineCost);
				};
				default
				{
					_price = 50;
				};
			};
			
			HG_WEAPONS_ITEM_LIST lbSetData[_ind,_x];
			HG_WEAPONS_ITEM_LIST lbSetValue[_ind,_price];
			HG_WEAPONS_ITEM_LIST lbSetTooltip[_ind,format[(localize "STR_HG_DLG_PRICE_TAG"),(_price call BIS_fnc_numberText),(getText(missionConfigFile >> "CfgClient" >> "currencyType"))]];
		} forEach _shopItems;
			
		HG_WEAPONS_ITEM_LIST lbSetCurSel 0;
	};

};

true;
