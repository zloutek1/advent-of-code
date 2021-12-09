# assign unique id to lowest point of each basin
execute as @e[tag=lowest] run function part2:init_basins

# spread basins from lowest points
execute as @e[tag=lowest] at @s run function part2:spread

# count the basin sizes
scoreboard players operation count basin_counter = count basins
function part2:count_basin_sizes

# find the best
execute as @e[tag=lowest] run scoreboard players operation 1st leaderboard > @s basin_counter
execute as @e[tag=lowest] if score @s basin_counter = 1st leaderboard run tag @s add tmp
tag @e[tag=tmp,limit=1] add won
tag @e[tag=tmp] remove tmp

# find the second best by disregarding won entities
execute as @e[tag=lowest,tag=!won] run scoreboard players operation 2nd leaderboard > @s basin_counter
execute as @e[tag=lowest,tag=!won] if score @s basin_counter = 2nd leaderboard run tag @s add tmp
tag @e[tag=tmp,limit=1] add won
tag @e[tag=tmp] remove tmp

# find the third best by disregarding won entities
execute as @e[tag=lowest,tag=!won] run scoreboard players operation 3rd leaderboard > @s basin_counter
execute as @e[tag=lowest,tag=!won] if score @s basin_counter = 3rd leaderboard run tag @s add tmp
tag @e[tag=tmp,limit=1] add won
tag @e[tag=tmp] remove tmp

# mulitply to get result
scoreboard players operation three_largest vars = 1st leaderboard
scoreboard players operation three_largest vars *= 2nd leaderboard
scoreboard players operation three_largest vars *= 3rd leaderboard

# display result
data merge block 8 4 8 {Text1:'["",{"text":"[Part2]","color":"gold"},{"text":" "},{"score":{"name":"three_largest","objective":"vars"}}]'}
data modify entity @e[tag=result_printer,limit=1] CustomName set from block 8 4 8 Text1
say @e[tag=result_printer,limit=1]