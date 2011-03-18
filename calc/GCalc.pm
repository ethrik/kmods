# calc/GCalc.pm - Google Calculator interface for Keldair
# Copyright 2011 Alexandria Wolcott <alyx@sporksmoo.net>
# Released under the same terms as Perl itself.

# modreq: WWW::Google::Calculator

use strict;
use warnings;
use Keldair;
use WWW::Google::Calculator;

my $calc = WWW::Google::Calculator->new;

$keldair->command_bind(CALC => 
    sub {
        my ( $chan, $origin, @parv ) = @_;
        my $string = join(' ', @parv );
        $keldair->msg( $chan, $calc->calc($string) );
    }
);

1;
