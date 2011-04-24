# CPAN.pm - Search the CPAN from within Keldair
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Licensed under the same terms as Perl itself.

# modreq: WWW::CPAN

use warnings;
use strict;
package Keldair::Module::Search::CPAN;
use Keldair;
use WWW::CPAN;

$keldair->syntax_add(CPAN => 'CPAN <package>');
$keldair->help_add(CPAN => 'Search the Arch Linux User Repository for a package.');
$keldair->command_bind(CPAN => \&cmd_cpan);

sub cmd_cpan {
    my ( $network, $channel, $origin, $message ) = @_;
    my $cpan = WWW::CPAN->new;
    my $pkg = $cpan->search({ query => $message, mode => 'dist', n => 1});
    if ($pkg) {
        my $dist = $pkg->{dist}[0];
        my $maintainer = $dist->{author}{link} =~ /http:\/\/search.cpan.org\/~(.*)\//;
        $keldair->msg($network, $channel, "Package %s (Description: %s) is maintained by %s, was released on %s, and is located at %s.",
            $dist->{name}, $dist->{description}, $maintainer, $dist->{released}, $dist->{link} );
    }
    else {
        $keldair->msg($network, $channel, "No results found for $message.");
    }
}
