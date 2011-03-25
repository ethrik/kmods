# Brainfuck.pm - Brainfuck interpreter for Keldair
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Released under the same terms as Perl itself.

# modreq: Language::BF

use strict;
use warnings;
package Keldair::Module::Brainfuck;

use Language::BF;
use Keldair;

$keldair->help_add(BF => 'Evaluates a snippet of Brainfuck code.');
$keldair->syntax_add(BF => 'BF <code>');

$keldair->command_bind(BF => 
    sub {
        my ( $network, $chan, $nick, $string ) = @_;
        my $bf = Language::BF->new($string);
        $bf->run;
        $keldair->msg($network, $chan, $bf->output);
    }
);

1;
