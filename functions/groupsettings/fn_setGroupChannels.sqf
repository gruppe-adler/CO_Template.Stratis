#include "component.hpp"

params ["_group"];

_groupIndex = _group getVariable ["grad_groupIndex",-1];
if (_groupIndex < 0) exitWith {};

_allGroupConfigs = "true" configClasses (missionConfigFile >> "missionSettings" >> "groupsettings");
if !(count _allGroupConfigs > _groupIndex) exitWith {};

_groupConfig = _allGroupConfigs select _groupIndex;
_tfarSrSettings = switch (playerSide) do {
    case (WEST): {tf_freq_west};
    case (EAST): {tf_freq_east};
    case (INDEPENDENT): {tf_freq_guer};
    default {tf_freq_west};
};
_tfarSrFreqs = _tfarSrSettings select 2;
_tfarLrSettings = switch (playerSide) do {
    case (WEST): {tf_freq_west_lr};
    case (EAST): {tf_freq_east_lr};
    case (INDEPENDENT): {tf_freq_guer_lr};
    default {tf_freq_west_lr};
};
_tfarLrFreqs = _tfarLrSettings select 2;


//SHORTRANGE SETTINGS
_srDefaultChannel = ([_groupConfig >> "shortrange","defaultChannel",0] call BIS_fnc_returnConfigEntry) - 1;
_srAltChannel = ([_groupConfig >> "shortrange","altChannel",0] call BIS_fnc_returnConfigEntry) - 1;
_srAltOnlyTL = ([_groupConfig >> "shortrange","altChannelOnlyTL",1] call BIS_fnc_returnConfigEntry) == 1;

if (_srDefaultChannel > 7) then {_srDefaultChannel = 0};
_tfarSrSettings set [0,_srDefaultChannel];

if (_srAltChannel > 7) then {_srAltChannel = 0};
if (leader group player == player || !_srAltOnlyTL) then {
    _tfarSrSettings set [5,_srAltChannel];
};

{
    _channelName = [_groupConfig >> "shortrange",_x,""] call BIS_fnc_returnConfigEntry;
    _channelFreq = ["shortrange",_channelName] call GRAD_groupsettings_fnc_findChannelFrequency;
    if (_channelFreq != -1) then {
        _tfarSrFreqs set [_forEachIndex,str _channelFreq];
    };
} forEach ["net1","net2","net3","net4","net5","net6","net7","net8"];


//LONGRANGE SETTINGS
_lrDefaultChannel = ([_groupConfig >> "longrange","defaultChannel",0] call BIS_fnc_returnConfigEntry) - 1;
_lrAltChannel = ([_groupConfig >> "longrange","altChannel",0] call BIS_fnc_returnConfigEntry) - 1;
_lrAltOnlyTL = ([_groupConfig >> "longrange","altChannelOnlyTL",1] call BIS_fnc_returnConfigEntry) == 1;

if (_lrDefaultChannel > 8) then {_lrDefaultChannel = 0};
_tfarLrSettings set [0,_lrDefaultChannel];

if (_lrAltChannel > 8) then {_lrAltChannel = 0};
if (leader group player == player || !_lrAltOnlyTL) then {
    _tfarLrSettings set [5,_lrAltChannel];
};

{
    _channelName = [_groupConfig >> "longrange",_x,""] call BIS_fnc_returnConfigEntry;
    _channelFreq = ["longrange",_channelName] call GRAD_groupsettings_fnc_findChannelFrequency;
    if (_channelFreq != -1) then {
        _tfarLrFreqs set [_forEachIndex,str _channelFreq];
    };
} forEach ["net1","net2","net3","net4","net5","net6","net7","net8","net9"];


systemChat "groupsettings: group channels loaded";
