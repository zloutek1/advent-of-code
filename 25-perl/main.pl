#!/usr/bin/perl
use warnings;
use strict;
use Storable qw(dclone);

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };

sub Step {
    my @grid = @_;
    my $height = scalar @grid;
    my $width = scalar @{ $grid[0] };

    my $moved = 0;
    my @newgrid = @{ dclone(\@grid) };
    for my $y (0 .. $height - 1) {
        for my $x (0 .. $width - 1) {
            if ($grid[$y][$x] eq '>' and $grid[$y][($x + 1) % $width] eq '.') {
                $newgrid[$y][$x] = '.';
                $newgrid[$y][($x + 1) % $width] = '>';
                $moved = 1;
            }
        }
    }

    @grid = @{ dclone(\@newgrid) };
    for my $y (0 .. $height - 1) {
        for my $x (0 .. $width - 1) {
            if ($grid[$y][$x] eq 'v' and $grid[($y + 1) % $height][$x] eq '.') {
                $newgrid[$y][$x] = '.';
                $newgrid[($y + 1) % $height][$x] = 'v';
                $moved = 1;
            }
        }
    }

    return ($moved, @newgrid);
}

sub PrintGrid {
    my @grid = @_;
    for my $y (0 .. scalar @grid - 1) {
        for my $x (0 .. scalar @{ $grid[$y] } - 1) {
            print $grid[$y][$x];
        }
        print "\n";
    }
    print "\n";
}

sub ParseFile {
    my ($filename) = @_;
    open(FH, '<', $filename) or die $!;

    my @grid = ();
    while(<FH>){
        my @row = split //, trim($_);
        push @grid, \@row;
    }

    close(FH);

    return @grid;
}

my @grid = ParseFile("input.txt");
PrintGrid(@grid);

my $step = 1;
(my $changed, @grid) = Step(@grid);
while ($changed == 1) {
    ($changed, @grid) = Step(@grid);
    $step += 1;
}

PrintGrid(@grid);
print "$step\n";