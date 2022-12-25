import { readFileSync } from 'fs';

// part 1
const mostCommon = (counter: Record<string, number>, a: string, b: string) => counter[a] == counter[b] ? b : counter[a] > counter[b] ? a : b;
const leastCommon = (counter: Record<string, number>, a: string, b: string) => counter[a] == counter[b] ? a : counter[a] < counter[b] ? a : b;

const getCommonBit = (bits: string[], cmp: (counter: Record<string, number>, a: string, b: string) => string) => {
    const counter: Record<string, number> = {};
    for (const j in bits) {
        counter[bits[j]] ??= 0
        counter[bits[j]] += 1;
    }
    return cmp(counter, '0', '1');
}

const getCommonBits = (bytes: string[], cmp: (counter: Record<string, number>, a: string, b: string) => string) => {
    const result = []
    for (let i = 0; i < bytes[0].length; ++i) {
        result.push(getCommonBit(bytes.map(byte => byte[i]), cmp));
    }
    return parseInt( result.join(""), 2)
}

// part 2
const reduceCommonBits = (bytes: string[], cmp: (counter: Record<string, number>, a: string, b: string) => string) => {
    for (let i = 0; i < bytes[0].length; ++i) {
        bytes = bytes.filter(byte => byte[i] === getCommonBit(bytes.map(byte => byte[i]), cmp))
        if (bytes.length == 1)
            break
    }
    return parseInt( bytes.join(""), 2)
}


const file = readFileSync('input.txt', 'utf-8').trim();
const lines = file.split("\n");

const gamma = getCommonBits(lines, mostCommon);
const epsilon = getCommonBits(lines, leastCommon);
console.log("[day1]", gamma * epsilon);

const O2 = reduceCommonBits(lines, mostCommon);
const CO2 = reduceCommonBits(lines, leastCommon);
console.log("[day2]", O2 * CO2)