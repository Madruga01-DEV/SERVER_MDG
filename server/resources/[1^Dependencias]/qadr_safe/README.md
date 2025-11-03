
# qadr-safe

**How to use**

Set resource folder name to `qadr-safe`

And set `ensure qadr-safe` in your server.cfg

This resource converted from fivem to redm.

You can create as many locks as you want. 

It will be generated based on how many random numbers are provided to the **createSafe** function

Also, you shall only provide numbers **between 0 and 99**, otherwise it will be impossible to **finish the minigame properly!**
`````lua
local res = exports["qadr-safe"]:createSafe({math.random(0,99)})
`````
*The final result is returned as soon as the minigame is finished*

*This code was originally developed in C#. You can access the original repository by clicking on the [following link](https://github.com/TimothyDexter/FiveM-SafeCrackingMiniGame)*

[Fivem Lua version](https://github.com/VHall1/pd-safe)

[Sample Video](https://www.youtube.com/watch?v=bmsPNMACUsY)
