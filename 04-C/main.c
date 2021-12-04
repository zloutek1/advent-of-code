#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <memory.h>

const int BOARD_WIDTH = 5;
const int BOARD_HEIGHT = 5;

typedef int **Board;

struct Game {
    int *input;
    Board *boards;

    int input_size;
    int boards_len;

    int input_capacity;
    int boards_capacity;
};

// dispaly functions

void print_game(struct Game *game) {
    printf("%d\n", game->input_size);
    for (int i = 0; i < game->input_size; ++i) {
        printf("%d,", game->input[i]);
    }
    printf("\n\n\n");

    printf("%d\n", game->boards_len);
    for (int i = 0; i < game->boards_len; ++i) {
        for (int j = 0; j < BOARD_HEIGHT; ++j) {
            for (int k = 0; k < BOARD_WIDTH; ++k) {
                if (game->boards[i][j][k] == -1) {
                    printf("xx ");
                } else {
                    printf("%2d ", game->boards[i][j][k]);
                }
            }
            printf("\n");
        }
        printf("\n\n\n");
    }
}

void print_board(Board board) {
    for (int j = 0; j < BOARD_HEIGHT; ++j) {
        for (int k = 0; k < BOARD_WIDTH; ++k) {
            printf("%d,", board[j][k]);
        }
        printf("\n");
    }
    printf("\n\n\n");
}


// solution

int sum_unparked(Board board) {
    int sum = 0;
    for (int y = 0; y < BOARD_HEIGHT; ++y) {
        for (int x = 0; x < BOARD_WIDTH; ++x) {
            if (board[y][x] != -1) {
                sum += board[y][x];
            }
        }
    }
    return sum;
}

bool check_row(Board board, int w, int h) {
    for (int y = 0; y < h; ++y) {
        bool winnable = true;
        for (int x = 0; x < w; ++x) {
            if (board[y][x] != -1) {
                winnable = false;
                break;
            }
        }
        if (winnable) {
            return true;
        }
    }
    return false;
}

bool check_col(Board board, int w, int h) {
    for (int x = 0; x < w; ++x) {
        bool winnable = true;
        for (int y = 0; y < h; ++y) {
            if (board[y][x] != -1) {
                winnable = false;
                break;
            }
        }
        if (winnable) {
            return true;
        }
    }
    return false;
}

int did_win_part1(struct Game *game) {
    for (int i = 0; i < game->boards_len; ++i) {
        bool did_board_win = false;

        Board board = game->boards[i];
        
        did_board_win = did_board_win || check_row(board, BOARD_HEIGHT, BOARD_WIDTH);
        did_board_win = did_board_win || check_col(board, BOARD_WIDTH, BOARD_HEIGHT);

        if (did_board_win) {
            return i;
        }
    }
    return -1;
}

int did_win_part2(struct Game *game, bool *boards_won) {
    int board_won = -1;

    for (int i = 0; i < game->boards_len; ++i) {
        bool did_board_win = false;

        Board board = game->boards[i];
        
        did_board_win = did_board_win || check_row(board, BOARD_HEIGHT, BOARD_WIDTH);
        did_board_win = did_board_win || check_col(board, BOARD_WIDTH, BOARD_HEIGHT);

        if (did_board_win) {
            if (!boards_won[i]) {
                board_won = i;
            }
            boards_won[i] = true;
        }
    }

    return board_won;
}

void mark_number(Board board, int number) {
    for (int y = 0; y < BOARD_HEIGHT; ++y) {
        for (int x = 0; x < BOARD_WIDTH; ++x) {
            if (board[y][x] == number) {
                board[y][x] = -1;
            }
        }
    }
}

void bingo_turn(struct Game *game, int turn) {
    int number = game->input[turn];
    for (int i = 0; i < game->boards_len; ++i) {
        Board board = game->boards[i];
        mark_number(board, number);
    }
}

// part1

void play_bingo_part1(struct Game *game) {
    int turn = 0;
    int board_won;
    while ((board_won = did_win_part1(game)) < 0) {    
        bingo_turn(game, turn++);
    }
    --turn;

    int sum_of_unmarked = sum_unparked(game->boards[board_won]); 
    int called_number = game->input[turn];
    printf("[part1] %d\n", sum_of_unmarked * called_number); 
}

int f(bool *a, int size) {
    int sum = 0;
    for (int i = 0; i < size; ++i) {
        if (a[i]) {
            sum += 1;
        }
    }
    return sum;
}

// part2
void play_bingo_part2(struct Game *game) {
    bool *boards_won = malloc(game->boards_len);
    memset(boards_won, false, game->boards_len);

    int turn = 0;
    int board_won;
    while (f(boards_won, game->boards_len) != game->boards_len) {    
        bingo_turn(game, turn++);
        board_won = did_win_part2(game, boards_won);
    }
    --turn;

    int sum_of_unmarked = sum_unparked(game->boards[board_won]); 
    int called_number = game->input[turn];
    printf("[part2] %d\n", sum_of_unmarked * called_number); 

    free(boards_won);
}




// load input

void load_input(FILE *fp, struct Game *game) {
    int i = 0;
    int num;
    
    fscanf(fp, "%d", &num);
    game->input[i++] = num;
    game->input_size = i;

    while (fscanf(fp, ",%d", &num) > 0) {
        if (game->input_capacity <= i) {
            int *ptr = realloc(game->input, (game->input_capacity + 10) * sizeof(int));
            if (ptr == NULL) {
                free(game->input);
                printf("Failed to resize input array");
                exit(1);
            }
            game->input = ptr;
            game->input_capacity += 10;
        }

        game->input[i++] = num;
        game->input_size = i;
    }
}

int *load_row(FILE *fp, int board_size) {
    int *row = malloc(board_size * sizeof(int));
    for (int i = 0; i < board_size; ++i) {
        int num;
        int success = fscanf(fp, "%d", &num);
        if (success < 0) {
            free(row);
            return NULL;
        }
        row[i] = num;
    }
    return row;
}

Board load_board(FILE *fp, int board_width, int board_height) {
    Board board = malloc(board_height * sizeof(Board));
    for (int i = 0; i < board_height; ++i) {
        int *row = load_row(fp, board_width);
        if (row == NULL) {
            free(board);
            return NULL;
        }
        board[i] = row;
    }
    return board;
}

void load_boards(FILE *fp, struct Game *game) {
    int i = 0;
    Board board;
    while ((board = load_board(fp, BOARD_WIDTH, BOARD_HEIGHT)) != NULL) {
        if (board == NULL) break;

        if (game->boards_capacity <= i) {
            Board *ptr = realloc(game->boards, (game->boards_capacity + 10) * sizeof(Board));
            if (ptr == NULL) {
                free(game->boards);
                printf("failed to resize boards array");
                exit(1);
            }
            game->boards = ptr;
            game->boards_capacity += 10;
        }

        game->boards[i++] = board;
        game->boards_len++;
    }
}

struct Game *parse_file(char* path) {
    FILE *fp = fopen(path, "r");
    if (fp == NULL) {
        printf("Could not read file\n");
        exit(1);
    }

    int *input = malloc(10 * sizeof(int));
    Board *boards = malloc(1 * sizeof(Board));

    struct Game *game = malloc(sizeof(struct Game));
    game->input = input;
    game->input_size = 0;
    game->input_capacity = 10;

    game->boards = boards;
    game->boards_len = 0;
    game->boards_capacity = 1;

    load_input(fp, game);
    load_boards(fp, game);

    fclose(fp);

    return game;
}


void cleanup(struct Game *game) {
    free(game->input); 
    for (int i = 0; i < game->boards_len; ++i) {
        for (int j = 0; j < BOARD_HEIGHT; ++j) {
            free(game->boards[i][j]);
        }
        free(game->boards[i]);
    }
    free(game->boards);
    free(game);
}

int main(void) {
    struct Game *game = parse_file("example_input.txt");
    
    play_bingo_part1(game);
    play_bingo_part2(game);

    cleanup(game);
    
    return 0;
}
