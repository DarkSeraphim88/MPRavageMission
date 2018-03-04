_class = _this select 0;
_cost = 0;
_ammo = getText (configFile >> "CfgMagazines" >> _class >> "ammo");
_count = getNumber (configFile >> "CfgMagazines" >> _class >> "count");
_mass = getNumber (configFile >> "CfgMagazines" >> _class >> "mass");
_cost = getNumber (configFile >> "cfgAmmo" >> _ammo >> "hit") + getNumber (configFile >> "cfgAmmo" >> _ammo >> "indirecthit") + _mass + _count;
_cost