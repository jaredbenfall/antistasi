#include "../macros.hpp"
AS_SERVER_ONLY("fnc_addWeaponToBlacklist.sqf");

params ["_weapon"];

private _weps = +AS_P("blacklisted");

if (_weapon in _weps) then 
{
	AS_Pset("blacklisted", AS_P("blacklisted") - [_weapon]);
}
else 
{
	AS_Pset("blacklisted", AS_P("blacklisted") + [_weapon]); 
};
