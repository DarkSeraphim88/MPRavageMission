if (isServer) then {
	params ["_mapName"];
	private ["_varName","_allCars"];

	_varName = _mapName + "_DS_Cars";

	diag_log "Started";

	spawnCars = {
		params ["_varName"];
		private _allCars = profileNamespace getVariable [_varName,[]];
		{
			private _vehicleData = _x;
			_vehicleData params ["_vehicleClass","_textures","_fuel","_damage","_pos","_dir","_GUIDS","_cargoSpace","_cargoLoaded","_itemCargo","_magazineCargo","_weaponCargo","_containerCargo","_locked"];
			
			private _vehicle = objNull;
			// ===================================== Start spawn
			_temporaryPositionInOuterSpace = 
			[
				(_pos select 0) - 250 + (random 500),
				(_pos select 1) - 250 + (random 500),
				1000 + (random 1000)
			];
			_vehicle = createVehicle [_vehicleClass, _temporaryPositionInOuterSpace, [], 0, "CAN_COLLIDE"];
			_vehicle allowDamage false;
			_vehicle removeAllEventHandlers "HandleDamage";
			_vehicle addEventHandler["HandleDamage", {false}];
			_vehicle setVelocity [0, 0, 0];
			if ((typeName _dir) isEqualTo "ARRAY") then 
			{
				_vehicle setVectorDirAndUp _dir;
			}
			else 
			{
				_vehicle setDir _dir;
			};

			_vehicle setPosATL _pos;

			_vehicle setVelocity [0, 0, 0];
			_vehicle allowDamage true;
			_vehicle removeAllEventHandlers "HandleDamage";
			_vehicle setDamage 0;
			clearBackpackCargoGlobal _vehicle;
			clearItemCargoGlobal _vehicle;
			clearMagazineCargoGlobal _vehicle;
			clearWeaponCargoGlobal _vehicle;
			if (_vehicleClass isKindOf "I_UGV_01_F") then 
			{
				createVehicleCrew _vehicle;
			};
			// ===================================== End Spawn
			// ===================================== Fill items
			if ((typeName _itemCargo) isEqualTo "ARRAY") then 
			{
				if!(_itemCargo isEqualTo [[],[]])then
				{
					{
						_vehicle addItemCargoGlobal [_x ,((_itemCargo select 1) select _forEachIndex)];
					}
					forEach (_itemCargo select 0);
				};
			};
			// ===================================== End Fill Items
			// ===================================== Fill magazines
			if ((typeName _magazineCargo) isEqualTo "ARRAY") then 
			{	
				if!(_magazineCargo isEqualTo [])then
				{
					{
						_vehicle addMagazineAmmoCargo [_x select 0, 1 , _x select 1];
					}
					forEach _magazineCargo;
				};
			};
			// ===================================== End fill magazines
			// ===================================== Fill Weapons
			if ((typeName _weaponCargo) isEqualTo "ARRAY") then
			{
				if!(_weaponCargo isEqualTo [])then
				{
					{
						_vehicle addWeaponCargoGlobal [_x select 0, 1];
						for "_i" from 1 to ((count _x) -1) do
						{
							_thing = _x select _i;
							if !(_thing isEqualTo "") then
							{
								if (_thing isEqualType []) then
								{
									if !(_thing isEqualTo []) then
									{
										_vehicle addMagazineAmmoCargo [_thing select 0, 1, _thing select 1];
									};
								}
								else
								{
									_vehicle addItemCargoGlobal [_thing, 1];
								};
							};
						};
					}
					forEach _weaponCargo;
				};
			};
			// ===================================== End Fill Weapons
			// ===================================== Fill Containers
			if ((typeName _containerCargo) isEqualTo "ARRAY") then 
			{
				if!(_containerCargo isEqualTo [])then
				{
					_current_filled = [];
					_control = [];
					{
						_container = _x select 0;
						_weapons = _x select 1;
						_magazines = _x select 2;
						_items = _x select 3;
						_type = [_container] call BIS_fnc_itemType;
						if((_type select 1) isEqualTo "Backpack")then
						{
							_vehicle addBackpackCargoGlobal [_container,1];
						}
						else
						{
							_vehicle addItemCargoGlobal [_container,1];
						};
						_control = (everyContainer _vehicle);
						{
							if!((_x select 1) in _current_filled)exitWith
							{
								_current_filled pushBack (_x select 1);
							};
						}
						forEach _control;
						/*if!(_weapons isEqualTo [])then
						{
							[(_current_filled select _forEachIndex),_weapons] call ExileServer_util_fill_fillWeapons;
						};
						if!(_magazines isEqualTo [])then
						{
							[(_current_filled select _forEachIndex),_magazines] call ExileServer_util_fill_fillMagazines;
						};
						if!(_items isEqualTo [[],[]])then
						{
							[(_current_filled select _forEachIndex),_items] call ExileServer_util_fill_fillItems;
						};*/
					}
					forEach _containerCargo;
				};
			};
			// ===================================== End Fill Containers

			private _vehicleTextures = getObjectTextures _vehicle;
			{
				if (_x != (_vehicleTextures select _forEachIndex)) then
				{
					_vehicle setObjectTextureGlobal [_forEachIndex, _x];
				};
			} forEach _textures;

			_vehicle setFuelCargo _fuel;
			_vehicle setDamage _damage;
			_vehicle lock _locked;

			_vehicle setVehicleAmmo 1;

			_vehicle setVariable ["DS_GUIDS", _GUIDS];
			_vehicle setVariable ["ace_cargo_space", _cargoSpace];
			_vehicle setVariable ["ace_cargo_loaded", _cargoLoaded];
			_vehicle setVariable ["DS_ShouldSave", true];

		} forEach _allCars;
	};

	_varName spawn {
		params ["_varName"];
		_varName call spawnCars;
		while {true} do {
			private _allVehToSave = [];
			{
				private _vehicle = _x;
				if (_vehicle getVariable ["DS_ShouldSave", false]) then {
					private _vehicleClass = typeOf _vehicle;
					private _textures = getObjectTextures _vehicle;
					private _fuel = fuel _vehicle;
					private _damage = damage _vehicle;
					private _pos = position _vehicle;
					private _dir = direction _vehicle;
					private _GUIDS = _vehicle getVariable["DS_GUIDS",[]];
					private _cargoSpace = _vehicle getVariable["ace_cargo_space",0];
					private _cargoLoaded = _vehicle getVariable["ace_cargo_loaded",[]];
					private _locked = locked _vehicle;
					private _itemCargo = [];
					private _magazineCargo = [];
					private _weaponCargo = [];
					private _containerCargo = [];

					// Load vehicle inventory
					_items = getItemCargo _vehicle;
					_realContainers = [] ;
					_containers = (everyContainer _vehicle);
					if !(_containers isEqualTo []) then
					{
						{
						_realContainers pushBack (_x select 0);
						}
						forEach _containers;
					};
					if !(_items isEqualTo [[], []]) then
					{
						for "_i" from ((count (_items select 0)) - 1) to 0 step -1 do 
						{
							if (((_items select 0) select _i) in _realContainers) then
							{
								(_items select 0) deleteAt _i;
								(_items select 1) deleteAt _i;
							};
						};
					};
					_itemCargo = _items;
					_magazineCargo = magazinesAmmoCargo _vehicle;
					_weaponCargo = weaponsItemsCargo _vehicle;
					_data = [];
					_allContainers = everyContainer _vehicle;
					if !(_allContainers isEqualTo []) then
					{
						{
							_containerType = _x select 0;
							_containerObject = _x select 1;
							_temp = []; 
							_temp pushBack _containerType;
							_temp pushBack (weaponsItemsCargo _containerObject); 
							_temp pushBack (magazinesAmmoCargo _containerObject);
							_temp pushBack (getItemCargo _containerObject);
							_data pushBack _temp;
						}
						forEach _allContainers;
					};
					_containerCargo = _data;
					_allVehToSave pushBack [_vehicleClass,_textures,_fuel,_damage,_pos,_dir,_GUIDS,_cargoSpace,_cargoLoaded,_itemCargo,_magazineCargo,_weaponCargo,_containerCargo,_locked];
				};
			} forEach vehicles;
			profileNamespace setVariable [_varName, _allVehToSave];
			saveProfileNamespace;
			sleep 5;
			diag_log "Cycle";
		};
	};
};