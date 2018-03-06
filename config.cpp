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
                condition = "(locked DSInteractionObject) isEqualTo 1";
                action = "DSInteractionObject lock true";
            };

            class Unlock : MPRavageCusomAction
            {
                title = "Unlock";
                condition = "(locked DSInteractionObject) isEqualTo 2";
                action = "DSInteractionObject lock false";
            }
        };
    };
};