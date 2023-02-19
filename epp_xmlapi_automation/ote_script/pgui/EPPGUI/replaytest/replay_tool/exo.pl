use strict;
use warnings;

my @words;
open (my $handle, '<', 'domains.txt') or die $!;
chomp(my @lines = <$handle>);
print @lines;
close $handle;

