# IPinfo.pm - Keldair module for obtaining information on a specified IP.
# Copyright 2011 Alexandria Wolcott <alyx@sporksmoo.net>
# Licensed under the same terms as Perl itself.

# modreq: Net::Whois::IANA,Regexp::Common

use strict;
use warnings;
use Keldair;
use Net::Whois::IANA;
use Regexp::Common qw/net/;

$keldair->help_add(IPINFO => 'Gives basic information about an IP address.');
$keldair->syntax_add(IPINFO => 'IPINFO <IPv4 IP address>');

$keldair->command_bind(IPINFO =>
    sub {
        my ( $network, $channel, $origin, @parv ) = @_;
        my $ip = $parv[0];
        if ($ip =~ /^$RE{net}{IPv4}$/) {
            my $iana = Net::Whois::IANA->new;
            $iana->whois_query( -ip => $ip );
            $keldair->msg( $network, $channel, 'Info for %s: Country: %s; Netname: %s; Descr: %s; Status: %s; Source: %s; Inetnum: %s; CIDR: %s',
                $ip, $iana->country, $iana->netname, $iana->descr, $iana->status, $iana->source, $iana->server, $iana->cidr->[0] );
        }
        else {
            $keldair->msg( $network, $channel, 'The address %s is not valid.', $ip );
        }
    }
);

1;
