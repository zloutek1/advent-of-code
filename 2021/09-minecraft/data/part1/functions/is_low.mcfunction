# set default value
scoreboard players set lowest vars 999

# override value if lower
execute positioned ~1 ~ ~ run scoreboard players operation lowest vars < @e[tag=input, distance=0] values
execute positioned ~-1 ~ ~ run scoreboard players operation lowest vars < @e[tag=input, distance=0] values
execute positioned ~ ~1 ~ run scoreboard players operation lowest vars < @e[tag=input, distance=0] values
execute positioned ~ ~-1 ~ run scoreboard players operation lowest vars < @e[tag=input, distance=0] values

# mark as lowest if lower then all neigbors
execute if score @s values < lowest vars run tag @s add lowest
execute if score @s values < lowest vars run scoreboard players operation @s lows = @s values
