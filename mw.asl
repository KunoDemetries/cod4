//Call of Duty 4: Modern Warfare Autosplitter + Load Remover
//original script by KunoDemetries
//cleaned up and some extra features by rythin

state("iw3sp") {
  	int loading1:	0x10B1100;
	string20 map:	0x6C3140;
	int boi:	0xCDE4C8;
}

startup {
        settings.Add("act0", true, "Prologue");
        settings.Add("act1", true, "Act 1");
        settings.Add("act2", true, "Act 2");
        settings.Add("act3", true, "Act 3");

        vars.missions1 = new Dictionary<string,string> { 
		{"killhouse", "F.N.G."},
		{"cargoship", "Crew Expendable"}, 
		{"coup", "The Coup"},
        };
		
        foreach (var Tag in vars.missions1) {
		settings.Add(Tag.Key, true, Tag.Value, "act0");
        };

        vars.missions2 = new Dictionary<string,string> { 
		{"blackout", "Blackout"},
		{"armada", "Charlie Dont Surf"},
		{"bog_a", "The Bog"},
		{"hunted", "Hunted"},	
		{"ac130", "Death From Above"},
		{"bog_b", "War Pig"},	
		{"airlift", "Shock and Awe"},
		{"aftermath", "Aftermath"},
        };

        foreach (var Tag in vars.missions2) {
		settings.Add(Tag.Key, true, Tag.Value, "act1");
        };

        vars.missions3 = new Dictionary<string,string> { 
		{"village_assault", "Safe House"},
		{"scoutsniper", "All Ghillied Up"}, 
		{"sniperescape", "One Shot, One Kill"},
		{"village_defend", "Heat"},
		{"ambush", "The Sins of the Father"},
        };
		
        foreach (var Tag in vars.missions3) {
		settings.Add(Tag.Key, true, Tag.Value, "act2");
        };
        
        vars.missions4 = new Dictionary<string,string> { 
		{"icbm", "Ultimatum"},
		{"launchfacility_a", "All In"},
		{"launchfacility_b", "No Fighting in The War Room"},
		{"jeepride", "Game Over"},
	};
        
        foreach (var Tag in vars.missions4) {
		settings.Add(Tag.Key, true, Tag.Value, "act3");
        };
	    
	    refreshRate = 30;
    }

init {
	vars.doneMaps = new List<string>(); 
	vars.coupOffset = false;
	vars.currentTime = new TimeSpan(0, 0, 0);	//TimeSpan object used to add a timer offset after The Coup
}

update {
	vars.currentTime = timer.CurrentTime.GameTime;	//keep the variable updated with the current time on the timer
}

start {
	//changed start condition to happen only after loading in rather than any time in the load
	if (current.map == "killhouse" && current.loading1 != 0 && old.loading1 == 0) {
		vars.doneMaps.Clear();		//clear the doneMaps list
		vars.coupOffset = false;	//set offset to false just in case it somehow stays on
		return true;				//start the timer
    }
}

split {

	if (current.map != old.map) {					//on map change
		if (old.map == "coup") {				//if the last map was The Coup
			vars.currentTime = timer.CurrentTime.GameTime;	//set a variable to the value of current time
			vars.coupOffset = true;				//add 4:44 to the timer
			if (settings["coup"]) {				//if the split for The Coup is enabled
				vars.doneMaps.Add(old.map);		//add the last map to done splits list
				return true;				//split
			}
		}
			
		else {						//if map is NOT The Coup
			if (settings[old.map]) {		//if setting for last map is enabled
				vars.doneMaps.Add(old.map);	//add the last map to done splits list
				return true;			//split
			}
		}
		
	}

	//this is kuno's code idk what it does but i assume its the final split
	//would explain the lack of setting for this one
	if (current.map == "jeepride" && current.boi == 139512) {
		return true;
	}
}   
 
reset {
	//kuno's condition, seems sketchy but whatever i dont run this game if it works for yall thats good lol
	return (current.map != old.map && current.map == "ui" && old.map != "coup");
}

gameTime {
	if (vars.coupOffset == true) {					//when offset gets set to true
		vars.coupOffset = false;				//set it back to false
		return vars.currentTime.Add(new TimeSpan (0, 4, 44));	//set the timer to current timer time + 284s (4m44s)
	}
}

isLoading {
	return (current.loading1 == 0) || (current.map == "coup");
}
