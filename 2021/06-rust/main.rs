use std::fs;
use std::io;

fn next_day(mut fishes: Vec<usize>) -> Vec<usize> {
    let parents: usize = fishes[0];
    
    fishes.rotate_left(1);
    fishes[6] += parents;
    
    return fishes;
}

fn parse_file(path: &str) -> io::Result<Vec<usize>> {
    let contents = fs::read_to_string(path)?;
    let values = contents.trim()
                         .split(",")
                         .map(|item| item.parse::<usize>().unwrap())
                         .collect::<Vec<usize>>();

    let mut days = vec![0, 0, 0, 0, 0, 0, 0, 0, 0];
    for value in values.iter() {
        days[*value] += 1;
    }

    return Ok(days);
}

fn main() {
    let mut fishes = match parse_file("input.txt") {
        Ok(fishes) => fishes,
        Err(e) => panic!("[Error]: {}, failed parsing input", e)
    };

    for _ in 0..80 {
        fishes = next_day(fishes);
    }
    println!("[Part 1] {}", fishes.iter().sum::<usize>());

    for _ in 80..256 {
        fishes = next_day(fishes);
    }
    println!("[Part 2] {}", fishes.iter().sum::<usize>());
}
