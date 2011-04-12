# Atheme.pm - Atheme authentication integration for Keldair
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Released under the same terms at Perl itself.

# modreq: Authen::Simple::Atheme

use strict;
use warnings;
package Keldair::Module::Authen::Atheme;

use base 'Exporter';
use Keldair;
use Authen::Simple::Atheme;

our @EXPORT = qw( &check );

my $auth = Authen::Simple::Atheme->new( host => $keldair->conf->get('authen/host'), port => $keldair->conf->get('authen/port') )
    or warn "Authen::Simple::Atheme startup failure: $!" and return;

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
