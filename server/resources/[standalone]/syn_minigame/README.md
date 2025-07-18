# syn-minigame

Minigame script for RedM

![syn_minigame](https://github.com/user-attachments/assets/c2a1d081-3ea7-4b97-b316-f204ee9135f5)

## Usage
```
local test = exports["syn_minigame"]:taskBar(5000,7) -- Difficulty, SkillGapSent
print(test)
```


Example
```
local minigame = exports["syn_minigame"]:taskBar(5000,7)

print(minigame)

if minigame == 100 then
	print("Successful")
else
	print("Failed")
end
````
