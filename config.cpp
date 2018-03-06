class MPRavageCusomAction
{
    title = "";
	condition = "true";
	action = "";
	priority = 1.5;
	showWindow = false;
};


class CfgInteractionMenus
{
    class Car
    {
        targetType = 2;
        target = "Car";

        class Actions
        {
            class Lock : MPRavageCusomAction
            {
                title = "Lock";
                condition = "((locked DSInteractionObject) isEqualTo 1) and (DSInteractionObject call HG_fnc_canUnLock)";
                action = "DSInteractionObject lock true";
            };

            class Unlock : MPRavageCusomAction
            {
                title = "Unlock";
                condition = "((locked DSInteractionObject) isEqualTo 2) and (DSInteractionObject call HG_fnc_canUnLock)";
                action = "DSInteractionObject lock false";
            }
        };
    };
};