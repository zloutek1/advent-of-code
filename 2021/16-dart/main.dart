import 'dart:io';
import 'dart:async';
import 'dart:math';

extension E on String {
  String lastChars(int n) => substring(length - n);
}

class Packet {
    int version = 0;
    int type_id = 0;
    int value = 0;
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
        var packet = new Packet();
        packet.version = parse_version();
        packet.type_id = parse_type_id();
        if (packet.type_id == 4) {
            packet.value = parse_literal_value();
        } else {
            var length_type_id = parse_length_type_id();
            if (length_type_id == 0) {
                var length = parse_bits_of_length(15);
                packet.value = parse_operator_of_length(packet, length);
            } else {
                var count = parse_bits_of_length(11);
                packet.value = parse_operator_of_packets(packet, count);
            }
        }
        return packet.value;
    }

    int parse_operator_of_length(Packet oper, int length) {
        var operands = [];
        int start_pos = this.pos;
        do {
            operands.add(parse_packet());
        } while (this.pos - start_pos < length);

        return eval_operator(oper, operands);
    }

    int parse_operator_of_packets(Packet oper, int operators) {
        var operands = [];
        for( var i = 0 ; i < operators; ++i ) {
            operands.add(parse_packet());
        }
        return eval_operator(oper, operands);
    }

    int eval_operator(Packet oper, List operands) {
        switch (oper.type_id) {
            case 0: return sum_operands(operands);
            case 1: return mul_operands(operands);
            case 2: return min_operands(operands);
            case 3: return max_operands(operands);
            case 5: return gt_operands(operands);
            case 6: return lt_operands(operands);
            case 7: return eq_operands(operands);
        }
        throw Exception('Unreachable');
    }

    int sum_operands(List operands) {
        return operands.fold(0, (acc, oper) => (acc + oper).toInt());
    }
    int mul_operands(List operands) {
        return operands.fold(1, (acc, oper) => (acc * oper).toInt());
    }
    int min_operands(List operands) {
        var x = operands[0];
        var xs = operands.sublist(1);
        return xs.fold(x, (acc, oper) => min(acc, oper));
    }
    int max_operands(List operands) {
        var x = operands[0];
        var xs = operands.sublist(1);
        return xs.fold(x, (acc, oper) => max(acc, oper));
    }
    int gt_operands(List operands) {
        return operands[0] > operands[1] ? 1 : 0;
    }
    int lt_operands(List operands) {
        return operands[0] < operands[1] ? 1 : 0;
    }
    int eq_operands(List operands) {
        return operands[0] == operands[1]  ? 1 : 0;
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
        print("[Part2] ${parser.parse()}");
    });
}