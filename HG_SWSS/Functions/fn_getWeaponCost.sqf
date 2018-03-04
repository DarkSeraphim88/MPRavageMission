_class = _this select 0;
_cfg =(configFile >> "CfgWeapons" >> _class);
_cost = 0;
if (getnumber (_cfg >> "type") in [1,2,4]) then  {
	_mag = (getArray(_cfg >> "magazines"));
	{
		_ammo = getText (configFile >> "CfgMagazines" >> _x >> "ammo");
		_cost = getNumber (_cfg >> "WeaponSlotsInfo" >> "mass") + (getNumber (configFile >> "cfgAmmo" >> _ammo >> "hit") + getNumber (configFile >> "cfgAmmo" >> _ammo >> "indirecthit")) * (count (getArray (_cfg >> "muzzles")));
	} foreach _mag;
};
_cost