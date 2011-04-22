# Urban.pm - UrbanDictionary lookup from Keldair
# Copyright 2011 Alexandria Wolcott <alyx@sporksmoo.net>
# Released under the same terms as Perl itself.

# modreq: Furl,HTML::Tree

use strict;
use warnings;
package Keldair::Module::Dict::Urban;
use Keldair;
use Furl;
use HTML::Tree;

$keldair->help_add(UD => 'Search UrbanDictionary for a term.');
$keldair->syntax_add(UD => 'UD <term>');
$keldair->command_bind(UD => \&cmd_ud);

sub cmd_ud {
    my ( $network, $channel, $origin, $term ) = @_;
    my $furl = Furl->new(
        agent => "Keldair/$Keldair::VERSION",
        timeout => 10
    );
    $term =~ s/^ //;
    my $search = $term;
    $search =~ s/ /\+/g;
    my $res = $furl->get("http://www.urbandictionary.com/tooltip.php?term=$search");
    if (!$res->is_success) {
        $keldair->msg($network, $channel, 'Something went wrong: %s', $res->status_line);
    }
    else {
        my $tree = HTML::Tree->new();
        $tree->parse($res->content);
        my $definition = $tree->look_down('_tag','div');
        if ($definition->{'_parent'}{'_content'}[1]{'_content'}[0]) {
            $keldair->msg($network, $channel, 'Definition for %s: %s', $term, $definition->{'_parent'}{'_content'}[1]{'_content'}[0] );
        }
        else {
            $keldair->msg($network, $channel, 'No definition found for %s.', $term);
        }
    }
}

1;
