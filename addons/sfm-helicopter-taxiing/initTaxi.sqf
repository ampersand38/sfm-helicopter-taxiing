/*
Author: Ampersand
SFM Helicopter Taxi
call compile preprocessFileLineNumbers "initTaxi.sqf";
*/

sfmtaxi_factor = 1;
sfmtaxi_const = 0.041;

amp_sfmtaxi_fnc_input = {
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

    [
        amp_sfmtaxi_fnc_PFH
    , 0, [_unit, _heli]] call CBA_fnc_addPerFrameHandler;
};

amp_sfmtaxi_fnc_PFH = {
    params ["_args", "_pfhID"];
    _args params ["_unit", "_heli", ["_spd", 0], ["_maxForce", 1000]];

    if (
        !alive _unit
        || {_unit != currentPilot _heli}
        || {!alive _heli}
        || {!brakesDisabled _heli}
        || {!local _heli}
    ) exitWith {
        [_pfhID] call CBA_fnc_removePerFrameHandler;
    };

    if (
        !isTouchingGround _heli
        || {isGamePaused}
    ) exitWith {};

    velocityModelSpace _heli params ["_x", "_y"];
    private _input = inputAction "HeliCyclicForward" + inputAction "HeliRopeAction";
    private _isTaxi = _y < 10 && {isEngineOn _heli} && {_input > 0}; // && {inputAction "HeliCollectiveLower" + inputAction "HeliCollectiveLowerCont" >= 1};
    if (!_isTaxi && {_y < 0.1}) exitWith {};

    _acc = (sfmtaxi_const + sfmtaxi_factor * _input * parseNumber _isTaxi);
    _force = _acc * getMass _heli;
    _force = _maxForce min _force;

    if _isTaxi then {
        if (_y < 0.1) then {
            _spd = _spd + 0.1;
            _maxForce = _maxForce + 200;
            _this select 0 set [2, _spd];
            _this select 0 set [3, _maxForce];
            _heli setVelocityModelSpace [0, _spd ,0];
        };
    };

    _pos = getCenterOfMass _heli;
    _heli addForce [_heli vectorModelToWorld [
        -_x * sfmtaxi_factor * getMass _heli,
        _force,
        0
    ], _pos];
};

addUserActionEventHandler ["HeliWheelsBrake", "Activate", amp_sfmtaxi_fnc_input];
