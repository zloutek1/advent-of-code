#include <fstream>
#include <bitset>
#include <algorithm>
#include <iostream>

// each digit is represented as a binary number
//
//  aa
// b  c
//  dd
// e  f
//  gg
//
// is represented as 
//
// gfedcba in binary so 0b1111111

struct Entry {
    uint8_t observations[10];
    uint8_t digits[4];
};



int part1( const Entry &entry ) {
    int counter = 0;
    for (int digit : entry.digits) {
        std::bitset<7> bits(digit);
        int ones = bits.count();
        if (ones == 2 || ones == 3 || ones == 4 || ones == 7) {
            ++counter;
        }
    }
    return counter;
}


// part2

void find_147( const Entry &entry, uint8_t digits[10]) {
    for (auto observation : entry.observations) {
        std::bitset<7> bits(observation);
        switch (bits.count()) {
            case 2: digits[1] = observation; break;
            case 3: digits[7] = observation; break;
            case 4: digits[4] = observation; break;
            case 7: digits[8] = observation; break;
        }
    } 
}

void find_2( const Entry &entry, uint8_t digits[10]) {
    int cnt_01 = 0; int cnt_10 = 0; int val_01 = 0; int val_10 = 0;

    int right_bit = 0;
    while (((digits[1] >> right_bit) & 1) == 0) {
        right_bit++;
    }

    for (auto observation : entry.observations) {
        int bit = observation & digits[1];
        if (bit == digits[1]) continue;
        
        bool is_bottom = ((bit >> right_bit) & 1) == 1;
        if (!is_bottom) {
            val_10 = observation;
            cnt_10++;
        } else {
            val_01 = observation;
            cnt_01++;
        }
    }
    digits[2] = cnt_01 == 1 ? val_01 : val_10;
}

void find_3( const Entry &entry, uint8_t digits[10]) {
    for (auto observation : entry.observations) {
        std::bitset<7> bits1(observation & ~digits[2]);
        std::bitset<7> bits2(observation & ~digits[7]);

        if (bits1.count() == 1 && bits2.count() == 2) {
            digits[3] = observation;
            return;
        }
    }
}

void decode( const Entry &entry, uint8_t digits[10]) {
    find_147(entry, digits);
    int a = digits[7] & ~digits[1];
    find_2(entry, digits);
    find_3(entry, digits);
    int f = digits[3] & ~digits[2];
    int c = digits[1] & ~f;
    int d = digits[3] & ~digits[1] & digits[4];
    int g = digits[3] & ~digits[7] & ~d;
    int e = digits[2] & ~digits[3];
    int b = digits[4] & ~digits[1] & ~d;
    digits[0] = digits[8] & ~d;
    digits[6] = digits[8] & ~c;
    digits[5] = digits[6] & ~e;
    digits[9] = digits[8] & ~e;
}

int part2( Entry &entry ) {
    uint8_t digits[10] = { 0 };
   
    decode(entry, digits);

    int result = 0;
    for (auto digit : entry.digits) {
        for (int i = 0; i < 10; ++i) {
            if (digit != digits[i]) continue;

            result *= 10;
            result += i;
        }
    }

    return result;
}



// parse file

void parse( const std::string &line, Entry &entry ) {
    int mode = 0;
    int digit = 0;
    int value = 0;
    for (size_t i = 0; i < line.length(); ++i) {
        if (isspace(line[i])) {
            if (mode == 0) { 
                entry.observations[digit] = value;
            } else {
                entry.digits[digit] = value;
            }
            ++digit;
            value = 0;
        } else if (line[i] == '|') {
            ++mode;
            digit = 0;
            value = 0;
            ++i;
        } else {
            uint8_t by = line[i] - 'a';
            value |= 1 << by;
        }
    }
    if (mode == 0) { 
        entry.observations[digit] = value;
    } else {
        entry.digits[digit] = value;
    }
}

int main(void) {
    std::ifstream file("input.txt");
    int part1_sum = 0;
    int part2_sum = 0;
    if (file.is_open()) {
        std::string line;
 
        Entry entry = {
            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
            { 0, 0, 0, 0 }
        };

        while (std::getline(file, line)) {
            parse(line, entry);
            part1_sum += part1(entry);
            part2_sum += part2(entry);
        }
        file.close();
    }
    printf("[Part1] %d\n", part1_sum);
    printf("[Part2] %d\n", part2_sum);
    return 0;
}
