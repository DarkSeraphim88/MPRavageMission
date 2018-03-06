if !(isNull DSInteractionObject) then
{
	if (DSInteractionObject isKindOf "Player") then 
	{
		{
			player removeAction _x;
		}
		forEach DSInteractionHandles;
	}
	else
	{
		{
			DSInteractionObject removeAction _x;
		}
		forEach DSInteractionHandles;
	};
	DSInteractionObject = objNull;
	DSInteractionHandles = [];
};