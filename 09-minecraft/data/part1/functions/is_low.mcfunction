
scoreboard players set lowest vars 999

execute positioned ~1 ~ ~ run scoreboard players operation lowest vars < @e[tag=input, distance=0] values
execute positioned ~-1 ~ ~ run scoreboard players operation lowest vars < @e[tag=input, distance=0] values
execute positioned ~ ~1 ~ run scoreboard players operation lowest vars < @e[tag=input, distance=0] values
execute positioned ~ ~-1 ~ run scoreboard players operation lowest vars < @e[tag=input, distance=0] values

execute if score @s values < lowest vars run tag @s add lowest
execute if score @s values < lowest vars run scoreboard players operation @s lows = @s values
