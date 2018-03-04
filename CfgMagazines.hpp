class CfgMagazines {
    class CA_Magazine;
    class DS_vehiclekey_1: CA_Magazine {
        picture = "missionFile\ui\keyBlack.paa";
        displayName = "ACE Vehicle Key";   //!!!CANNOT be localized!!!: because it is used as part of the magazineDetail string
        descriptionShort = CSTRING(Item_Custom_Description);
        count = 1;
        mass = 0;
        ACE_isUnique = 1;
    };
};