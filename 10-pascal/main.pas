program ReadFile;

uses
    SysUtils, Contnrs;

type
    TChar = class(TObject)
        value : char;
    end;

function calcScore(line_content: string): integer;
    const
        OPEN_BRACKETS: array[0..3] of char = ('(', '[', '{', '<');
        CLOSE_BRACKETS: array[0..3] of char = (')', ']', '}', '>');
        SCORE_MAP: array[1..4] of integer = (3, 57, 1197, 25137);

    var
        c: char;
        c_obj: TChar;
        top: TChar;
        seen_stack: TObjectStack;

    begin
        seen_stack := TObjectStack.Create;
        calcScore := 0;
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
                        calcScore := SCORE_MAP[pos(c, CLOSE_BRACKETS)];
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
            score := score + calcScore(line_content);
        write('[Part1] ');
        writeln(score);
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
end.

