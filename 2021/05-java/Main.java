import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;
import java.lang.Integer;
import java.util.NoSuchElementException;
import java.util.stream.Stream;
import java.lang.Math;

public class Main {
    private final class Line {
        int fromX;
        int fromY;
        int toX;
        int toY;

        public Line(int fromX, int fromY, int toX, int toY) {
            this.fromX = fromX;
            this.fromY = fromY;
            this.toX = toX;
            this.toY = toY;
        }

        public int getFromX() { return fromX; };
        public int getFromY() { return fromY; };
        public int getToX() { return toX; };
        public int getToY() { return toY; };

        public boolean isHorizontal() { return fromY == toY; }
        public boolean isVertical() { return fromX == toX; }
        public boolean isRightDiagonal() { return toX - fromX == -(toY - fromY); }
        public boolean isDiagonal() { return toX - fromX == Math.abs(toY - fromY); } 
    }

    public int calculateIntersections(int[][] space) {
        int result = 0;
        for (int[] row : space) {
            for (int col : row) {
                if (col > 1) {
                    result += 1;
                }
            }
        }
        return result;
    }

    public int[][] placeLines_part1(int[][] space, List<Line> lines) {
        for (Line line : lines) {
            if (line.isHorizontal()) { 
                for (int x = line.getFromX(); x <= line.getToX(); ++x) {
                    space[line.getFromY()][x] += 1; 
                } 
            } else if (line.isVertical())   {
                for (int y = line.getFromY(); y <= line.getToY(); ++y) {
                    space[y][line.getFromX()] += 1;
                } 
            }
        }
        return space;
    }
    
    public int[][] placeLines_part2(int[][] space, List<Line> lines) {
        for (Line line : lines) {
            int x = line.getFromX();
            int y = line.getFromY();

            while (x <= line.getToX() || y <= line.getToY()) {
                space[y][x] += 1;
                
                if (line.isHorizontal()) { 
                    x += 1; 
                    if (x > line.getToX()) break;
                } 
                else if (line.isVertical())   {
                    y += 1; 
                    if (y > line.getToY()) break;
                } 
                else if (line.isDiagonal())   { 
                    x += 1;
                    if (line.isRightDiagonal()) {
                        y -= 1;
                        if (y < line.getToY()) break;
                    } else { 
                        y += 1;
                        if (y > line.getToY()) break;
                    }
                } else { break; }
            }
        }
        return space;
    }

    private Line processLine(String row) {
        String[] ends = row.split(" -> ");
        int[] start = Stream.of(ends[0].split(",")).mapToInt(Integer::parseInt).toArray();
        int[] end = Stream.of(ends[1].split(",")).mapToInt(Integer::parseInt).toArray();

        if (start[0] > end[0] || (start[0] == end[0] && start[1] > end[1])) {
            int[] tmp = end;
            end = start;
            start = tmp;
        }

        return new Line(
                start[0], 
                start[1], 
                end[0], 
                end[1]
        );
    }

    public List<Line> parseFile(String filename) {
        var lines = new ArrayList<Line>();

        File file = new File (filename);
        try (Scanner reader = new Scanner(file)) {
            while (reader.hasNextLine()) {
                String row = reader.nextLine();
                lines.add(processLine(row));
            }
        } catch (FileNotFoundException e) {
            System.out.println("[Error] File not found: " + e.getMessage());
            e.printStackTrace();
        }
        
        return lines;
    }

    public static void main(String[] args) {
    
        var app = new Main();
        var lines = app.parseFile("input.txt");

        int minX = lines.stream().mapToInt(Line::getFromX).min().orElseThrow(NoSuchElementException::new);
        int maxX = lines.stream().mapToInt(Line::getFromY).max().orElseThrow(NoSuchElementException::new);
        int minY = lines.stream().mapToInt(Line::getToX).min().orElseThrow(NoSuchElementException::new);
        int maxY = lines.stream().mapToInt(Line::getToY).max().orElseThrow(NoSuchElementException::new);

        var space = new int[maxY + 1][maxX + 1];
        space = app.placeLines_part1(space, lines);
        int intersections = app.calculateIntersections(space);
        System.out.println(String.format("[Part 1] %d", intersections));
        
        space = new int[maxY + 1][maxX + 1];
        space = app.placeLines_part2(space, lines);
        intersections = app.calculateIntersections(space);
        System.out.println(String.format("[Part 2] %d", intersections));
    }

}
