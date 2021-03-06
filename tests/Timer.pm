# TTimer.pm - Keldair module for testing timers.
# Copyright 2011 Matthew Barksdale <matthew@matt-tech.info>
# Licensed under the Artistic License

package Keldair::Module::Tests::TTimer;

use strict;
use warnings;
use Keldair;

my $timer = Keldair::Timer->new;

$keldair->help_add(TTIMER => 'Tests timers');
$keldair->syntax_add(TTIMER => 'TTIMER');

$keldair->command_bind(
    TTIMER => sub {
        my ( $network, $chan, $nick, $string ) = @_;
	$keldair->msg( $network, $chan, "Sending COWS after 10 seconds.");
	$timer->after(10, sub { $keldair->msg( $network, $chan, "COWS");  });
	$keldair->msg( $network, $chan, "Sending MOO every 10 seconds for 30 seconds...");
	my $rtimer = $timer->every(10, sub { $keldair->msg( $network, $chan, "MOO"); });
	$timer->after(30, sub { $timer->delete($rtimer); });
    }
);
