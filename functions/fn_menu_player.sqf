systemChat 'fn_menu_player.sqf >> Runinning!';

if (leader player isEqualTo player) then {
    _AceMenuRallyPoint = [
        'RallypointMenu',
        'Rally Point',
        "\A3\ui_f\data\map\markers\military\flag_CA.paa",
        {},
        {
            true
        }
    ] call ace_interact_menu_fnc_createAction;

    _AceMenuRallyPointAdd = [
        "posicionarRally",
        "Posicionar Rallypoint",
        "\A3\ui_f\data\map\markers\military\flag_CA.paa",
        {

            params ["_target", "_player", "_params"];
            waitUntil {!isNil 'soldierDeploy_fnc_place_rallypoint'};
            private _ren = [1] remoteExec ['soldierDeploy_fnc_place_rallypoint', 0, true];

            if(!isNil '_ren' and !(_ren isEqualTo [])) then {
                
                [1, position _player] remoteExec ['soldierDeploy_fnc_vehicle_respawn_waypoint', 0, true];

            } else {
                


            };

        }, {true}, {}, []
    ] call ace_interact_menu_fnc_createAction;

    _AceMenuRallyPointRemove = [
        "removerRally",
        "Remover Rallypoint",
        "\A3\ui_f\data\map\markers\military\flag_CA.paa",
		{
			params ["_target", "_player", "_params"];
            waitUntil {!isNil 'soldierDeploy_fnc_place_rallypoint'};
            private _ren = [0] remoteExec ['soldierDeploy_fnc_place_rallypoint', 0, true];

            if(!isNil '_ren' and !(_ren isEqualTo [])) then {

                [0, position _player] remoteExec ['soldierDeploy_fnc_vehicle_respawn_waypoint', 0, true];

            };
        },
        {true}, {}, []
    ] call ace_interact_menu_fnc_createAction;

    [player, 1, ['ACE_SelfActions'], _AceMenuRallyPoint] call ace_interact_menu_fnc_addActionToObject;
    [player, 1, ['ACE_SelfActions', 'RallypointMenu'], _AceMenuRallyPointAdd] call ace_interact_menu_fnc_addActionToObject;
    [player, 1, ['ACE_SelfActions', 'RallypointMenu'], _AceMenuRallyPointRemove] call ace_interact_menu_fnc_addActionToObject;
};

true;