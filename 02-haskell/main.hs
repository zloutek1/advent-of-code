
data Command = Forward Int
             | Down Int
             | Up Int
             deriving (Show, Eq)

parseCommand :: String -> Command
parseCommand input = 
    let [command_str, value_str] = words input
        value = readInt value_str
        command = readCommand command_str in

    command value

    where readInt = read :: String -> Int
          readCommand "forward" = Forward
          readCommand "up" = Up
          readCommand "down" = Down

star1 :: [Command] -> Int
star1 = foldr (*) 1 . take 2 . foldl updatePosition [0, 0]
    where updatePosition [x, y] (Forward by) = [x + by, y]
          updatePosition [x, y] (Down by) = [x, y + by]
          updatePosition [x, y] (Up by) = [x, y - by]

star2 :: [Command] -> Int
star2 = foldr (*) 1 . take 2 . foldl updatePosition [0, 0, 0]
    where updatePosition [x, y, aim] (Forward by) = [x + by, y + aim * by, aim]
          updatePosition [x, y, aim] (Down by) = [x, y, aim + by]
          updatePosition [x, y, aim] (Up by) = [x, y, aim - by]

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let commands = map parseCommand . lines $ contents

    putStr "[star1] "
    putStrLn . show . star1 $ commands

    putStr "[star2] "
    putStrLn . show . star2 $ commands
