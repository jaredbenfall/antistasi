#include "macros.hpp"
AS_SERVER_ONLY("resourcesFIA.sqf");
private ["_hr","_resourcesFIA","_hrT","_resourcesFIAT"];

waitUntil {sleep 5; isNil "AS_resourcesIsChanging"};
AS_resourcesIsChanging = true;

_hr = _this select 0;
_resourcesFIA = _this select 1;
if (isNil "_resourcesFIA") then {diag_log "Tienes algún coste sin definit en las tablas de FIA"};
if ((isNil "_hr") or (isNil "_resourcesFIA")) exitWith {};

_hrT = AS_P("hr");
_resourcesFIAT = AS_P("resourcesFIA");

_hrT = _hrT + _hr;
_resourcesFIAT = round (_resourcesFIAT + _resourcesFIA);

if (_hrT > 0) then {
	_hrT = _hrT min (["HR"] call fnc_BE_permission);
};
_hrT = _hrT max 0;
_resourcesFIAT = _resourcesFIAT max 0;

AS_Pset("hr",_hrT);
AS_Pset("resourcesFIA",_resourcesFIAT);
AS_resourcesIsChanging = nil;

_texto = "";
_hrSim = "";
if (_hr > 0) then {_hrSim = "+"};

_resourcesFIASim = "";
if (_resourcesFIA > 0) then {_resourcesFIASim = "+"};
if ((_hr != 0) and (_resourcesFIA != 0)) then
	{
	_texto = format ["<t size='0.6' color='#C1C0BB'>FIA Resources.<br/> <t size='0.5' color='#C1C0BB'><br/>HR: %3%1<br/>Money: %4%2 €",_hr,_resourcesFIA,_hrSim,_resourcesFIASim]
	}
else
	{
	if (_hr != 0) then {_texto = format ["<t size='0.6' color='#C1C0BB'>FIA Resources.<br/> <t size='0.5' color='#C1C0BB'><br/>HR: %3%1",_hr,_resourcesFIA,_hrSim]} else {_texto = format ["<t size='0.6' color='#C1C0BB'>FIA Resources.<br/> <t size='0.5' color='#C1C0BB'><br/>Money: %4%2 €",_hr,_resourcesFIA,_hrSim,_resourcesFIASim]};
	};

if (_texto != "") then {[petros,"income",_texto] remoteExec ["commsMP",AS_commander]};
