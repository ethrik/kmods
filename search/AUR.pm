# AUR.pm - Search the AUR from within Keldair
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Licensed under the same terms as Perl itself.

# modreq: WWW::AUR

use warnings;
use strict;
package Keldair::Module::Search::AUR;
use Keldair;
use WWW::AUR;

$keldair->syntax_add(AUR => 'AUR <package>');
$keldair->help_add(AUR => 'Search the Arch Linux User Repository for a package.');
$keldair->command_bind(AUR => \&cmd_aur);

sub cmd_aur {
    my ( $network, $channel, $origin, $message ) = @_;
    my $aur = WWW::AUR->new;
    my $pkg = $aur->find($message);
    if ($pkg) {
        local $" = ', ';
        $keldair->msg($network, $channel, "Package %s (ID: %s, description: %s) is maintained by %s, is %s bytes, is licensed under %s, and is located at %s.",
            $pkg->name, $pkg->id, $pkg->desc, $pkg->maintainer->name, $pkg->download_size, $pkg->license, $pkg->url);
    }
    else {
        $keldair->msg($network, $channel, "No results found for $message.");
    }
}
