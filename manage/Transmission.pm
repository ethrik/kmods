# Transmission.pm - Manage a Transmission instance from within Keldair
# Copyright 2011 Alexandria Wolcott <alyx@sporksmoo.net>
# Released under the same terms as Perl itself.

# modreq: Transmission::Client,feature
# modconf: {"transmission":{"username":"","password":"","url":""}} # Optional

use warnings;
use strict;
package Keldair::Module::Manage::Transmission;
use Keldair;
use feature 'switch';
use Transmission::Client;

my $client = Transmission::Client->new;
$client->username($keldair->config('transmission/username')) if $keldair->config('transmission/username');
$client->password($keldair->config('transmission/password')) if $keldair->config('transmission/password');
$client->url($keldair->config('transmission/url')) if $keldair->config('transmission/url');

$keldair->command_bind(TORRENT => \&cmd_torrent);

sub cmd_torrent {
    my ( $network, $channel, $origin, $message ) = @_;
    my @parv = split(' ', $message);
    my @args = ( $network, $channel, $origin, @parv);
    _fail($network, $channel, $origin) and return unless $origin->account && $origin->account ~~ @{ $keldair->config('account/admin') };
    given (uc($parv[0])) {
        when ('LIST') { _list(@args); }
        when ('ADD') { _add(@args); }
        when ('START') { _start(@args); }
        when ('STOP') { _stop(@args); }
    }
}

sub _fail {
    my ( $network, $channel, $origin ) = @_;
    $keldair->msg($network, $channel, '%s: You are not authorised to perform this action.', $origin->nick);
    return 1;
}

sub _list {
    my ( $network, $channel, $origin, @parv ) = @_;
    my $output;
    for my $torrent (@{ $client->torrents }) {
        $output .= $torrent->name.' (ID: '.$torrent->id.'), ';
    }
    chop $output and chop $output;
    $keldair->msg($network, $channel, $output);
}

sub _add {
    my ( $network, $channel, $origin, @parv ) = @_;
    shift @parv;
    foreach my $url (@parv) {
        $client->add(filename => $url);
        $keldair->msg($network, $channel, 'Added %s to Transmission.', $url);
    }
}

sub _start {
    my ( $network, $channel, $origin, @parv ) = @_;
    shift @parv;
    foreach my $id (@parv) {
        $client->start($id)
            and $keldair->msg($network, $channel, "Started torrent number $id");
    }
}

sub _stop {
    my ( $network, $channel, $origin, @parv ) = @_;
    shift @parv; 
    foreach my $id (@parv) {
        $client->stop($id)
            and $keldair->msg($network, $channel, "Stopped torrent number $id")
    }
}

1;
