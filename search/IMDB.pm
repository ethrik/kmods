# IMDB.pm - Keldair module for searching IMDB
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Released under the same terms as Perl itself.

package Keldair::Module::IMDB;

# modreq: IMDB::Film

use strict;
use warnings;
use IMDB::Film;
use Keldair;

$keldair->command_bind(IMDB => sub {
        my ( $chan, $nick, @parv ) = @_;
        my $query = join(' ', @parv);
        my $imdb = IMDB::Film->new( crit => $query, user_agent => "Keldair/$Keldair::VERSION", timeout => 2, debug => 0, cache => 0);
        if ( $imdb->status ) { $keldair->msg($chan, 'Title: %s, Year: %s, Summary: %s', $imdb->title, $imdb->year, $imdb->plot ); }
        else { $keldair->msg($chan, "Could not find $query"); }
    }
);

1;
