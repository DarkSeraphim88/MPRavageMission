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
                condition = "(locked cursorObject == 1)";
                action = "cursorObject lock true";
            };

            class Unlock : MPRavageCusomAction
            {
                title = "Unlock";
                condition = "(locked cursorObject == 2)";
                action = "cursorObject lock false";
            }
        };
    };
};