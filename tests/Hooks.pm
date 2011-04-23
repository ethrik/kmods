# THooks.pm - Keldair module for testing hooks.
# Copyright 2011 Matthew Barksdale <matthew@matt-tech.info>
# Licensed under the Artistic License

package Keldair::Module::Tests::THooks;

use strict;
use warnings;
use Keldair;


$keldair->help_add(THOOKS => 'Tests hooks');
$keldair->syntax_add(THOOKS => 'THOOKS <test string>');

$keldair->command_bind(
    THOOKS => sub {
        my ( $network, $channel, $origin, $string ) = @_;
	    my $nick = $origin->nick;
        my $chan = $channel->name;
        $keldair->hook_run(OnJoin => $network, $nick, $chan);
        $keldair->hook_run(OnKick => $network, $nick, $chan);
        $keldair->hook_run(OnJoin => $network, $nick, $chan);
        $keldair->hook_run(OnPart => $network, $nick, $chan);
        $keldair->hook_run(OnNotice => $network, $nick, $chan, $string);
        $keldair->hook_run(OnMessage => $network, $chan, $nick, $string);
        $keldair->hook_run('OnRehash');
    }
);
