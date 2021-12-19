import Data.List (partition, nub)

type Point = (Int, Int)

data Action = FoldUp Int
            | FoldLeft Int
            deriving (Show, Eq)

splitOn :: Char -> String -> [String]
splitOn delim s = let (x,xs) = span (/= delim) s in
                  if null xs then [x]
                             else x : splitOn delim (tail xs)

tuplify2 :: [a] -> (a,a)
tuplify2 [x,y] = (x,y)

parsePoint :: String -> Point
parsePoint = tuplify2 . map read . splitOn ','

parseAction :: String -> Action
parseAction line = let ["fold", "along", value] = words line
                       [dir, value'] = splitOn '=' value in
                   case dir of
                       "x" -> FoldLeft $ read value'
                       "y" -> FoldUp $ read value'

parseFile :: String -> IO ([Point], [Action])
parseFile filename = readFile filename >>= \content ->
    let (points, "":actions) = span (not . null) $ lines $ content in
        pure $ (map parsePoint points, map parseAction actions)

foldSheet :: Action -> [Point] -> [Point]
foldSheet (FoldUp y) points = let (up, down) = partition ((< y) . snd) points in nub $ up ++ map (\(x1, y1) -> (x1, 2*y - y1)) down
foldSheet (FoldLeft x) points = let (left, right) = partition ((< x) . fst) points in nub $ left ++ map (\(x1, y1) -> (2*x - x1, y1)) right

-- part1 :: [Point] -> [Action] -> Int
-- part1 points actions = length $ foldSheet (head actions) points

part1 :: [Point] -> [Action] -> Int
part1 points actions = length $ foldSheet (head actions) points

draw points = let width = maximum $ map fst points
                  height = maximum $ map snd points in
              unlines [[if (x, y) `elem` points then '#' else '.' | x <- [0..width]] | y <- [0..height]]

part2 points actions = foldl (flip foldSheet) points actions

main = do
    (points, actions) <- parseFile "input.txt"
    putStrLn $ show points
    putStr "[Part1] " >> print (part1 points actions)
    putStr "[Part2] \n" >> putStr (draw $ part2 points actions)