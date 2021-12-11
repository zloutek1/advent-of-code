namespace AoC
{
    using System.Collections.Generic;

    using Grid = List<List<int>>;

    public class Day11
    {
        private List<(int x, int y)> flashed = new List<(int x, int y)>();
        private Stack<(int x, int y)> charged = new Stack<(int x, int y)>();

        private List<(int x, int y)> GetNeighbors(Grid grid, (int x, int y) octopus)
        {
            var (x, y) = octopus;
            var neighbors = new List<(int x, int y)>();
            for (int dy = -1; dy <= 1; ++dy)
            {
                for (int dx = -1; dx <= 1; ++dx)
                {
                    if (y + dy < 0
                        || grid.Count <= y + dy
                        || x + dx < 0
                        || grid[y + dy].Count <= x + dx)
                        continue;
                    neighbors.Add((x + dx, y + dy));
                }
            }
            return neighbors;
        }

        private void ChargeOctopus(Grid grid, (int x, int y) octopus)
        {
            var (x, y) = octopus;
            grid[y][x] += 1;
            if (grid[y][x] > 9 && !flashed.Contains((x, y)))
            {
                charged.Push((x, y));
            }
        }

        private void ChargeStep(Grid grid)
        {
            flashed = new List<(int x, int y)>();

            for (int y = 0; y < grid.Count; ++y)
            {
                for (int x = 0; x < grid[y].Count; ++x)
                {
                    ChargeOctopus(grid, (x, y));
                }
            }

            while (charged.Count > 0)
            {
                var (x, y) = charged.Pop();
                if (flashed.Contains((x, y))) continue;
                flashed.Add((x, y));

                foreach (var (x1, y1) in GetNeighbors(grid, (x, y)))
                {
                    ChargeOctopus(grid, (x1, y1));
                }
            }

            for (int y = 0; y < grid.Count; ++y)
            {
                for (int x = 0; x < grid[y].Count; ++x)
                {
                    if (grid[y][x] > 9)
                    {
                        grid[y][x] = 0;
                    }
                }
            }
        }

        public void Part1(Grid grid)
        {
            int flashes = 0;

            for (int i = 0; i < 100; ++i)
            {
                ChargeStep(grid);
                flashes += flashed.Count;
            }

            System.Console.Write("[Part1] ");
            System.Console.WriteLine(flashes);
        }

        private bool AllFlash(Grid grid)
        {
            for (int y = 0; y < grid.Count; ++y)
            {
                for (int x = 0; x < grid[y].Count; ++x)
                {
                    if (grid[y][x] != 0)
                    {
                        return false;
                    }
                }
            }
            return true;
        }

        public void Part2(Grid grid)
        {
            int step = 0;
            while (!AllFlash(grid))
            {
                ChargeStep(grid);
                ++step;
            }
            System.Console.Write("[Part2] ");
            System.Console.WriteLine(step);
        }

        public Grid ParseFile(string filepath)
        {
            var lines = new Grid();
            using(StreamReader file = new StreamReader(filepath))
            {
                string? line;
                while ((line = file.ReadLine()) != null)
                {
                    var row = new List<int>();
                    foreach (char c in line.ToCharArray())
                    {
                        row.Add(c - '0');
                    }
                    lines.Add(row);
                }
            }
            return lines;
        }

        public static void Main(string[] args)
        {
            var filename = "input.txt";
            var aoc = new Day11();

            var lines = aoc.ParseFile(filename);
            aoc.Part1(lines);

            lines = aoc.ParseFile(filename);
            aoc.Part2(lines);
        }
    }
}
