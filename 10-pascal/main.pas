
Program ReadFile;

Uses
SysUtils, Contnrs;

Type
  TChar = Class(TObject)
    value : char;
  End;

Const
  OPEN_BRACKETS: array[0..3] Of char = ('(', '[', '{', '<');
  CLOSE_BRACKETS: array[0..3] Of char = (')', ']', '}', '>');

Function CalcIllegalScore(line_content: String): integer;
  Const
    SCORE_MAP: array[1..4] Of integer = (3, 57, 1197, 25137);

  Var
    c: char;
    c_obj: TChar;
    top: TChar;
    seen_stack: TObjectStack;

  Begin
    seen_stack := TObjectStack.Create;
    calcIllegalScore := 0;
    For c In line_content Do
      Begin
        If (pos(c, OPEN_BRACKETS) > 0) Then
          Begin
            c_obj := TChar.Create;
            c_obj.value := c;
            seen_stack.push(c_obj);
          End
        Else
          Begin
            top := TChar(seen_stack.Pop());
            If (pos(top.value, OPEN_BRACKETS) <> pos(c, CLOSE_BRACKETS)) Then
              Begin
                calcIllegalScore := SCORE_MAP[pos(c, CLOSE_BRACKETS)];
                Break;
              End
          End;
      End;
  End;

Procedure Part1(lines: Array Of String);
  Var
    score: integer;
    line_content: string;

  Begin
    score := 0;
    For line_content In lines Do
      score := score + calcIllegalScore(line_content);
    write('[Part1] ');
    writeln(score);
  End;

Function CalcAutocompleteScore(line_content: String): Int64;
  Const
    SCORE_MAP: array[1..4] Of integer = (1, 2, 3, 4);

  Var
    c: char;
    c_obj: TChar;
    top: TChar;
    seen_stack: TObjectStack;
    isValid: boolean;
    score: Int64;

  Begin
    seen_stack := TObjectStack.Create;
    isValid := true;
    For c In line_content Do
      Begin
        If (pos(c, OPEN_BRACKETS) > 0) Then
          Begin
            c_obj := TChar.Create;
            c_obj.value := c;
            seen_stack.push(c_obj);
          End
        Else
          Begin
            top := TChar(seen_stack.Pop());
            If (pos(top.value, OPEN_BRACKETS) <> pos(c, CLOSE_BRACKETS)) Then
              Begin
                isValid := false;
                Break;
              End
          End;
      End;

    score := 0;
    If (isValid) Then
      Begin
        While seen_stack.Peek() <> Nil Do
          Begin
            top := TChar(seen_stack.Pop());
            score := score * 5 + SCORE_MAP[pos(top.value, OPEN_BRACKETS)];
          End;
      End;

    CalcAutocompleteScore := score;
  End;

Function FindMiddle(scores: Array Of Int64): Int64;
  Var
    a, b: Int64;
    min: Int64;
    temp: Int64;

  Begin
    For a := 0 To length(scores) - 2 Do
      Begin
        min := a;
        For b := a To length(scores) - 1 Do
          Begin
            If scores[b] < scores[min] Then
              min := b
          End;
        temp := scores[a];
        scores[a] := scores[min];
        scores[min] := temp;
      End;

    FindMiddle := scores[length(scores) Div 2];
  End;

Procedure Part2(lines: Array Of String);
  Var
    index: integer;
    score: Int64;
    scores: array Of Int64;
    line_content: string;

  Begin
    index := 0;
    For line_content In lines Do
      Begin
        score := CalcAutocompleteScore(line_content);
        If score > 0 Then
          Begin
            SetLength(scores, index + 1);
            scores[index] := score;
            Inc(index);
          End
      End;

    write('[Part2] ');
    writeln(FindMiddle(scores));
  End;


Const
  FILENAME = 'input.txt';

Var
  fp: TextFile;

  lineno: integer;
  line_content: string;
  lines: array Of string;

Begin
  AssignFile(fp, FILENAME);
  Try
    reset(fp);

    lineno := 0;
    While Not eof(fp) Do
      Begin
        readln(fp, line_content);
        SetLength(lines, lineno + 1);
        lines[lineno] := line_content;
        lineno := lineno + 1;
      End;

    CloseFile(fp);
  Except
    on E: EInOutError Do
          writeln('File handling error occurred. Details: ', E.Message);
End;

Part1(lines);
Part2(lines);
End.
