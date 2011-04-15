# Plumber.pm - Keldair module for routing messages from one channel to another.
# Copyright 2011 Lee T. Starnes <lstarnes1024@gmail.com>
# Released under the same terms as Perl itself.

use strict;
use warnings;

package Keldair::Module::Bots::Plumber;

use Keldair;
use Keldair::State;

$keldair->hook_add(OnMessage => \&handle_message);

sub handle_message {
    my ( $network, $channel, $origin, $message ) = @_;
    if (my $filters = $keldair->config("plumber/$network/$channel")) {
	foreach my $filter (@{ $filters }) {
            my $regex = qr/$filter->{regex}/;
            if ($message =~ /$regex/) {
		$keldair->msg($filter->{to}->{network}, $keldair->find_chan($filter->{to}->{channel}), $message);
            }
        }
    }
}

