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

#refersh the contactinfo file with contactinfo response templates the contactinfo response are processed by the bulk_contacts_extarct2.pl script
my $cmd1 = "/bin/perl /root/eppclient_ote_clinet/replay_tool/bulk_contacts_extarct2.pl";
`$cmd1`;





# dump the extracted date from the epp query from domoininfo xml response into mysql table contactid

my $dbh = DBI->connect("DBI:mysql:northwind", "root", "123")or die "Unable to connect: $DBI::errstr\n";
my $q2 = q{DELETE FROM contactemails;};
my $sth = $dbh->prepare($q2)  or die "Prepare failed: " . $dbh->errstr();
$sth->execute();



#########99
my $q19 = q{INSERT INTO `contactemails`(domainname,Registrant_pri_email,Registrant_adminemail,Registrant_billingemail,Registrant_techemail) VALUES (?,?,?,?,?);};
$sth = $dbh->prepare($q19)  or die "Prepare failed: " . $dbh->errstr();
open (my $handle, '<', 'domains.txt') or die $!;
chomp(my @lines = <$handle>);
for(my $i=0;$i<=$#lines;$i++){


chomp $lines[$i];




my $domainname=$lines[$i];
print "\nRegistrant Email: $domainname\n";

if($sth->execute($domainname,$regemail,$regemail1,$regemail2,$regemail3)) {}

}
close $handle;








#########100
my $q20 = q{INSERT INTO `contactemails`(domainname,Registrant_pri_email,Registrant_adminemail,Registrant_billingemail,Registrant_techemail) VALUES (?,?,?,?,?);};
$sth = $dbh->prepare($q20)  or die "Prepare failed: " . $dbh->errstr();
open ($handle, '<', 'dc5000.xml') or die $!;
chomp(@lines = <$handle>);
for(my $i=0;$i<=$#lines;$i++){


chomp $lines[$i];


my $config = XMLin($lines[$i]);

my $regemail=$config->{response}->{resData}->{"contact:infData"}->{"contact:email"};
print "\nRegistrant Email: $regemail\n";

#if($sth->execute($domainname,$regemail,$regemail1,$regemail2,$regemail3)) {}


}
close $handle;





#########101
my $q21 = q{INSERT INTO `contactemails`(domainname,Registrant_pri_email,Registrant_adminemail,Registrant_billingemail,Registrant_techemail) VALUES (?,?,?,?,?);};
$sth = $dbh->prepare($q21)  or die "Prepare failed: " . $dbh->errstr();
open ( $handle, '<', 'dc5001.xml') or die $!;
chomp( @lines = <$handle>);
for(my $i=0;$i<=$#lines;$i++){


chomp $lines[$i];


my $config = XMLin($lines[$i]);

my $regemail1=$config->{response}->{resData}->{"contact:infData"}->{"contact:email"};
print "\nRegistrant Email: $regemail1\n";

#if($sth->execute($domainname,$regemail,$regemail1,$regemail2,$regemail3)) {}


}
close $handle;




#########102
my $q22 = q{INSERT INTO `contactemails`(domainname,Registrant_pri_email,Registrant_adminemail,Registrant_billingemail,Registrant_techemail) VALUES (?,?,?,?,?);};
$sth = $dbh->prepare($q22)  or die "Prepare failed: " . $dbh->errstr();
open ( $handle, '<', 'dc5002.xml') or die $!;
chomp( @lines = <$handle>);
for(my $i=0;$i<=$#lines;$i++){


chomp $lines[$i];


my $config = XMLin($lines[$i]);

my $regemail2=$config->{response}->{resData}->{"contact:infData"}->{"contact:email"};
print "\nRegistrant Email: $regemail2\n";

#if($sth->execute($domainname,$regemail,$regemail1,$regemail2,$regemail3)) {}




}
close $handle;



#########103
my $q23 = q{INSERT INTO `contactemails`(domainname,Registrant_pri_email,Registrant_adminemail,Registrant_billingemail,Registrant_techemail) VALUES (?,?,?,?,?);};
$sth = $dbh->prepare($q23)  or die "Prepare failed: " . $dbh->errstr();
open ($handle, '<', 'dc5003.xml') or die $!;
chomp(@lines = <$handle>);
for(my $i=0;$i<=$#lines;$i++){


chomp $lines[$i];


my $config = XMLin($lines[$i]);

my $regemail3=$config->{response}->{resData}->{"contact:infData"}->{"contact:email"};
print "\nRegistrant Email: $regemail3\n";

#if($sth->execute($domainname,$regemail,$regemail1,$regemail2,$regemail3)) {}



}
close $handle;



my $q30 = q{INSERT INTO `contactemails`(domainname,Registrant_pri_email,Registrant_adminemail,Registrant_billingemail,Registrant_techemail) VALUES (?,?,?,?,?);};
$sth = $dbh->prepare($q30)  or die "Prepare failed: " . $dbh->errstr();

#open my $out, '>', 'ABCD' or die $!;
#{
    my $_;

    open my $A, '<', 'dc5000.xml' or die $!;open my $B, '<', 'dc5001.xml' or die $!;open my $C, '<', 'dc5002.xml' or die $!;open my $D, '<', 'dc5003.xml' or die $!;

    no warnings 'uninitialized';

    while ($_ = <$A> . <$B> . <$C> . <$D>) {
        #s/\n//g;
        #print $out $_, "\n";
       chomp(@E1 = <$A>);chomp(@E2 = <$B>);chomp(@E3 = <$C>);chomp(@E4 = <$D>);
       for(my $i=0;$i<=$#lines;$i++){
       
        chomp $E1[$i];chomp $E2[$i];chomp $E3[$i];chomp $E4[$i];
        print $E1[$i];
        my $config2 = XMLin($E1[$i]);my $config3 = XMLin($E2[$i]);my $config4 = XMLin($E3[$i]);my $config5 = XMLin($E4[$i]);
        my $regemail1=$config2->{response}->{resData}->{"contact:infData"}->{"contact:email"};print "\n??????$regemail1\n";
        my $regemail2=$config3->{response}->{resData}->{"contact:infData"}->{"contact:email"};print "\n??????$regemail2\n";       
        my $regemail3=$config4->{response}->{resData}->{"contact:infData"}->{"contact:email"};print "\n??????$regemail3\n";
        my $regemail4=$config5->{response}->{resData}->{"contact:infData"}->{"contact:email"};print "\n??????$regemail4\n";
        if($sth->execute($domainname,$regemail1,$regemail2,$regemail3,$regemail4)) {}
                                     } 
                                      close $A;close $B;close $C;close $D;
                                            }
#}
#close $out or warn $!;
