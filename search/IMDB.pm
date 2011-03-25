# IMDB.pm - Keldair module for searching IMDB
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Released under the same terms as Perl itself.

package Keldair::Module::IMDB;

# modreq: IMDB::Film

use strict;
use warnings;
use IMDB::Film;
use Keldair;

$keldair->help_add(IMDB => 'Searches IMDB for film information.');
$keldair->syntax_add(IMDB => 'IMDB <search terms>');

$keldair->command_bind(IMDB => sub {
        my ( $network, $chan, $nick, $query ) = @_;
        my $imdb = IMDB::Film->new( crit => $query, user_agent => "Keldair/$Keldair::VERSION", timeout => 2, debug => 0, cache => 0);
        if ( $imdb->status ) { $keldair->msg($network, $chan, 'Title: %s, Year: %s, Summary: %s', $imdb->title, $imdb->year, $imdb->plot ); }
        else { $keldair->msg($network, $chan, "Could not find $query"); }
    }
);

1;
