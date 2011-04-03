# MegaHAL.pm - Keldair interface to the MegaHAL AI.
# Copyright 2011 Alexandria Wolcott <alyx@sporksmoo.net>
# Released under the same terms as Perl itself.

# modreq: AI::MegaHAL,Furl

use strict;
use warnings;

package Keldair::Module::MegaHAL;

use AI::MegaHAL;
use Furl;
use Keldair;
use Keldair::State;

my $hal = AI::MegaHAL->new(Path => './', Banner => 0, Prompt => 0, Wrap => 0, AutoSave => 1);
my $maxlines = $keldair->config('ai/maxlines');
my $replylines = int(rand($maxlines));
my $lines = 0;

$keldair->hook_add(OnMessage => \&handle_message);
$keldair->command_bind(CHAT => \&cmd_chat);
$keldair->command_bind(LEARN => \&cmd_learn);

sub handle_message {
    my ( $network, $channel, $origin, $message ) = @_;
    print "MegaHAL: $message\n";
    $lines++;
    print "MegaHAL lines: $lines\n";
    if ($lines == $replylines) {
        my $tosend = $hal->do_reply($message);
        $keldair->msg( $network, $channel, $tosend );
        $lines = 0;
        $replylines = int(rand($maxlines));
    }
    $hal->learn($message);
}

sub cmd_chat {
    my ( $network, $channel, $origin, $content ) = @_;
    my $tosend = $hal->do_reply($content);
    print "$tosend\n";
    $keldair->msg($network, $channel, $tosend);
}

sub cmd_learn {
    my ( $network, $channel, $origin, $content ) = @_;
    my $furl = Furl->new(
        agent => "Keldair/$Keldair::VERSION",
        timeout => 10
    );
    my @urls = split(' ', $content);
    foreach my $url (@urls) { 
        next if ($url !~ /^http(s)?:/i);
        my $res = $furl->get($url);
        $keldair->msg( $network, $channel, $res->status_line) unless $res->is_success;
        my @content = split("\n", $res->content);
        $Keldair::State::STATS{'inB'} += length($res->content);
        foreach my $data (@content) {
            $hal->learn($data);
        }
        $keldair->msg( $network, $channel, "MegaHAL: Learned $url" );
    }
}

