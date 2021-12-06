use std::fs;
use std::io;

fn next_day(fishes: Vec<i64>) -> Vec<i64> {
    let mut aged = fishes.iter()
                         .map(|x| x - 1)
                         .collect::<Vec<i64>>();
    for i in 0..aged.len() {
        if aged[i] < 0 {
            aged[i] = 6;
            aged.push(8);
        }
    }

    return aged;
}

fn parse_file(path: &str) -> io::Result<Vec<i64>> {
    let contents = fs::read_to_string(path)?;
    let values = contents.trim()
                         .split(",")
                         .map(|item| item.parse::<i64>().unwrap())
                         .collect::<Vec<i64>>();
    return Ok(values);
}

fn main() {
    println!("Hello, World!");
    let mut fishes = match parse_file("input.txt") {
        Ok(fishes) => fishes,
        Err(e) => panic!("[Error]: {}, failed parsing input", e)
    };

    for _ in 0..80 {
        fishes = next_day(fishes);
    }
    println!("{:?}", fishes.len());
}
