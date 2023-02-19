#!/usr/bin/perl --
use strict;
use warnings;
use XML::Twig;
use DBI;
use DBD::mysql;
use XML::Simple;
use Data::Dumper;




my $domainname;
my $admincontactmail;
my $billingcontactmail;
my $techcontactmail;
my $regemail;
my $regemail1;
my $regemail2;
my $regemail3;
my $adminemail;
my @E1;
my @E2;
my @E3;
my @E4;
my @E5;


#refersh the contactinfo file with contactinfo response templates the contactinfo response are processed by the bulk_contacts_extarct2.pl script
my $cmd1 = "/bin/perl /root/eppclient_ote_clinet/replay_tool/bulk_contacts_extarct2.pl";
`$cmd1`;



my $dbh = DBI->connect("DBI:mysql:northwind", "root", "123")or die "Unable to connect: $DBI::errstr\n";
my $q2 = q{DELETE FROM contactemails;};
my $sth = $dbh->prepare($q2)  or die "Prepare failed: " . $dbh->errstr();
$sth->execute();

my $q19 = q{INSERT INTO `contactemails`(domainname,Registrant_pri_email,Registrant_adminemail,Registrant_billingemail,Registrant_techemail) VALUES (?,?,?,?,?);};
$sth = $dbh->prepare($q19);


my $_;

open my $A, '<', 'dc5000.xml' or die $!;
open my $B, '<', 'dc5001.xml' or die $!;
open my $C, '<', 'dc5002.xml' or die $!;
open my $D, '<', 'dc5003.xml' or die $!;
open my $E, '<', 'domains.txt' or die $!;

no warnings 'uninitialized';

while ($_ = <$A> . <$B> . <$C> . <$D> . <$E>) {
        #s/\n//g;
        print  $_, "\n";
       chomp(@E1 = <$A>);chomp(@E2 = <$B>);chomp(@E3 = <$C>);chomp(@E4 = <$D>);chomp(@E5 = <$E>);
       print @E1;
       for(my $i=0;$i<=$#E1;$i++){

        chomp $E1[$i];chomp $E2[$i];chomp $E3[$i];chomp $E4[$i];chomp $E5[$i];
        print $E1[$i];
        my $config2 = XMLin($E1[$i]);my $config3 = XMLin($E2[$i]);my $config4 = XMLin($E3[$i]);my $config5 = XMLin($E4[$i]);
        
        my $domainname=$E5[$i];print "\n$domainname\n";
        my $regemail1=$config2->{response}->{resData}->{"contact:infData"}->{"contact:email"};print "\n$regemail1\n";
        my $regemail2=$config3->{response}->{resData}->{"contact:infData"}->{"contact:email"};print "\n$regemail2\n";
        my $regemail3=$config4->{response}->{resData}->{"contact:infData"}->{"contact:email"};print "\n$regemail3\n";
        my $regemail4=$config5->{response}->{resData}->{"contact:infData"}->{"contact:email"};print "\n$regemail4\n";
        $sth->execute($domainname,$regemail1,$regemail2,$regemail3,$regemail4);
                                     }
                                      #close $A;close $B;close $C;close $D, close $E;

    }
