# Json.pm = JSON-based internal account database for Keldair
# Copyright 2011 Lee T. Starnes <lstarnes1024@gmail.com>
# Released under the same terms at Perl itself.

# modreq: Config::JSON,Digest::SHA2

use strict;
use warnings;
package Keldair::Module::Authen::Json;

use base 'Exporter';
use Keldair;
use Config::JSON;
use Digest::SHA2;

our @EXPORT = qw( &check );

my $conf = "$Bin/../etc/accounts.json";
$conf = $ENV{HOME}."/.keldair/accounts.json" if $Bin eq "/usr/bin";

my $db = Config::JSON->new($conf);

$keldair->help_add('REGISTER' => "Register an account");
$keldair->syntax_add('REGISTER' => "REGISTER <username> <password>");

$keldair->command_bind('REGISTER' => sub {
        my ( $network, $chan, $origin, $msg) = @_;
        my @parv = split(' ', $msg);
        if ( $#parv == 1 ) {
            $username = lc $parv[0];
            $password = $parv[1];
        }
        else {
            $username = lc $origin->nick;
            $password = $parv[0];
        }
	if defined($db->get(lc($username))) {
	    $keldair->msg($network, $origin, "$username is already registered.");
        }
        else {
            my $sha = new Digest::SHA2;
            $sha->add($password);
            $db->set(lc $username, $sha->hexdigest);
            $keldair->msg($network, $origin, "You are now registered as $username.");
        }
    }
);

sub check {
    my ( $username, $password ) = @_;
    return if !defined($db->get($username));
    my $sha = new Digest::SHA2;
    $sha->add($password);
    if ($sha->hexdigest eq $db->get($username)) {
	return 1;
    }
    else {
        return;
    }
}

1;
