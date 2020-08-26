state("t6sp")
{
	string65 map : 0xF4E62C;
	double loading1 : 0x1A002C0;
	string90 map2 : 0xC18138;
	int exit : 0x2578DF0;
}

startup
{
    vars.missions = new Dictionary<string,string> {  
		{"monsoon.all.sabs", "Celerium"},
		{"afghanistan.all.sabs", "Old Wounds"},
		{"nicaragua.all.sabs", "Time and Fate"},
		{"pakistan_1.all.sabs", "Fallen Angel"},
		{"karma_1.all.sabs", "Karma"},
		{"panama.all.sabs", "Suffer With Me"},
		{"yemen.all.sabs", "Achilles Veil"},
		{"blackout.all.sabs", "Odysseus"},
		{"la_1.all.sabs", "Cordis Die"},
		{"haiti.all.sabs", "Judgment Day"},
	}; 
		   foreach (var Tag in vars.missions) {
        settings.Add(Tag.Key, true, Tag.Value);
           }
           
    vars.loadings = new Dictionary<string,string> {
        {"fronted.english.sabs","cutscene1"},
        {"fronted.all.sabs","cutscene2"},
        {"ts_afghanistan.all.sabs","cutscene3"},
    };
        vars.missions1A = new List<string>();
        foreach (var Tag in vars.loadings) {
        vars.missions1A.Add(Tag.Key);
        }
}

init 
{
	vars.doneMaps = new List<string>(); 
}

start
{
    if ((current.map == "angola.all.sabs") && (current.loading1 != 0)) {
        vars.doneMaps.Clear();
        return true;
    }
}

isLoading
{
    if (current.map2 != "nicaragua_gump_josefina")
	{
		if ((current.loading1 == 0) ||
		((current.map2 == "su_rts_mp_dockside")) ||
		(vars.missions1A.Contains(current.map)))
        {
            return true;
        }

	else 
		{
			return false;
		}

	}	
}

split
{
    if (current.map != old.map) {
	    if (settings[current.map]) {
	            vars.doneMaps.Add(old.map);
				return true;
				}
        }

   if ((current.map2 == "haiti_gump_endings") && (current.exit != 0))
   {
       return true;
   }		
}
