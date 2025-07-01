waitUntil {!isNil 'soldierDeploy_fnc_menu_player'};
private _pilot_chopper 	= missionNamespace getVariable ['respawn_chopper', objNull];
private _helicopter 	= missionNamespace getVariable ['respawn_helicopter', objNull];

systemChat 'init.sqf >> Runinning!';

if(isServer) then
{
	systemChat 'Marker Create!';
	private _marker = createMarker ['respawn_west', [0,0,0]];
	_marker setMarkerType "Empty";
};

if(local player and player isEqualTo leader player) then {[player] remoteExec ['soldierDeploy_fnc_menu_player', player, true]};