#include <fstream>
#include <bitset>

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

Entry parse( const std::string &line ) {

    Entry entry = {
        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0 }
    };

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

    return entry;
}

int main(void) {
    std::ifstream file("input.txt");
    int sum = 0;
    if (file.is_open()) {
        std::string line;
        while (std::getline(file, line)) {
            Entry entry = parse(line);
            sum += part1(entry);
        }
        file.close();
    }
    printf("[Part1] %d\n", sum);
    return 0;
}
