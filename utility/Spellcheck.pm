# Spellcheck.pm - Keldair interface to Aspell, for spellchecking.
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Licensed under the same terms as Perl itself.

# modreq: Text::Aspell

package Keldair::Module::Utility::Spellcheck;

use strict;
use warnings;
use Text::Aspell;
use Keldair;

my $speller = Text::Aspell->new;

$keldair->help_add(SPELL => 'Checks the spelling of a word, and offers possible corrections.');
$keldair->syntax_add(SPELL => 'SPELL <word>');

$keldair->command_bind(SPELL => sub {
        my ( $network, $chan, $nick, $string ) = @_;
        my @suggestions = $speller->suggest($string);
        my $list = join(' ',@suggestions);
        $keldair->msg($network, $chan,"$#suggestions suggestion(s) for $string: $list");
    }
);

1;
