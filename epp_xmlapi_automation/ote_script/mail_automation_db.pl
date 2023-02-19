#!/usr/bin/perl
use strict;
use warnings;


use DBI;
use DBD::mysql;


##################################################################################################################################

my $dbh = DBI->connect("DBI:mysql:DNSSTATS", "root", "as12AS\!\@")or die "Unable to connect: $DBI::errstr\n";





#my $file = '/root/scripts/qpmf.txt';
#open my $info, $file or die "Could not open $file: $!";

#while( my $line = <$info>)  {

# if ($line < 0)
#      {
#          $line =0;
#      }
#}

#close $info;


`/usr/bin/cat /home/ansible/scripts/dns1pri.txt | tr '\n' ',' > /home/ansible/scripts/dns1pri.csv`;



my $q2 =  q{LOAD DATA  LOCAL INFILE '/home/ansible/scripts/dns1pri.csv' INTO TABLE dns1pri_stats
             FIELDS TERMINATED BY ',' ENCLOSED BY '"' TERMINATED BY ','
             LINES TERMINATED BY '\n'
             (TOTAL,SUCCESS,REFERRAL,NXRRSET,NXDOMAIN,RECURSION,FAILURE,SERVERFAIL,FORMERR,DROPPED);};

my $sth = $dbh->prepare($q2)  or die "Prepare failed: " . $dbh->errstr();
$sth->execute();

