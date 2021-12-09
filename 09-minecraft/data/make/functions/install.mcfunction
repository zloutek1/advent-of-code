forceload add 0 0 15 15

#function input:allocate
function input:input

# increase the recursion limit
gamerule maxCommandChainLength 655360

scoreboard objectives add file dummy
scoreboard players set row file 0
scoreboard players set col file 0

scoreboard objectives add numbers dummy
scoreboard players set 0 numbers 0
scoreboard players set 1 numbers 1
scoreboard players set 2 numbers 2
scoreboard players set 3 numbers 3
scoreboard players set 4 numbers 4
scoreboard players set 5 numbers 5
scoreboard players set 6 numbers 6
scoreboard players set 7 numbers 7
scoreboard players set 8 numbers 8
scoreboard players set 9 numbers 9
scoreboard players set 10 numbers 10

scoreboard players set ord('0') numbers 48

scoreboard objectives add vars dummy
scoreboard objectives add values dummy
scoreboard objectives add lows dummy
scoreboard objectives add basins dummy
scoreboard objectives add basin_counter dummy
scoreboard objectives add leaderboard dummy

summon armor_stand 0 0 0 {Tags: [result_printer], NoGravity: 1b}
setblock 8 3 8 oak_log
setblock 8 4 8 oak_sign