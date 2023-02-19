use strict;
use warnings;
use XML::Twig;
use XML::Simple;
use Data::Dumper;
use DBI;
use DBD::mysql;





my $expdate;

my $config;




open (my $handle, '<', 'exp.xml') or die $!;
chomp(my @lines = <$handle>);


for(my $i=0;$i<=$#lines;$i++){


chomp $lines[$i];
$config = XMLin($lines[$i]);

#print Dumper($config);

$expdate=$config->{response}->{resData}->{"domain:infData"}->{"domain:exDate"};

print "$expdate\n";
}
