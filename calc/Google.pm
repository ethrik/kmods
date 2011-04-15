# calc/GCalc.pm - Google Calculator interface for Keldair
# Copyright 2011 Alexandria Wolcott <alyx@sporksmoo.net>
# Released under the same terms as Perl itself.

# modreq: WWW::Google::Calculator

package Keldair::Module::Calc::Google;

use strict;
use warnings;
use Keldair;
use WWW::Google::Calculator;

my $calc = WWW::Google::Calculator->new;

$keldair->help_add(CALC => 'Calculates a given mathmatical formula.');
$keldair->syntax_add(CALC => 'CALC <formula>');

$keldair->command_bind(CALC => 
    sub {
        my ( $network, $chan, $origin, $string ) = @_;
        $keldair->msg( $network, $chan, $calc->calc($string) );
    }
);

1;
