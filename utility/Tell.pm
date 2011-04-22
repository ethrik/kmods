# Tell.pm - Memoserv-like telling function for Keldair.
# Copyright 2011 Alexandria Wolcott <alyx@sporksmoo.net>
# Released under the same terms as Perl itself.

use warnings;
use strict;
package Keldair::Module::Utility::Tell;
use Keldair;

$keldair->help_add(TELL => 'Tell an IRC user something.');
$keldair->syntax_add(TELL => 'TELL <user> <content>');
$keldair->command_bind(TELL => \&cmd_tell);
$keldair->hook_add(OnMessage => \&handle_message);

my %tells;

sub cmd_tell {
    my ( $network, $channel, $origin, $message ) = @_;
    my ( $target, @msg ) = split( ' ', $message );
    my $tell = join( ' ', @msg );
    push @{ $tells{$network}{$target} }, $origin->nick." told me to tell you: $tell";
}

sub handle_message {
    my ( $network, $channel, $origin, $message ) = @_;
    my $nick = $keldair->find_user($origin)->nick;
    if ($tells{$network}{$nick}) {
        foreach my $tell (@{ $tells{$network}{$nick} }) {
            $keldair->msg( $network, $keldair->find_user($origin), $tell );
        }
        delete $tells{$network}{$nick};
    }
}

1;
