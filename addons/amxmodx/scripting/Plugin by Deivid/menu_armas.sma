#include <amxmodx>
#include <cstrike>
#include <fakemeta_util>
#include <hamsandwich>

#define PLUGIN "DEIVID SERVER: Menu de Armas"
#define VERSION "1.3"

#define xPrefix "\r[\d>>> Deivid <<< Server\r]"
#define xPrefixChat "!t[!g>>> Deivid <<< Server!!t]"

new xRememberSelection[33], acao[33], xNaoMostrar[33]

public plugin_init() 
{
	register_plugin(PLUGIN, VERSION, "Deivid.")
	
	register_clcmd("say /armas", "xMenuGuns")
	
	RegisterHam(Ham_Spawn, "player", "xHam_Spawn", true)
}


public xHam_Spawn(id)
{
	if(!xNaoMostrar[id] || xRememberSelection[id])
		set_task(1.0, "xGetGuns", id)
}

public xGetGuns(id)
{
	static menu
	
	if(xRememberSelection[id])
	{
		_xMenuGuns(id, menu, acao[id]) // se verdadeiro compra as armas automaticamente, senão volta para o menu de opçoes
		client_print_color(id, "%s !yATENCAO JOGADOR: !tRelembrar Selecao de Armas !yesta !gATIVADA", xPrefixChat)
		client_print_color(id, "%s !yATENCAO JOGADOR: Para !tDESATIVAR !ytecle !gN !you digite !g/armas !yno chat !ye Volte ao Menu", xPrefixChat)
	}
	else
	{
		xMenuGuns(id)
		return PLUGIN_HANDLED;
	}
	
	return PLUGIN_HANDLED;
}


public client_putinserver(id) 
{
	xRememberSelection[id] = false
	xNaoMostrar[id] = false
}


// Menu Armas
public xMenuGuns(id)
{
	if(xRememberSelection[id])
	{
		xRememberSelection[id] = false
		client_print_color(id, "%s !yVoce reativou o menu de armas e as !gconfiguracoes foram zeradas.", xPrefixChat)
	}
	
	
	new xTeam
	xTeam  = get_user_team(id)
	
	new xMenu[500]
	
	formatex(xMenu, 499, "%s \wMenu de Armas", xPrefix)
	
	new menu = menu_create(xMenu, "_xMenuGuns")
	
	if(xTeam == 1) // Armas TR (verifica se o Jogador é TR caso seja aparece este menu de armas)
	{
		menu_additem(menu, "AK47 + Desert + Granadas + Colete", "1")
		menu_additem(menu, "AK47 + Usp + Granadas + Colete", "2")
		menu_additem(menu, "AWP + Desert + Granadas + Colete", "3")
		menu_additem(menu, "Galil + Desert + Granadas + Colete^n", "4")
	}
	else // Armas CT  (Senão aparece este menu de armas, pois se ele não é TR então é CT)
	{
		menu_additem(menu, "M4A1 + Desert + Granadas + Colete + Defuse Kit", "1")
		menu_additem(menu, "M4A1 + Usp + Granadas + Colete + Defuse Kit", "2")
		menu_additem(menu, "AWP + Desert + Granadas + Colete + Defuse Kit", "3")
		menu_additem(menu, "Famas + Desert + Granadas + Colete^n", "4")
	}
	
	if(xRememberSelection[id])
	{
		xRememberSelection[id] = true
		menu_additem(menu, "\yRelembrar Selecao? \r[\dAtivado\r]^n", "5")
	}
	else
	{
		menu_additem(menu, "\yRelembrar Selecao? \r[\dDesativado\r]^n", "5")
	}
	
	menu_additem(menu, "\yNao Exibir Menu Novamente.", "6")
	
	
	
	menu_setprop(menu, MPROP_EXITNAME, "Sair")
	menu_display(id, menu, 0)
	
	return PLUGIN_HANDLED
}

public _xMenuGuns(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu); return PLUGIN_HANDLED;
	}
	
	new xTeam
	xTeam = get_user_team(id)
	
	if(!is_user_connected(id)) return PLUGIN_HANDLED
	
	switch(item)
	{
		case 0: 
		{	
			if(xTeam == 1) // Armas TR
			{
				client_cmd(id,"vesthelm;ak47;deagle;secammo;primammo;hegren;flash;flash")
			}
			else // Armas CT
			{
				client_cmd(id, "defuser;vesthelm;m4a1;deagle;secammo;primammo;hegren;flash;flash")
			}
			
			acao[id] = item
		}
		
		case 1: 
		{
			if(xTeam == 1)
			{
				client_cmd(id,"vesthelm;ak47;usp;secammo;primammo;hegren;flash;flash")
			}
			else
			{
				client_cmd(id, "defuser;vesthelm;m4a1;usp;secammo;primammo;hegren;flash;flash")
			}
			
			acao[id] = item
		}
		
		case 2: 
		{
			if(xTeam == 1)
			{
				client_cmd(id, "vesthelm;awp;deagle;secammo;primammo;hegren;flash;flash")
			}
			else
			{
				client_cmd(id, "defuser;vesthelm;awp;deagle;secammo;primammo;hegren;flash;flash")
			}
			
			acao[id] = item
		}
		case 3: 
		{
			if(xTeam == 1)
			{
				client_cmd(id,"vesthelm;galil;deagle;secammo;primammo;hegren;flash;flash")
			}
			else
			{
				client_cmd(id, "defuser;vesthelm;famas;deagle;secammo;primammo;hegren;flash;flash")
			}
			
			acao[id] = item
		}
		
		case 4: 
		{
			if(xRememberSelection[id])
			{
				xRememberSelection[id] = false;
				
			}
			else
			{
				xRememberSelection[id] = true;
				client_print_color(id, "%s !yVoce Ativou !tRelembrar-Selecao de armas!y, !yTecle !gN !you digite !g/armas !yno chat para voltar ao !gMenu.", xPrefixChat)
				
				xGetGuns(id)
			}
		}
		
		case 5:
		{
			xNaoMostrar[id] = true;
			client_print_color(id, "%s !tPRONTO!!, !yTecle !gN !you digite !g/armas !yno chat para voltar ao !gMenu", xPrefixChat)
		}
		
	}
	
	return PLUGIN_HANDLED
}

stock client_print_color(const id, const input[], any:...)
{
	new count = 1, players[32]
	static msg[191]
	vformat(msg, 190, input, 3)
	
	replace_all(msg, 190, "!g", "^4")
	replace_all(msg, 190, "!y", "^1")
	replace_all(msg, 190, "!t", "^3")
	replace_all(msg, 190, "!t2", "^0")
	
	if (id) players[0] = id; else get_players(players, count, "ch")

	for (new i = 0; i < count; i++)
	{
		if (is_user_connected(players[i]))
		{
			message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, players[i])
			write_byte(players[i])
			write_string(msg)
			message_end()
		}
	}
}

// Função para dar Bind e ativar menu com a letra n 
// Só funciona na marquina local, no servidor o usuario tem que bindar manualmente no console
// Comando: bind n "say /armas" tem que estar entre aspas do jeito que está aqui

public client_connect(id)
{
   client_cmd(id,"bind ^"n^" ^"say /armas^"")
   
}
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1046\\ f0\\ fs16 \n\\ par }
*/
