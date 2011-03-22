# Hailo.pm - Hailo AI interface for Keldair
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Licensed under the same terms as Perl itself.

# modreq: Hailo,Acme::Llama,Any::Moose
# modconf: "ai" : { "wait" : 5, },

package Keldair::Module::Hailo;

use strict;
use warnings;
use Any::Moose;
use Keldair;
use Hailo;

my $lines = 0;

my $hailo = Hailo->new(
			brain => $ENV{HOME}."/.keldair/ai.db",
);

$keldair->hook_add(OnMessage => sub {
		my ($network, $chan, $nick, @msg) = @_;
		my $msg = join(' ',@msg);
		$lines++;
		$hailo->learn($msg);
		if ($lines >= $keldair->config('ai/wait')) {
			$keldair->msg($network,$chan,$hailo->reply);
		}
	}
);

$keldair->command_bind(CHAT => sub {
		my ($network, $chan, $nick, @msg) = @_;
		if (!@msg) {
			$keldair->msg($network,$chan,$hailo->reply);
		}
		else {
			my $msg = split(' ',@msg);
			$keldair->msg($network,$chan,$hailo->reply($msg));
		}
	}
);
