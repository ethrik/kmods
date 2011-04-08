# Case.pm - Capitalise/lowercase letters.
# Copyright 2011 Alexandria Wolcott <alyx@sporksmoo.net>
# Modified from Tim Riker's case.pl infobot script.
# Licensed under the same terms as Perl itself.

use warnings;
use strict;

package Keldair::Module::Case;
use Keldair;

$keldair->help_add(UPPER => 'Convert a string to UPPERCASE LETTERS.');
$keldair->help_add(LOWER => 'Convert a string to lowercase letters.');

$keldair->syntax_add($_ => "$_ <string>") foreach qw/ UPPER LOWER /;

$keldair->command_bind(UPPER => \&cmd_upper);
$keldair->command_bind(LOWER => \&cmd_lower);

sub cmd_upper {
    my ( $network, $channel, $origin, $message) = @_;

    # make it green like an old terminal
    $keldair->msg( $network, $channel, uc $message );
}

sub cmd_lower {
    my ( $network, $channel, $origin, $message) = @_;
    $keldair->msg( $network, $channel, lc $message );
}

1;

# vim:ts=4:sw=4:expandtab:tw=80

