# Json.pm = JSON-based internal account database for Keldair
# Copyright 2011 Lee T. Starnes <lstarnes1024@gmail.com>
# Released under the same terms at Perl itself.

# modreq: Config::JSON,Digest::SHA2

use strict;
use warnings;
package Keldair::Module::Authen::Json;

use base 'Exporter';
use Keldair;
use FindBin qw($Bin);
use Config::JSON;
use Digest::SHA2;

our @EXPORT = qw( &check );

my $file = "$Bin/../etc/accounts.json";
$file = $ENV{HOME}."/.keldair/accounts.json" if $Bin eq "/usr/bin";

my $db;

if (-e $conf) {
    $db = Config::JSON->new($file);
}
else {
    $db = Config::JSON->create($file);
}

$keldair->help_add('REGISTER' => "Register an account");
$keldair->syntax_add('REGISTER' => "REGISTER <username> <password>");

$keldair->command_bind('REGISTER' => sub {
        my ($network, $chan, $origin, $msg) = @_;
        my @parv = split(' ', $msg);
        my ($username, $password);
        if ($#parv == 1) {
            $username = lc $parv[0];
            $password = $parv[1];
        }
        else {
            $username = lc $origin->nick;
            $password = $parv[0];
        }
	if (defined($db->get(lc $username))) {
	    $keldair->msg($network, $origin, "$username is already registered.");
        }
        elsif(!$password) {
            $keldair->msg($network, $origin, "Please provide a password.");
        }
        else {
            my $sha = new Digest::SHA2;
            $sha->add($password);
            $db->set(lc $username, $sha->hexdigest);
            $keldair->msg($network, $origin, "You are now registered as $username.");
        }
    }
);

$keldair->help_add('SETPASS' => "Set a new password");
$keldair->syntax_add('SETPASS' => "SETPASS <new-password>");

$keldair->command_bind('SETPASS' => sub {
        my ($network, $chan, $origin, $msg) = @_;
        my ($password) = split(' ', $msg);
        if (!$origin->account) {
            $keldair->msg($network, $origin, "You are not logged in.");
        }
        elsif (!$password) {
            $keldair->msg($network, $origin, "Please provide a password.");
        }
        else {
           my $sha = new Digest::SHA2;
           $sha->add($password);
           $db->set($origin->account, $sha->hexdigest);
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
