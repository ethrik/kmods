# Lolcat.pm - Keldair module for EN->LOLCAT translations.
# Copyright 2010 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Licensed under the same terms as Perl itself.

# modreq: Acme::LOLCAT

package Keldair::Module::Translate::Lolcat;

use strict;
use warnings;
use Keldair;
use Acme::LOLCAT;

$keldair->help_add(LOLCAT => 'Translates English into LOLCAT.');
$keldair->syntax_add(LOLCAT => 'LOLCAT <content to translate>');

$keldair->command_bind(
    LOLCAT => sub {
        my ( $network, $chan, $nick, $line ) = @_;
        my $lol = translate($line);
        $keldair->msg( $network, $chan, $lol );
    }
);
