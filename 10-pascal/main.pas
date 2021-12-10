program ReadFile;

uses
    SysUtils, Contnrs;

type
    TChar = class(TObject)
        value : char;
    end;

const
    OPEN_BRACKETS: array[0..3] of char = ('(', '[', '{', '<');
    CLOSE_BRACKETS: array[0..3] of char = (')', ']', '}', '>');

function calcIllegalScore(line_content: string): integer;
    const
        SCORE_MAP: array[1..4] of integer = (3, 57, 1197, 25137);

    var
        c: char;
        c_obj: TChar;
        top: TChar;
        seen_stack: TObjectStack;

    begin
        seen_stack := TObjectStack.Create;
        calcIllegalScore := 0;
        for c in line_content do
        begin
            if (pos(c, OPEN_BRACKETS) > 0) then
            begin
                c_obj := TChar.Create;
                c_obj.value := c;
                seen_stack.push(c_obj);
            end
            else
            begin
                top := TChar(seen_stack.Pop());
                if (pos(top.value, OPEN_BRACKETS) <> pos(c, CLOSE_BRACKETS)) then
                begin
                    calcIllegalScore := SCORE_MAP[pos(c, CLOSE_BRACKETS)];
                    Break;
                end
            end;
        end;
    end;

procedure part1(lines: array of string);
    var
        score: integer;
        line_content: string;

    begin
        score := 0;
        for line_content in lines do
            score := score + calcIllegalScore(line_content);
        write('[Part1] ');
        writeln(score);
    end;

function calcAutocompleteScore(line_content: string): Int64;
    const
        SCORE_MAP: array[1..4] of integer = (1, 2, 3, 4);

    var
        c: char;
        c_obj: TChar;
        top: TChar;
        seen_stack: TObjectStack;
        isValid: boolean;
        score: Int64;

    begin
        seen_stack := TObjectStack.Create;
        isValid := true;
        for c in line_content do
        begin
            if (pos(c, OPEN_BRACKETS) > 0) then
            begin
                c_obj := TChar.Create;
                c_obj.value := c;
                seen_stack.push(c_obj);
            end
            else
            begin
                top := TChar(seen_stack.Pop());
                if (pos(top.value, OPEN_BRACKETS) <> pos(c, CLOSE_BRACKETS)) then
                begin
                    isValid := false;
                    Break;
                end
            end;
        end;

        score := 0;
        if (isValid) then
        begin
            while seen_stack.Peek() <> Nil do
            begin
                top := TChar(seen_stack.Pop());
                score := score * 5 + pos(top.value, OPEN_BRACKETS);
            end;
        end;

        calcAutocompleteScore := score;
    end;

function findMiddle(scores: array of Int64): Int64;
    var
        a, b: Int64;
        min: Int64;
        temp: Int64;

        score: Int64;

    begin
        for a := 0 to length(scores) - 2 do
        begin
            min := a;
            for b := a to length(scores) - 1 do
            begin
                if scores[b] < scores[min] then
                    min := b
            end;
            temp := scores[a];
            scores[a] := scores[min];
            scores[min] := temp;
        end;

        findMiddle := scores[length(scores) div 2];
    end;

procedure part2(lines: array of string);
    var
        index: integer;
        score: Int64;
        scores: array of Int64;
        line_content: string;

    begin
        index := 0;
        for line_content in lines do
        begin
            score := calcAutocompleteScore(line_content);
            if score > 0 then
            begin
                SetLength(scores, index + 1);
                scores[index] := score;
                Inc(index);
            end
        end;

        write('[Part2] ');
        writeln(findMiddle(scores));
    end;


const
    FILENAME = 'input.txt';

var
    fp: TextFile;
    
    lineno: integer;
    line_content: string;
    lines: array of string;

begin
    AssignFile(fp, FILENAME);
    try
        reset(fp);

        lineno := 0;
        while not eof(fp) do
        begin
            readln(fp, line_content);
            SetLength(lines, lineno + 1);
            lines[lineno] := line_content;
            lineno := lineno + 1;
        end;

        CloseFile(fp);
    except
        on E: EInOutError do
            writeln('File handling error occurred. Details: ', E.Message);
    end;

    part1(lines);
    part2(lines);
end.

