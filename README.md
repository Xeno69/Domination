# Domination
An Arma3 multiplayer mode for up to 50 players. Seize various (random) targets and solve side missions. Available as Coop and PvPvE version.

This award winning game mission stands as one of the oldest missions of the Arma franchise. Domination was created by Xeno.

# Resources

[Domination on Steam](https://steamcommunity.com/sharedfiles/filedetails/comments/332088703)

[Domination on Github](https://github.com/Xeno69/Domination)

# Running the mission

[Administrator Guide](https://github.com/Xeno69/Domination/wiki/Administrator-Guide)

# Playing the mission

[Player Guide](https://github.com/Xeno69/Domination/wiki/Player-Guide)

# Running the mission locally

To run the Domination mission locally:

* copy the mission folder `co30_Domination.Altis` into your local `mpmission` directory
* load the mission in Eden editor and click **Play** -> **Multiplayer** -> **OK** to run your local code

# Editing the mission

The Domination mission may be modified in Eden editor.

All maps supported by Domination are released as PBOs.  However you can use any PBO tool to modify and bundle your own mission modifications.  Choose `co30_Domination.Altis` as the PBO source to bundle the default map (Altis).

If you want to bundle or modify maps other than Altis follow these steps:

* delete `co30_Domination.Altis/mission.sqm`
* copy the appropriate `mission.sqm` file from `mission_sqm` folder into `co30_Domination.Altis`
* rename the file you copied to `mission.sqm`
* delete `co30_Domination.Altis/x_setup.sqf`
* copy the appropriate `x_setup.sqf` file from `mission_sqm` folder into `co30_Domination.Altis`
* rename the file you copied to `x_setup.sqf`
* rename `co30_Domination.Altis` folder to `co30_Domination.NewMap` (for example `co30_Domination.Malden`)
* run your preferred PBO tool with PBO source folder `co30_Domination.Malden`

Remember that your modifications can only be shared with the community if you contribute your work back to the source repository.

# Mod support

Domination uses a strict whitelist for client remote execution functions and commands. Some mods are not compatible with Domination due to these restrictions. To remove restrictions for client remote execution in your own PBO, see `CfgRemoteExec` in `description.ext` and set `mode=2`.

# Reset saved mission namespace

Reset the mission progress by either a) complete all the maintargets/sidemissions and when the "outro" runs the current save will be deleted or b) delete the namespace file in `Documents/Arma 3` folder or `Documents/Arma 3 - Other Profiles` folder.
