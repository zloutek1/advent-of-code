# mark as visited
tag @s add visited

# put neighbors into same group as its lowest, if conditions satisfied
execute positioned ~1 ~ ~ run scoreboard players operation @e[tag=!visited,distance=0,scores={values=..8}] basins = @s basins
execute positioned ~-1 ~ ~ run scoreboard players operation @e[tag=!visited,distance=0,scores={values=..8}] basins = @s basins
execute positioned ~ ~1 ~ run scoreboard players operation @e[tag=!visited,distance=0,scores={values=..8}] basins = @s basins
execute positioned ~ ~-1 ~ run scoreboard players operation @e[tag=!visited,distance=0,scores={values=..8}] basins = @s basins

# spread MORE
execute positioned ~1 ~ ~ as @e[tag=!visited,distance=0,scores={values=..8}] at @s run function part2:spread
execute positioned ~-1 ~ ~ as @e[tag=!visited,distance=0,scores={values=..8}] at @s run function part2:spread
execute positioned ~ ~1 ~ as @e[tag=!visited,distance=0,scores={values=..8}] at @s run function part2:spread
execute positioned ~ ~-1 ~ as @e[tag=!visited,distance=0,scores={values=..8}] at @s run function part2:spread

