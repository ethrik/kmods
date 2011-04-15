# Love.pm - Keldair module for calculating love.
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Licensed under the Artistic License

# modreq: Love::Match::Calc

package Keldair::Module::Calc::Love;

use strict;
use warnings;
use Keldair;
use Love::Match::Calc;

$keldair->help_add(LOVE => 'Calculates the love between two names');
$keldair->syntax_add(LOVE => 'LOVE <name 1> <name 2>');

$keldair->command_bind(
    LOVE => sub {
        my ( $network, $chan, $nick, $string ) = @_;
        my @names = split(' ', $string);
        if (($names[0] =~ m/^\d+$/) && ($names[1] =~ m/^\d+$/) && ($names[1] == $names[0] + 1)) {
            $keldair->msg( $network, $chan, 'Love: Try some different params.' );
        }
        else {
            my $m = lovematch( $names[0], $names[1] );
            $keldair->msg( $network, $chan, "Lovematch for $names[0] and $names[1] is $m\%" );
        }
    }
);

1;
