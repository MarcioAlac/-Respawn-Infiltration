params[['_mode', 1, [0]]];

_helicopterVehicle = missionNamespace getVariable ['respawn_helicopter', objNull];

systemChat"vehicle_respawn_waypoint.sqf -> Running!";

if(isNull _helicopterVehicle or !alive _helicopterVehicle) exitWith {systemChat 'Erro -> Piloto não encontrado!'};
if(!alive _helicopterVehicle) exitWith {systemChat 'Erro -> Helicoptero não encontrado!'};

missionNamespace setVariable['originalHeliPos', getPosATL _helicopterVehicle];
if (((getMarkerPos "helipos") isEqualTo [0,0,0]) and !isNil 'originalHeliPos') then {createMarker ["helipos", originalHeliPos]; systemChat 'narca cruada'} exitWith{systemChat str originalHeliPos};

private _rallyPos           = position player;
private _maxRange           = 10000;
private _minDistanceUnload  = 1100;
private _maxHeight          = 300;
private _prefixMarker       = 'zph-infil';
private _grouPilot          = group leader _helicopterVehicle;
private _loopHeliWaypoint   = missionNamespace getVariable['loop_wp_heli', true];
private _counterPlayerHeli  = 0;

missionNamespace setVariable['rallyOn', true];

_helicopterVehicle allowDamage false;

if (_mode > 0) then {

    while{missionNamespace getVariable['rallyOn', true]} do {
        deleteWaypoint[_grouPilot, 0];
        _unitsInChopper = count(crew _helicopterVehicle select {isPlayer _x});

        if(_unitsInChopper < 1) then {

            deleteWaypoint[_grouPilot, 0];
            private _wpWaiting =  _grouPilot addWaypoint[_rallyPos, 0];
            _wpWaiting setWaypointType 'LOITER';
            _wpWaiting setWaypointSpeed 'NORMAL';
            _wpWaiting setWaypointBehaviour 'CARELESS';
            _wpWaiting setWaypointLoiterRadius _maxRange;
            _wpWaiting setWaypointLoiterAltitude _maxHeight;

            waitUntil{sleep 2; count(crew _helicopterVehicle select {isPlayer _x}) > 0};

        };

        if (_unitsInChopper >= 1) then {
            
            deleteWaypoint[_grouPilot, 0];

            _markers = allMapMarkers select { markerText _x == _prefixMarker};
            if (!(_markers isEqualTo [])) then {_rallyPos = getMarkerPos _markers; _minDistanceUnload = 0};

            private _wpUnTransport =  _grouPilot addWaypoint[_rallyPos, _minDistanceUnload];
            _wpUnTransport setWaypointType 'TR UNLOAD';
            _wpUnTransport setWaypointSpeed 'NORMAL';
            _wpUnTransport setWaypointBehaviour 'CARELESS';

            _landPad = createVehicle['Land_HelipadEmpty_F', waypointPosition _wpUnTransport, [], 0, 'NONE'];

            waitUntil{sleep 2; count(crew _helicopterVehicle select {isPlayer _x}) <= 0};
            deleteVehicle _landPad;
            sleep 2;
        };

        sleep .3;
    };
    
} else {

    sleep 1;
    missionNamespace setVariable['rallyOn', false];
    private _unitsInChopper = count(crew _helicopterVehicle select {isPlayer _x});

    if (_unitsInChopper < 1) then {

        systemChat 'retornando para base';
        private _originalHeliPos = missionNamespace getVariable['originalHeliPos', []];
        if (_originalHeliPos isEqualTo []) exitWith {systemChat"Erro -> Zona de Pouso não encontrada!"};
        _originalHeliPos = [_originalHeliPos select 0, _originalHeliPos select 1, 0];

        deleteWaypoint[_grouPilot, 0];

        private _returnBase =  _grouPilot addWaypoint[getMarkerPos 'helipos', 1];
        _returnBase setWaypointType "MOVE";
        _returnBase setWaypointSpeed 'NORMAL';
        _returnBase setWaypointBehaviour 'CARELESS';
        _returnBase setWaypointStatements [
            'true',
            "; vehicle this land 'LAND'"
        ];
        if (isNil 'landPad') then {landPad = createVehicle['Land_HelipadEmpty_F', waypointPosition _returnBase, [], 0, 'NONE']};

    } else {

        deleteWaypoint [_grouPilot, 0]; 
        sleep 1;
        playersInHeli = crew _helicopterVehicle select {isPlayer _x};

        if (count playersInHeli > 0) then {

            [true] remoteExec ["openMap", playersInHeli select 0, true];
            ["Selecione o local de pouso!"] remoteExec['hint', playersInHeli select 0, true];

            playersInHeli select 0 onMapSingleClick {
                landPosition = _pos; 
                ["Local selecionado! Confirme com a tecla ESPAÇO"] remoteExec ['hint', playersInHeli select 0, true];
            };

            (findDisplay 46) displayAddEventHandler ["KeyDown", {
                if (_this select 1 == 57) then {
                    if (!isNil "landPosition") then {
                        playersInHeli select 0 onMapSingleClick {};
                        openMap false;
                    };
                    true
                };
            }];
        };

        waitUntil{!isNil 'landPosition'};

        sleep 5;
        _helicopterVehicle vehicleChat "Indo para local designado!";

        private _wpPlayerLanding = _grouPilot addWaypoint [landPosition, 0];
        _wpPlayerLanding setWaypointType "TR UNLOAD";
        _wpPlayerLanding setWaypointSpeed "NORMAL";
        _wpPlayerLanding setWaypointBehaviour "CARELESS";
        private _landPad = createVehicle ["Land_HelipadEmpty_F", landPosition, [], 0, "NONE"];
        waitUntil { sleep 2; count(crew _helicopterVehicle select {isPlayer _x}) <= 0 };
        deleteVehicle _landPad;
        sleep 5;
        systemChat 'retornando para base';
        private _originalHeliPos = missionNamespace getVariable['originalHeliPos', []];
        if (_originalHeliPos isEqualTo []) exitWith {systemChat"Erro -> Zona de Pouso não encontrada!"};
        _originalHeliPos = [_originalHeliPos select 0, _originalHeliPos select 1, 0];

        deleteWaypoint[_grouPilot, 0];

        private _returnBase =  _grouPilot addWaypoint[getMarkerPos 'helipos', 1];
        _returnBase setWaypointType "MOVE";
        _returnBase setWaypointSpeed 'NORMAL';
        _returnBase setWaypointBehaviour 'CARELESS';
        _returnBase setWaypointStatements [
            'true',
            "; vehicle this land 'LAND'"
        ];

        if (isNil 'landPad') then {landPad = createVehicle['Land_HelipadEmpty_F', waypointPosition _returnBase, [], 0, 'NONE']};

        sleep 2;
    };
};