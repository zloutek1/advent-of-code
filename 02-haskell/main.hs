
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
evalCommands = foldr (*) 1 . foldr updatePosition [0, 0]
    where updatePosition (Forward by) [x, y] = [x + by, y]
          updatePosition (Down by) [x, y] = [x, y + by]
          updatePosition (Up by) [x, y] = [x, y - by]

main :: IO ()
main = do
    contents <- readFile "input.txt"
    print $ evalCommands . map parseCommand . lines $ contents
