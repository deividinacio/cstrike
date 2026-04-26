#include <amxmodx>
#include <amxmisc>
#include <cstrike>


#define PLUGIN "Admin Model Menu"
#define VERSION "1.0"
#define AUTHOR "Dimision/Deivid"
#define ADMIN_LEVEL_Q	ADMIN_LEVEL_C

public plugin_init() 
{
    register_plugin(PLUGIN, VERSION, AUTHOR)
    register_clcmd("say /admodels", "admin")
}

public plugin_precache() 
{
        precache_model("models/player/Goth_Loli/Goth_Loli.mdl")
        precache_model("models/player/Panico/Panico.mdl")
        precache_model("models/player/Dobby/Dobby.mdl")
       // precache_model("models/player/Girl/Girl.mdl")
       // precache_model("models/player/Sonic/Sonic.mdl")
       // precache_model("models/player/Coringa/Coringa.mdl")
        precache_model("models/player/Gato_Botas/Gato_Botas.mdl")
 
}
		
public admin(id)
{
	if (get_user_flags(id) & ADMIN_LEVEL_H)
		{
			model_menu(id)
		}
		else
        {
               ChatColor(id, "!g>> !nPara acessar Models você deve entrar como ADM !gAdministrador !n!")
        }
	
}
public model_menu(id)
{
    new menu = menu_create("\r[\w >>> SERVER DEIVID <<< Escolha sua SKIN de Jogador \r]\r", "menu_wybierz")
    
    menu_additem(menu, "\wGoth_Loli", "1", 0)
    menu_additem(menu, "\wPanico", "2", 0)
    menu_additem(menu, "\wDobby", "3", 0)
    //menu_additem(menu, "\wGirl", "4", 0)
    //menu_additem(menu, "\wSonic", "5", 0)
    //menu_additem(menu, "\wCoringa", "6", 0)
    menu_additem(menu, "\wGato_Botas", "4", 0)

    
    menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
    
    menu_display(id, menu, 0)
}

public menu_wybierz(id, menu, item)
{
    if (item == MENU_EXIT)
    {
        menu_destroy(menu)
        return PLUGIN_HANDLED
    }
    new data[6], iName[64]
    new acces, callback
    menu_item_getinfo(menu, item, acces, data,5, iName, 63, callback)
    
    new key = str_to_num(data)
    
    switch(key)
    { 
       case 1 : cs_set_user_model(id, "Goth_Loli")
       case 2 : cs_set_user_model(id, "Panico")
       case 3 : cs_set_user_model(id, "Dobby")
       //case 4 : cs_set_user_model(id, "Girl")
       //case 5 : cs_set_user_model(id, "Sonic")
       //case 6 : cs_set_user_model(id, "Coringa")
       case 4 : cs_set_user_model(id, "Gato_Botas")
       
    }
    menu_destroy(menu)
    return PLUGIN_HANDLED
}  
stock ChatColor(const id, const input[], any:...) {
	new count = 1, players[32];
	static msg[191];
	vformat(msg, 190, input, 3);
	
	replace_all(msg, 190, "!g", "^4"); // verde
	replace_all(msg, 190, "!n", "^1"); // galben/alb/negru
	replace_all(msg, 190, "!t", "^3"); // rosu/albastru/gri
	replace_all(msg, 190, "!t2", "^0"); // rosu2/albastru2/gri2
	
	if (id) players[0] = id; else get_players(players, count, "ch");
	{
		for (new i = 0; i < count; i++)
			{
			if (is_user_connected(players[i]))
				{
				message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, players[i]);
				write_byte(players[i]);
				write_string(msg);
				message_end();
			}
		}
	}
}


// Função para dar Bind e ativar menu com a letra v 
// Só funciona na marquina local, no servidor o usuario tem que bindar manualmente no console:
// Abra o console teclando aspas "" e digite este comando:
// bind v "say /armas" 
// Agora toda vez que voce apertar v vai aparecer este menu, pois vc acabou de bindar ele na letra v 
// ATENÇÃO cuidado para não bindar letras que já tem menu padrão no cs, pois vc vai perder este menu e entrara o novo 


public client_connect(id)
{
   client_cmd(id,"bind ^"v^" ^"say /admodels^"")
   
}





/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1046\\ f0\\ fs16 \n\\ par }
*/
