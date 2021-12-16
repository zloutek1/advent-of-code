import 'dart:io';
import 'dart:async';

extension E on String {
  String lastChars(int n) => substring(length - n);
}

class Parser {
    String hex = "";
    int ip = 0;

    String binary = "";
    int pos = 0;

    Parser(String hex) {
        this.hex = hex;
    }

    void load_next_binary_bits() {
        if (ip >= hex.length) return;

        var binary = int.parse(hex[ip], radix: 16).toRadixString(2);
        var padded = ('0000' + binary).lastChars(4);

        this.ip += 1;
        this.binary += padded;
    }

    String peek(int n) {
        while (pos + n >= binary.length && ip < hex.length) {
            load_next_binary_bits();
        }
        return binary.substring(pos, pos + n);
    }

    String eat(int n) {
        var slice = peek(n);
        this.pos += n;
        return slice;
    }

    int parse_bits_of_length(int n) {
        var value = eat(n);
        return int.parse(value, radix: 2);
    }

    int parse() {
        return parse_packet();
    }

    int parse_packet() {
        var versions_sum  = 0;

        var version = parse_version();
        var type_id = parse_type_id();
        if (type_id == 4) {
            var value = parse_literal_value();
        } else {
            var length_type_id = parse_length_type_id();
            if (length_type_id == 0) {
                var length = parse_bits_of_length(15);
                versions_sum += parse_operator_of_length(length);
            } else {
                var count = parse_bits_of_length(11);
                versions_sum += parse_operator_of_packets(count);
            }
        }

        versions_sum += version;
        return versions_sum;
    }

    int parse_operator_of_length(int length) {
        var versions_sum = 0;
        int start_pos = this.pos;
        do {
            versions_sum += parse_packet();
        } while (this.pos - start_pos < length);
        return versions_sum;
    }

    int parse_operator_of_packets(int operators) {
        var versions_sum = 0;
        for( var i = 0 ; i < operators; ++i ) {
            versions_sum += parse_packet();
        }
        return versions_sum;
    }

    int parse_version() {
        return parse_bits_of_length(3);
    }

    int parse_type_id() {
        return parse_bits_of_length(3);
    }

    int parse_literal_value() {
        var number = "";
        var part;
        do {
            part = eat(5);
            number += part.substring(1);
        } while (part[0] == '1');
        return int.parse(number, radix: 2);
    }

    int parse_length_type_id() {
        return parse_bits_of_length(1);
    }
}

void main() async {
    File('input.txt').readAsString().then((String contents) {
        var parser = new Parser(contents);
        print(parser.parse());
    });
}