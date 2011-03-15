# Lastfm.pm - Keldair module for interfacing to Last.FM
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Licensed under the same terms as Perl itself.

# modreq: Net::LastFM
# modconf: "lastfm" { "api" : "", "secret" : "" },

package Keldair::Module::Lastfm;

use strict;
use warnings;
use Net::LastFM;
use Keldair;


my $lastfm = Net::LastFM->new(
    api_key    =>  $keldair->config('lastfm/key'),
    api_secret =>  $keldair->config('lastfm/secret'),
);

$keldair->command_bind($_ => \&lastfm) foreach qw( NP LASTFM NOWPLAYING );

sub lastfm {
    my ( $chan, $origin, @parv ) = @_;
    my $data = $lastfm->request_signed(
        method => 'user.getRecentTracks',
        user   => $parv[0],
        limit  => 1
    );
    my ($artist, $song);
    if (ref($data->{recenttracks}->{track}) eq 'HASH') {
        $artist = $data->{recenttracks}->{track}->{artist}->{'#text'};
        $song = $data->{recenttracks}->{track}->{name};
    }
    elsif (ref($data->{recenttracks}->{track}) eq 'ARRAY') {
        $artist = $data->{recenttracks}->{track}->[0]->{artist}->{'#text'};
        $song = $data->{recenttracks}->{track}->[0]->{name};
    }
    $keldair->msg($chan, "$parv[0] is now playing: $artist - $song");
}
