state("iw6sp64_ship")
    {
    string50 map : 0x5816540;
    int loading1 : 0x6024EA0;
    int loading2 : 0x774853C;
    }

startup
{
	settings.Add("missions", true, "Missions");    
	
	vars.missions = new Dictionary<string,string> 
	{ 
    	{"deer_hunt","Brave New World"},
    	{"nml","No Man's Land"},
    	{"enemyhq","Struck Down"},
    	{"homecoming","Homecoming"},
    	{"flood","Legends Never Die"},
    	{"cornered","Federation Day"},
    	{"oilrocks","Birds of Prey"},
    	{"jungle_ghosts","The Hunted"},
    	{"clockwork","Clockwork"},
    	{"black_ice","Atlas Falls"},
    	{"ship_graveyard","Into the Deep"},
    	{"factory","End of the Line"},
    	{"las_vegas","Sin City"},
    	{"carrier","All or Nothing"},
    	{"satfarm","Severed Ties"},
    	{"loki","Loki"},
    	{"skyway","The Ghost Killer"},
    };
 	foreach (var Tag in vars.missions)
	{
		settings.Add(Tag.Key, true, Tag.Value, "missions");
    };
}
 
init
{
	vars.doneMaps = new List<string>(); 
}

start
{
	if ((current.map == "prologue") && (current.loading2 == 0))
	{
		vars.doneMaps.Clear();
		return true;
	}
}

split
{
	if (current.map != old.map) 
	{
		if (settings[current.map]) 
		{
			vars.doneMaps.Add(old.map);
			return true;	
		}	
	}
}

isLoading
{
    return ((current.loading1 == 0) && (current.loading2  == 1));
}

reset
{
    return (current.map == null);
}
