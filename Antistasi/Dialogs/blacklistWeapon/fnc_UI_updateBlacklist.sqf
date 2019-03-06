disableSerialization;
private _id = lbCurSel 0; 
private _weaponName = lbData [0, _id];

if (_weaponName != "") then 
{
	//TODO: check if commander
	[_weaponName] remoteExec ["AS_fnc_addWeaponToBlacklist", 2];
}
else 
{
	hint "No weapon selected";
};