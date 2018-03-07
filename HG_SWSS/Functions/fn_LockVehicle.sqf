private["_condition", "_object", "_known", "_pincode"];
_condition = _this;
_object = DSInteractionObject;
//if!(_pincode isEqualTo "")then
//{
//	["lockToggle",[netId _object,_pincode,_condition]] call ExileClient_system_network_send;
//};
[ _object, _condition ] remoteExec ["lock"]
call HG_fnc_interactionMenu_unhook;

true;