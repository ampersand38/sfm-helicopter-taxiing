if (!hasInterface) exitWith {};

sfmtaxi_factor = 1;
sfmtaxi_const = 0.041;

addUserActionEventHandler ["HeliWheelsBrake", "Activate", sfmtaxi_fnc_input];

[
    "sfm_taxiing_maxSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["Max Speed", "Max taxi speed in km/h."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "SFM Helicopter Taxiing", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [1, 36, 15, 0], // data for this setting: [min, max, default, number of shown trailing decimals]
    false // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;
