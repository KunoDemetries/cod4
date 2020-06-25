state("iw4sp")
    {
	string131 map : 0x5DA560;
	int loading1 : 0x171338C;
	int boi : 0xC98A50;
	//int starter : 0xC6F280;
    }


startup {
        settings.Add("act1", true, "Act 1");
        settings.Add("act2", true, "Act 2");
        settings.Add("act3", true, "Act 3");

        vars.missions2 = new Dictionary<string,string> { 
		{"trainier", "S.S.D.D."}, 
		{"roadkill", "Team Player"},
		{"cliffhanger", "Cliffhanger"},
		{"airport", "No Russian"},
		{"favela", "Takedown"},
        };

        vars.missions2A = new List<string>();
        foreach (var Tag in vars.missions2) {
        settings.Add(Tag.Key, true, Tag.Value, "act1");
        vars.missions2A.Add(Tag.Key); };

        vars.missions3 = new Dictionary<string,string> { 
		{"invasion", "Wolverines"},
		{"favela_escape", "The Hornets Nest"},
		{"arcadia", "Exodus"},
		{"oilrig", "The Only Easy Day Was Yesterday"},
		{"gulag", "The Gulag"},
		{"dcburning", "Of Their Own Accord"},
        };
        vars.missions3A = new List<string>();
        foreach (var Tag in vars.missions3) {
        settings.Add(Tag.Key, true, Tag.Value, "act2");
        vars.missions3A.Add(Tag.Key); };
        
        vars.missions4 = new Dictionary<string,string> { 
		{"contingency", "Contingency"},
		{"dcemp", "Second Sun"}, 
		{"dc_whitehouse", "Whiskey Hotel"},
		{"estate", "Loose Ends"},
		{"boneyard", "The Enemy of My Enemy"},
		{"af_caves", "Just Like Old Times"},
		{"af_chase", "Endgame"},
		{"ending", "End"},
        };
        
        vars.missions4A = new List<string>();
        foreach (var Tag in vars.missions4) {
        settings.Add(Tag.Key, true, Tag.Value, "act3");
        vars.missions4A.Add(Tag.Key); };
    }

init
    {
    vars.doneMaps = new List<string>(); 
    }

split
    {
    string currentMap = current.map;

    if ((currentMap != old.map)) {
        if (!vars.doneMaps.Contains(current.map)) {
            if (settings[currentMap.Trim()]) {
                if (vars.missions2A.Contains(currentMap) ||
                vars.missions3A.Contains(currentMap) ||
                vars.missions4A.Contains(currentMap)) {
            vars.doneMaps.Add(current.map);
            return true;
            }
            else {
            return false;
            }
        }
        }
    }
    return ((current.boi == 1048576000) && (current.map == "ending"));
    }   

start
    {
	if ((current.map == "trainer") && (old.map == "ui")) {
    vars.doneMaps.Clear();
	vars.doneMaps.Add(current.map);
    return true;
    }
    }

 
 reset
    {
    return ((current.map == "ui") && (old.map != "ui"));
    }

  isLoading
    {
	return (current.loading1 == 0);
    }
