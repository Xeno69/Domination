# Domination
Domination - A multiplayer mission for Arma 3 where human players fight bots and/or other humans for combat objective victories. This award winning game mission stands as one of the oldest missions of the Arma franchise. Domination was created by Xeno.

# Resources

[Domination on Steam](https://steamcommunity.com/sharedfiles/filedetails/comments/332088703)

[Domination on Github](https://github.com/Xeno69/Domination)

# Editing the mission

To modify the Domination mission locally:

* copy the mission folder `co30_Domination.Altis` into your local `mpmission` directory
* load the mission in Eden editor and click Play -> Multiplayer to run your local code

All maps supported by Domination are released as PBOs.  However you can use any PBO tool to modify and bundle your own mission modifications.  Choose `co30_Domination.Altis` as the PBO source to bundle the default map (Altis).

If you want to bundle or modify maps other than Altis then follow these steps:

* delete `co30_Domination.Altis/mission.sqm`
* copy the appropriate `mission.sqm` file from `mission_sqm` folder into `co30_Domination.Altis`
* rename the file you copied to `mission.sqm`
* delete `co30_Domination.Altis/x_setup.sqf`
* copy the appropriate `x_setup.sqf` file from `mission_sqm` folder into `co30_Domination.Altis`
* rename the file you copied to `x_setup.sqf`

Remember that your modifications can only be shared with the community if you contribute your work back to the source repository.