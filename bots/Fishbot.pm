# Fishbot.pm - Fishbot clone for Keldair
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Released under the same terms as Perl itself.

package Keldair::Module::Bots::Fishbot;

use strict;
use warnings;
use feature 'switch';
use Keldair;

$keldair->hook_add(OnMessage => sub {
        my ( $network, $channel, $origin, $line ) = @_;
        given (lc($line)) {
            my $channel = $keldair->find_chan($channel);
            my $origin = $keldair->find_user($origin);
            when (/hampster/) { $keldair->msg( $network, $channel, '%s: There is no \'p\' in hamster you retard.', $origin->nick); }
            when ('ag') { $keldair->msg( $network, $channel, 'Ag, ag ag ag ag ag AG AG AG!' ); }
            when (/vinegar/) { $keldair->msg( $network, $channel, 'Nope, too sober for vinegar.  Try later.' ); }
            when (/martian/) { $keldair->msg( $network, $channel, 'Don\'t run! We are your friends!' ); }
            when ('just then, he fell into the sea') { $keldair->msg( $network, $channel, 'Ooops!' ); }
            when (/aftershock/) { $keldair->msg( $network, $channel, 'mmmm, Aftershock' ); }
            when ('why are you here?') { $keldair->msg( $network, $channel, 'Same reason. I love candy.' ); }
            when ('spoon') { $keldair->msg( $network, $channel, 'There is no spoon.' ); }
            when ('bounce' || 'wertle') { $keldair->msg( $network, $channel, 'moo' ); }
            when ('crack') { $keldair->msg( $network, $channel, 'Doh, there goes another bench!' ); }
            when ('you can\'t just pick people at random!') { $keldair->msg( $network, $channel, 'I can do anything I like, %s, I\'m eccentric!  Rrarrrrrgh!  Go!', $origin->nick ); };
            when ('flibble') { $keldair->msg( $network, $channel, 'plob' ); }
            when ('now there\'s more than one of them?') { $keldair->msg( $network, $channel, 'A lot more.' ); }
            when ('i want everything') { $keldair->msg( $network, $channel, 'Would that include a bullet from this gun?' ); }
            when (/we are getting aggravated/) { $keldair->msg( $network, $channel, 'Yes we are.' ); }
            when ('atlantis') { $keldair->msg( $network, $channel, 'Beware the underwater headquarters of the trout and their bass henchmen. From there they plan their attacks on other continents.' ); }
            when ('oh god') { $keldair->msg( $network, $channel, 'fishbot will suffice.' ); }
            when ('what is the matrix?') { $keldair->msg( $network, $channel, 'No-one can be told what the matrix is.  You have to see it for yourself.' ); }
            when ('what do you need?') { $keldair->msg( $network, $channel, 'Guns. Lots of guns.' ); }
            when ('i know kungfu') { $keldair->msg( $network, $channel, 'Show me.' ); }
            when ('cake') { $keldair->msg( $network, $channel, 'fish' ); }
            when ('trout go moo') { $keldair->msg( $network, $channel, 'Aye, that\'s cos they\'re fish.' ); }
            when ('kangaroo') { $keldair->msg( $network, $channel, 'The kangaroo is a four winged stinging insect.' ); }
            when (/\001ACTION slaps (.*) around a bit with a large trout/) { $keldair->msg( $network, $channel, 'trouted!' ); }
            when ('sea bass') { $keldair->msg( $network, $channel, 'Beware of the mutant sea bass and their laser cannons!' ); }
            when ('trout') { $keldair->msg ( $network, $channel, 'Trout are freshwater fish and have underwater weapons.' ); }
            when (/has returned from playing/i) { $keldair->msg( $network, $channel, 'like we care fs :(' ); }
            when ('where are we?') { $keldair->msg( $network, $channel, 'Last time I looked, we were in %s.', $channel->name ); }
            when ('where do you want to go today?') { $keldair->msg( $network, $channel, 'anywhere but redmond :(.' ); }
            when (/^fish go m(oo|00)$/) { $keldair->msg( $network, $channel, "\001ACTION notes that %s is truly enlightened.\001", $origin->nick ); }
            when ('fish don\'t go moo') { $keldair->msg( $network, $channel, 'Oh yes they do!' ); }
            when (/^(.*) (go|goes) moo$/) { $keldair->msg( $network, $channel, '%s: only when they are impersonating fish.', $origin->nick ) unless $1 eq 'fish'; }
            when (/^fish go (.*)$/) { $keldair->msg( $network, $channel, '%s LIES! Fish don\'t go %s! fish go m00!', $origin->nick, $1) unless $1 =~ m/m(oo|00)/; }
            when (/^you know who else .*/) { $keldair->msg( $network, $channel, '%s: YA MUM!', $origin->nick ); }
            when (/\001ACTION thinks happy thoughts about pretty (.*)\001/) { $keldair->msg( $network, $channel, "\001ACTION has plenty of pretty %s. Would you like one %s?\001", $1, $origin->nick ); }
            when (/\001ACTION snaffles a (.*) off fishbot.\001/) { $keldair->msg( $network, $channel, ':(' ); }
            when ('if there\'s one thing i know for sure, it\'s that fish don\'t go m00.') { $keldair->msg( $network, $channel, '%s: HERETIC! UNBELIEVER!', $origin->nick ); }
            when ('ammuu?') { $keldair->msg( $network, $channel, '%s: fish go moo oh yes they do!', $origin->nick ); }
            when ('fish') { $keldair->msg( $network, $channel, '%s: fish go m00!', $origin->nick ); }
            when ('snake') { $keldair->msg( $network, $channel, 'Ah snake a snake! Snake, a snake! Ooooh, it\'s a snake!' ); }
            when ('carrots handbags cheese') { $keldair->msg( $network, $channel, 'toilets russians planets hamsters weddings poets stalin KUALA LUMPUR! pygmies budgies KUALA LUMPUR!' ); }
            when (/sledgehammer/) { $keldair->msg( $network, $channel, 'sledgehammers go quack!' ); }
            when ('badger badger badger badger badger badger badger badger badger badger badger badger') { $keldair->msg( $network, $channel, 'mushroom mushroom!' ); }
            when ('moo?') { $keldair->msg( $network, $channel, 'To moo, or not to moo, that is the question. Whether \'tis nobler in the mind to suffer the slings and arrows of outrageous fish...' ); }
            when ('herring') { $keldair->msg( $network, $channel, 'herring(n): Useful device for chopping down tall trees. Also moos (see fish).' ); }
        }
    }
);
