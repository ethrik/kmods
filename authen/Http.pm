# HTTP.pm - HTTP authentication for Keldair
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Released under the same terms at Perl itself.

# modreq: Authen::Simple::HTTP

use strict;
use warnings;
package Keldair::Module::Authen::Http;

use base 'Exporter';
use Keldair;
use Authen::Simple::HTTP;

our @EXPORT = qw( &check );

my $auth = Authen::Simple::HTTP->new( url => $keldair->conf->get('authen/url') )
    or warn "Authen::Simple::HTTP startup failure: $!" and return;

sub check {
    my ( $username, $password ) = @_;
    if ( $auth->check( $username, $password ) ) {
            return 1;
    }
    else {
        return;
    }
}

1;
