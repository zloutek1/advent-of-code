
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

evalCommands :: [Command] -> Int
evalCommands = foldr (*) 1 . take 2 . foldl updatePosition [0, 0, 0]
    where updatePosition [x, y, aim] (Forward by) = [x + by, y + aim * by, aim]
          updatePosition [x, y, aim] (Down by) = [x, y, aim + by]
          updatePosition [x, y, aim] (Up by) = [x, y, aim - by]

main :: IO ()
main = do
    contents <- readFile "input.txt"
    print $ evalCommands . map parseCommand . lines $ contents
