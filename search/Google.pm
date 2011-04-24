# Google.pm - Google search for Keldair
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Licensed under the same terms as Perl itself.

# modreq: Google::Search

use warnings;
use strict;
package Keldair::Module::Search::Google;
use Keldair;
use Google::Search;

$keldair->syntax_add(GOOGLE => 'GOOGLE <query>');
$keldair->help_add(GOOGLE => 'Search Google for a query.');
$keldair->command_bind(GOOGLE => \&cmd_google);

sub cmd_google {
    my ( $network, $channel, $origin, $query ) = @_;
    my $search = Google::Search->web($query);
    my $output;
    for (my $i; $i < 5; $i++) {
        my $result = $search->next;
        $output .= $result->rank + 1 .'. '.$result->uri.' ';
    }
    $keldair->msg($network, $channel, "Results for \002$query\002: $output");
}

1;
