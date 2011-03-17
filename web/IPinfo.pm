# IPinfo.pm - Keldair module for obtaining information on a specified IP.
# Copyright 2011 Alexandria Wolcott <alyx@sporksmoo.net>
# Licensed under the same terms as Perl itself.

# modreq: Net::Whois::IANA

use strict;
use warnings;
use Keldair;
use Net::Whois::IANA;

$keldair->command_bind(IPINFO =>
    sub {
        my ( $channel, $origin, @parv ) = @_;
        my $ip = $parv[0];
        my $iana = Net::Whois::IANA->new;
        $iana->whois_query( -ip => $ip );
        $keldair->msg( $channel, 'Info for %s: Country: %s; Netname: %s; Descr: %s; Status: %s; Source: %s; Inetnum: %s; CIDR: %s',
            $ip, $iana->country, $iana->netname, $iana->descr, $iana->status, $iana->source, $iana->server, $iana->cidr->[0] );
    }
);

1;
