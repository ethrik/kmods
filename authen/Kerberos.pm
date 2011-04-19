# Kerberos.pm - Kerberos authentication integration for Keldair
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Released under the same terms at Perl itself.

# modreq: Authen::Simple::Kerberos
# modconf: "authen":{"realm":"kerberos.realm.here."},

use strict;
use warnings;
package Keldair::Module::Authen::Kerberos;

use base 'Exporter';
use Keldair;
use Authen::Simple::Kerberos;

our @EXPORT = qw( &check );

my $auth = Authen::Simple::Kerberos->new( realm => $keldair->conf->get('authen/realm') )
    or warn "Authen::Simple::Kerberos startup failure: $!" and return;

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
