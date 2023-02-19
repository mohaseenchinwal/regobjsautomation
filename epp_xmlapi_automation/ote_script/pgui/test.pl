#!/usr/bin/perl
#use strict;
#use warnings;
#


my @host_array5 = ("mgt-qadr-qa", "db0-qadr-qa", "syslog1-qadr-qa", "ans0-qadr-qa", "who-qadr-qa", "bck-qadr-qa");

my $i;

foreach ($i=0;$i<=$#host_array5;$i++) {


my ($a, $b, $c) = split /\-/,  $host_array5[$i];
my $act=$a.$b.$c;
print"\n $act \n ";

}

