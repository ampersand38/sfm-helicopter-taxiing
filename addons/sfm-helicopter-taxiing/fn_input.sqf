private _unit = call CBA_fnc_currentUnit;
private _heli = vehicle _unit;

if (
    difficultyEnabledRTD
    || {!local _heli}
    || {!(_heli isKindOf "Helicopter")}
) exitWith {};

private _isTaxi = !brakesDisabled _heli;
_heli disableBrakes _isTaxi;
_heli vehicleChat format ["Taxi: %1", _isTaxi];

if (!_isTaxi) exitWith {};

[sfmtaxi_fnc_pfh, 0, [_unit, _heli]] call CBA_fnc_addPerFrameHandler;
