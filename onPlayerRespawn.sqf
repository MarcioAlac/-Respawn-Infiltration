[1, "BLACK", 8, 1] spawn BIS_fnc_fadeEffect; 
[0, "BLACK", 0] call BIS_fnc_fadeEffect;

private _heli = missionNamespace getVariable ["respawn_helicopter", objNull];
private _pilot_chopper = missionNamespace getVariable ['pilot_inserter', objNulle];
private _turner = missionNamespace getVariable ['rallyOn', false];

if ((!isNull _heli && !isNull _pilot_chopper) and _turner) then {
	
	player moveInCargo _heli;
	sleep 2;
	private _playerName = name player;
	
	private _msg = format ["<t color='#FFA500'> Aqui fala o piloto, ouça e ouça bem: você acabou de voltar do hospital por um suicidio mal concluido.</t>"];
	private _msg_1 = format ["<t color='#FFA500'> Essa carona de volta custou 200 litros e a porra do resto da minha paciência. Estou te inserindo denovo na Zona de Infiltração, não me faça ter que trazer você de novo seu animal!</t>"];
	private _msg_2 = format ["<t color='#FFA500'> Ouça aqui, vou tentar deixar você o mais próximo possível da zona, fique atento! %1</t>", _playerName];

	[
		["Shuriken 1-1", _msg, 1],
		["Shuriken 1-1", _msg_1, 6],
		["Shuriken 1-1", _msg_2, 15]
	] remoteExec ["BIS_fnc_EXP_camp_playSubtitles", if (local player) then {player} else {0}, true];
};