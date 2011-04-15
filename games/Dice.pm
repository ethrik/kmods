# Dice.pm - Dice rolling for Keldair
# Copyright 2011 Alexandria Wolcott <alyx@sporksmoo.net>
# Based on dice.pl by Time Riker <Tim@Rikers.org>
# Based on Games::Dice by Philil Newton <pne@cpan.org>
# Released under the BSD license.

use warnings;
use strict;

package Keldair::Module::Games::Dice;

use Keldair;
foreach (qw/ DICE ROLL/) {
    $keldair->syntax_add($_ => "$_ <dice combination>");
    $keldair->help_add($_ => 'Roll a combination of dice.');
    $keldair->command_bind($_ => \&cmd_dice);
}

sub roll_array ($) {
    my ($line) = shift;

    my (@throws) = ();
    return @throws unless $line =~ m{
        ^      # beginning of line
        (\d+)? # optional count in $1
        [dD]   # 'd' for dice
        (      # type of dice in $2:
        \d+ # either one or more digits
        |     # or
        %   # a percent sign for d% = d100
        )
    }x;    # whitespace allowed

    my ($num) = $1 || 1;
    my ($type) = $2;

    return @throws if $num > 100;
    $type = 100 if $type eq '%';
    return @throws if $type < 2;

    for ( 1 .. $num ) {
        push @throws, int( rand $type ) + 1;
    }

    return @throws;
}

sub roll ($) {
    my ($line) = shift;

    $line =~ s/ //g;

    return '' unless $line =~ m{
        ^              # beginning of line
        (              # dice string in $1
        (?:\d+)?     # optional count
        [dD]         # 'd' for dice
        (?:          # type of dice:
        \d+       # either one or more digits
        |           # or
        %         # a percent sign for d% = d100
        )
        )
        (?:            # grouping-only parens
        ([-+xX*/bB]) # a + - * / b(est) in $2
        (\d+)        # an offset in $3
        )?             # both of those last are optional
    }x;    # whitespace allowed in re

    my ($dice_string) = $1;
    my ($sign)        = $2 || '';
    my ($offset)      = $3 || 0;

    $sign = lc $sign;

    my (@throws) = roll_array($dice_string);
    return '' unless @throws > 0;
    my ($retval) = "rolled " . join( ' ', @throws );

    my (@result);
    if ( $sign eq 'b' ) {
        $offset = 0       if $offset < 0;
        $offset = @throws if $offset > @throws;

        @throws = sort { $b <=> $a } @throws;  # sort numerically, descending
        @result = @throws[ 0 .. $offset - 1 ]; # pick off the $offset first ones
        $retval .= " best $offset";
    }
    else {
        @result = @throws;
        $retval .= " $sign $offset" if $sign;
    }

    my ($sum) = 0;
    $sum += $_ foreach @result;
    $sum += $offset if $sign eq '+';
    $sum -= $offset if $sign eq '-';
    $sum *= $offset if ( $sign eq '*' || $sign eq 'x' );
    do { $sum /= $offset; $sum = int $sum; } if $sign eq '/';

    return "$retval <Total: $sum>";
}

sub cmd_dice {
    my ( $network, $channel, $origin, $message) = @_;
    $keldair->msg( $network, $channel, roll($message) );
}

1;
