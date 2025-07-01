params [
    ['_mode', 0, [0]],
    ['_radio', nil, ['', nil]],
    ['_radioSFX', nil, ['', nil]],
    ['_position', [], [[]]]
];

if(hasInterface) then {

    systemChat"RallyPoint.sqf -> Running!";
    if(_mode > 0) then {
        private _rally_radio        = missionNamespace getVariable['rally_radio', []];

        if(!(_rally_radio isEqualTo [])) then {
            _rally_radio_bag        = _rally_radio select 0;
            _rally_radio_sfx        = _rally_radio select 1;

            if(!isNull _rally_radio_bag) then {deleteVehicle _rally_radio_bag};
            if(!isNull _rally_radio_sfx) then {deleteVehicle _rally_radio_sfx};
        };

        private _TYPE_RALLY_RADIO   =  if(isNil '_radio') then {'B_RadioBag_01_black_F'} else {_radio};
        private _SFX_RALLY_RADIO    = if(isNil '_radioSFX') then {'SoundSetSource_Sfx_sine_880hz_10db'} else {_radioSFX};
        private _POSITION           = if(_position isEqualTo []) then {position player} else {_position};

        private _Radio = createVehicle [_TYPE_RALLY_RADIO, [_POSITION select 0, _POSITION select 1, 0], [], 0, 'NONE'];
        private _Sound = createVehicle [_SFX_RALLY_RADIO, [_POSITION select 0, _POSITION select 1, 0], [], 0, 'NONE'];

        if(!alive _Radio and !alive _Sound) exitWith {systemChat"RallyPoint.sqf -> Erro: RallyPoint não Criado!"; []};

        _Radio enableSimulationGlobal  false;
        missionNamespace setVariable['rally_radio', [_Radio, _Sound]];
        hint 'RallyPoint Criado!';
        _POSITION;

    } else {

        private _rally_radio        = missionNamespace getVariable['rally_radio', []];
        if(!(_rally_radio isEqualTo [])) then {
            _rally_radio_bag        = _rally_radio select 0;
            _rally_radio_sfx        = _rally_radio select 1;

            if(!isNull _rally_radio_bag) then {deleteVehicle _rally_radio_bag};
            if(!isNull _rally_radio_sfx) then {deleteVehicle _rally_radio_sfx};

            hint "RallyPoint Removido!";
        };
        true;
    };
};