#define false 0
#define true  1
/*
    Author - HoverGuy
	© All Fucks Reserved

    Defines available shops and their content and global config
	
	currencyType - STRING - Currency you want to use
	enableSave - BOOL - Save money?
	resetSavedMoney - BOOL - Reset saved money? Useful if you enable persistence then disable it and re-enable it, if it's set to true old saved money will be reset to startCash value, only used if enableSave is set to true
	enableHUD - BOOL - Enable money display in HUD?
	enablePaycheck - BOOL - Enable paycheck?
	
	class HG_MoneyCfg
	{
		class Rank - Can be PRIVATE/CORPORAL/SERGEANT/LIEUTENANT/CAPTAIN/MAJOR/COLONEL
		{
			paycheck - INTEGER - Paycheck amount
			paycheckPeriod - INTEGER - Time (in minutes) between each paycheck iteration, only used if enablePaycheck is set to true
			startCash - INTEGER - Obvious...
		};
	};
	
	class HG_WeaponsShopCfg
    {
		class YourShopClass - Used as a param for the call, basically the shop you want to display
		{
		    whitelisted - BOOL - Is the shop whitelisted?
		    whitelistRank - STRING - Can be PRIVATE/CORPORAL/SERGEANT/LIEUTENANT/CAPTAIN/MAJOR/COLONEL, not used when whitelisted is set to false
		
		    class YourShopCategory - Shop category, can be whatever you want (PewPewLaserGun, Weapons, BigFatGuns, etc...)
		    {
				displayName - STRING - Category display name
				items - ARRAY - Shop content
				|- 0 - STRING - Classname
				|- 1 - INTEGER - Price
		    };
		};
	};
*/

currencyType = "$";
enableSave = true;
resetSavedMoney = false;
enableHUD = true;
enablePaycheck = false;

class HG_MoneyCfg
{
	class PRIVATE
	{
		paycheck = 2000;
		paycheckPeriod = 30;
		startCash = 10000;
	};
	class CORPORAL
	{
		paycheck = 4000;
		paycheckPeriod = 30;
		startCash = 11000;
	};
	class SERGEANT
	{
		paycheck = 6000;
		paycheckPeriod = 30;
		startCash = 12000;
	};
	class LIEUTENANT
	{
		paycheck = 8000;
		paycheckPeriod = 30;
		startCash = 13000;
	};
	class CAPTAIN
	{
		paycheck = 10000;
		paycheckPeriod = 30;
		startCash = 14000;
	};
	class MAJOR
	{
		paycheck = 12000;
		paycheckPeriod = 30;
		startCash = 15000;
	};
	class COLONEL
	{
		paycheck = 14000;
		paycheckPeriod = 30;
		startCash = 16000;
	};
};

class HG_WeaponsShopCfg // Has to be left untouched
{
	class HG_SupplyShop
	{
		whitelisted = false;
		whitelistRank = "";
		
		class Supplies
		{
			displayName = "Supplies";
			type = "List";
			items[] =
			{
				{"rvg_beans", 30},
				{"rvg_bacon", 30},
				{"rvg_milk", 25},
				{"rvg_rice", 25},
				{"rvg_rustyCan", 15},
				{"rvg_Rabbit_Meat_Cooked", 35},
				{"rvg_Chicken_Meat_Cooked", 35},
				{"rvg_Sheep_Meat_Cooked", 45},
				{"rvg_plasticBottlePurified", 50},
				{"rvg_canteenPurified", 50},

				{"rvg_flare", 10},
				{"rvg_toolkit", 150},
				{"rvg_tire", 50},
				{"rvg_hose", 20},
				{"rvg_guttingKnife", 30},
				{"rvg_Geiger", 200},
				{"rvg_matches", 10},
				{"rvg_purificationTablets", 50},
				{"rvg_canOpener", 15},
				{"rvg_sleepingBag_Blue", 50},
				{"rvg_foldedTent", 70}
			};
		};
		
		
	    class Items
	    {
	        displayName = "Items";
			type = "List";
		    items[] =
		    {
		        {"ItemWatch",50},
			    {"ItemCompass",50},
			    {"ItemGPS",50},
			    {"ItemRadio",50},
			    {"ItemMap",50}
		    };
	    };
	
	};
	
	class HG_DefaultShop
	{
		whitelisted = false;
		whitelistRank = "";
		
		class Handgun
		{
			displayName = "Handgun";
			type = "Random";
			randomClass[] = {"Weapon","Handgun"};
			CfgClass = "CfgWeapons";
			items[] = {};
		};
		
		class AR
		{
			displayName = "Assault Rifles";
			type = "Random";
			randomClass[] = {"Weapon","AssaultRifle"};
			CfgClass = "CfgWeapons";
			items[] = {};
		};
		
	    class Magazines
	    {
	        displayName = "Magazines";
			type = "Random";
			randomClass[] = {"Magazine","Bullet"};
			CfgClass = "CfgMagazines";
		    items[] =
		    {
		        {"30Rnd_65x39_caseless_mag",0},
                {"16Rnd_9x21_Mag",0},
	            {"30Rnd_9x21_Mag",0}
		    };
	    };
	
	    class Scopes
	    {
	        displayName = "Scopes";
			type = "List";
			randomClass[] = {"Item","AccessorySights"};
			CfgClass = "CfgWeapons";
		    items[] =
		    {
		        {"optic_Holosight",100},
		        {"optic_Aco",120},
		        {"optic_Arco",300},
			    {"optic_Hamr",200}
		    };
	    };
	};
};
