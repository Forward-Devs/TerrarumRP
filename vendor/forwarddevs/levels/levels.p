#include <YSI\y_hooks>

#define Levels::%0(%1) forward Levels_%0(%1);public Levels_%0(%1)


hook OnGameModeInit()
{
	mysql_tquery(g_SQL, "SELECT * FROM `levels`", "Levels_Load", "");

	return 1;
}

Levels::Load()
{
	for(new i=0; i < cache_num_rows(); ++i)
	{
		// Crea una instancia orm y carga todas las variables requeridas
		new ORM: ormid = Level::i(ORM_ID) = orm_create("levels", g_SQL);
		orm_addvar_int(ormid, Level::i(id), "id");
		orm_addvar_int(ormid, Level::i(level), "level");
		orm_addvar_int(ormid, Level::i(exp), "exp");
		orm_apply_cache(ormid, i);

	}
	print("Component: Levels (FR0Z3NH34R7) loaded.");
	return 1;
}

Levels::GetExp(level_id)
{
	new expe;
	expe = Level::level_id(exp);
	return expe;
}

CMD:level(playerid,params[]) {
	new idd;
	if(sscanf(params,"i",idd)) return SendClientMessage(playerid,0xFFFFFFFF,"Usage: /level [Level ID]");
	new string[128];
	format(string,sizeof(string), "Level %d Exp: %d",Level::idd+1(level),Level::idd+1(exp));
	SendClientMessage(playerid,0xFFFFFFFF,string);

	return true;
}