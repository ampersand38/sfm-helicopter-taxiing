if (!hasInterface) exitWith {};

sfmtaxi_factor = 1;
sfmtaxi_const = 0.041;

addUserActionEventHandler ["HeliWheelsBrake", "Activate", sfmtaxi_fnc_input];
