# Stats.pm - Statistics for Keldair
# Copyright 2011 Alexandria M. Wolcott <alyx@sporksmoo.net>
# Licensed under the 3-clause BSD.
# Portions of code borrowed from Cereberus.

use strict;
use warnings;

package Keldair::Module::Stats;

use Keldair;

$keldair->help_add(STATS => 'Shows basic statistics about this Keldair instance.');

$keldair->command_bind(STATS =>
    sub {
        my ($network, $channel, $origin) = @_;
        my $uptime = (time - $Keldair::State::STATS{'start'});
        $keldair->msg($network, $channel, 'Uptime: %d days, %d:%02d:%02d', 
            $uptime / 86400, ($uptime / 3600) % 24, ($uptime / 60) % 60,
            $uptime % 60);
        $keldair->msg($network, $channel, 'Recieved: %s (%.1f B/s)',
            size($Keldair::State::STATS{'inB'}), ($Keldair::State::STATS{'inB'} / $uptime));
    }
);

# size(bytes)
sub size {
    my ($bytes) = @_;

    if (!defined($bytes)) {
        return 0;
    }

    # TiB: 2^40 = 1099511627776
    if ($bytes > 2**40) {
        return sprintf('%.2f Tebibytes', ($bytes / 2**40));
    }
    # GiB: 2^30 = 1073741824
    elsif ($bytes > 2**30) {
        return sprintf('%.2f Gibibytes', ($bytes / 2**30));
    }
    # MiB: 2^20 = 1048576
    elsif ($bytes > 2**20) {
        return sprintf('%.2f Mebibytes', ($bytes / 2**20));
    }
    # KiB: 2^10 = 1024
    else {
        return sprintf('%.2f Kibibytes', ($bytes / 2**10));
    }
}

1;
