/*
Author: Ampersand
SFM Helicopter Taxi
*/

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
