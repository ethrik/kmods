# TextTransform.pm - A Keldair module for various text transformation commands.
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Licensed under the same terms as Perl itself.

package Keldair::Module::Utility::TextTransform;

use strict;
use warnings;
use Keldair;

$keldair->help_add(UC => 'Convert a string to CAPITAL LETTERS.');
$keldair->help_add(LC => 'Convert a string to lowercase letters.');
$keldair->help_add(REVERSE => 'Reverse a string.');
$keldair->syntax_add("$cmd <string>") foreach my $cmd qw( UC LC REVERSE );

$keldair->command_bind(UC => sub { my ($net, $chan, $origin, $string) = @_; $keldair->msg($net, $chan, uc($string)); });
$keldair->command_bind(LC => sub { my ($net, $chan, $origin, $string) = @_; $keldair->msg($net, $chan, lc($string)); });
$keldair->command_bind(REVERSE => sub { my ($net, $chan, $origin, $string) = @_; $keldair->msg($net, $chan, reverse($string)); });

1;
