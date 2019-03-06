#include "../../macros.hpp"

disableSerialization;
private _cbo = ((findDisplay 1602) displayCtrl(0));
lbClear _cbo;
/*
private _validWeps = [
	"arifle_MXC_F",
	"fucking blah blah"
];
*/

{
	_cbo lbAdd(format ["%1 (%2)", _x, _x in AS_P("blacklisted")]);
	_cbo lbSetData[(lbSize _cbo)-1, _x];
} forEach AS_AllWeaponsFriendly;
_cbo lbSetCurSel 0;
