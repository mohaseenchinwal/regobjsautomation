#!/usr/bin/perl --
use strict;
use warnings;
use XML::Twig;
use DBI;
use DBD::mysql;
use XML::Simple;
use Data::Dumper;

my $ms="/root/eppclient_prod_client/eppclient/replay_tool/";
my $PERL="/bin/perl";
my $FILEPATH="/root/eppclient_prod_client/eppclient/replay_tool";
my $DATA='/root/eppclient_prod_client/eppclient/replay_tool/output.html';
my $E6="/bin/echo";
my $CAT="/bin/cat";
my $domainname;my $admincontactmail;my $billingcontactmail;my $techcontactmail;my $regemail1;my $regemail2;my $regemail3;my $regemail4;my $adminemail;my @E1;my @E2;my @E3;my @E4;my @E5;

my @row;
my @row1;
my $cmd2;

my $MAILFROM="mchinwal\@cra.gov.qa";
my $MAILTO="mchinwal\@cra.gov.qa";
my $MAILTO1="palayils\@cra.gov.qa";

#refersh the contactinfo file with contactinfo response templates the contactinfo response are processed by the bulk_contacts_extarct2.pl script
my $cmd1 = "/bin/perl /root/eppclient_prod_client/eppclient/replay_tool/bulk_contacts_extarct2.pl";`$cmd1`;

my $dbh = DBI->connect("DBI:mysql:northwind", "root", "123")or die "Unable to connect: $DBI::errstr\n";
my $q2 = q{DELETE FROM contactemails;};
my $sth = $dbh->prepare($q2)  or die "Prepare failed: " . $dbh->errstr();
$sth->execute();

my $sth2;
my $sth3;
my $sth4;

my $dbh1;
my $dbh2;
my $dbh3;


my $q3 = q{INSERT INTO `contactemails`(domainname,Registrant_pri_email,Registrant_adminemail,Registrant_billingemail,Registrant_techemail) VALUES (?,?,?,?,?);};
$sth = $dbh->prepare($q3);


my $_;
open my $A, '<', 'dc5000.xml' or die $!;open my $B, '<', 'dc5001.xml' or die $!;open my $C, '<', 'dc5002.xml' or die $!;open my $D, '<', 'dc5003.xml' or die $!;open my $E, '<', 'domains.txt' or die $!;

no warnings 'uninitialized';

while ($_ = <$A> . <$B> . <$C> . <$D> . <$E>) {
       chomp(@E1 = <$A>);chomp(@E2 = <$B>);chomp(@E3 = <$C>);chomp(@E4 = <$D>);chomp(@E5 = <$E>);
       print @E1;
       for(my $i=0;$i<=$#E1;$i++){

        chomp $E1[$i];chomp $E2[$i];chomp $E3[$i];chomp $E4[$i];chomp $E5[$i];
        my $config2 = XMLin($E1[$i]);my $config3 = XMLin($E2[$i]);my $config4 = XMLin($E3[$i]);my $config5 = XMLin($E4[$i]);
        
        $domainname=$E5[$i];#print "\n$domainname\n";
        $regemail1=$config2->{response}->{resData}->{"contact:infData"}->{"contact:email"};print "\n no  $regemail1\n";
        $regemail2=$config3->{response}->{resData}->{"contact:infData"}->{"contact:email"};print "\n no $regemail2\n";
        $regemail3=$config4->{response}->{resData}->{"contact:infData"}->{"contact:email"};print "\n no $regemail3\n";
        $regemail4=$config5->{response}->{resData}->{"contact:infData"}->{"contact:email"};print "\n no $regemail4\n";
        $sth->execute($domainname,$regemail1,$regemail2,$regemail3,$regemail4);
                                     }
                                      #close $A;close $B;close $C;close $D, close $E;

    }



my $q4= q{select distinct Registrant_techemail from contactemails group by Registrant_techemail having count(*) >= 1;};
$sth2 = $dbh->prepare($q4);

##############################email module


$sth2->execute();

while( @row = $sth2->fetchrow_array) {



`echo "<!DOCTYPE html><html><head><p>Dear Domain Owner,</p><p>Greetings from Communications Regulatory Authority ??? Domains Team!!</p><p>We are sending this email as part of contacts auditing initiative in which we are validating email contacts of Qatar based domains.</p><p><b>We regret the inconvenience caused if you received this email with unrelated information before.</b></p><p><b>Kindly consider this email for the contact confirmations and ignore the earlier one.</b></p><p>Following is/are the email contacts associated with the mentioned domain(s).</p><style>table { width:75%\;}table, th, td { border: 1px solid black\;border-collapse: collapse\;}th, td { padding: 6px\; text-align: center\;}table#t01 tr:nth-child(even) {background-color: #eee\;}table#t01 tr:nth-child(odd) { background-color: #fff\;}table#t01 th {  background-color: #8f1336;\ color: white;\}</style></head><body><p1><b>Domain Email Contact(s) grouped as per Domain Tech Contact(s)</b></p1><table id=\"t01\"><tr><th>Domain Name</th><th>Domain Primary Contact</th><th>Domain Admin Contact</th><th>Domain Billing Contact</th><th>Domain Technical Contact</th></tr>" > $DATA`;




my $q5 = q{SELECT * FROM contactemails where Registrant_techemail=?;};
$sth = $dbh->prepare($q5);
$sth->execute($row[0]);



while(@row1 = $sth->fetchrow_array){


if($row1[2] eq "dummy\@domains.qa") {$row1[2]="Contact Not Provided";}
if($row1[3] eq "dummy\@domains.qa") {$row1[3]="Contact Not Provided";}

print "\n$row1[0]--$row1[1]--$row1[2]--$row1[3]--$row1[4]\n";

`echo "<tr><td>$row1[0]</td><td>$row1[1]</td><td>$row1[2]</td><td>$row1[3]</td><td>$row1[4]</td></tr>" >> $DATA`;


}


`echo  "</table>" >> $DATA`;
`echo  "<p><b>Requesting you to please verify the emails contact and get in touch with us at support\@domains.qa in case you require any changes.</b>"  >> $DATA`;

`echo "<p>Please use the below template, in case you require any changes for the contacts:</p><style>table { width:75%\;}table, th, td { border: 1px solid black\;border-collapse: collapse\;}th, td { padding: 6px\; text-align: center\;}table#t02 tr:nth-child(even) {background-color: #eee\;}table#t02 tr:nth-child(odd) { background-color: #fff\;}table#t02 th {  background-color: #8f1336;\ color: white;\}</style><table id=\"t02\"><tr><th></th><th scope="col">Contact Person</th><th scope="col">Email</th><th scope="col">Contact No.</th></tr><tr><th scope="row">Primary</th><td></td><td></td><td></td></tr><tr><th scope="row">Technical</th><td></td><td></td><td></td></tr><tr><th scope="row">Admin</th><td></td><td></td><td></td></tr><tr><th scope="row">Billing</th><td></td><td></td><td></td></tr></table><p>Best Regards</p><p>CRA ??? Domains Support.</p></body></html>" >> $DATA`;

print $row1[1];
print $row1[2];
print $row1[3];
print $row1[4];

if($row[0] ne "Contact Not Provided"){

$cmd2="\(
$E6 \"From: support\@domains.qa\";
$E6 \"To: $MAILTO1\";
$E6 \"To: $MAILTO\";
$E6 \"To: $row[0]\";

$E6 \"Subject: Qatar Domains Contacts Auditing \??? Please Verify Domain???s Email Contacts\";
$E6 \"Content-Type: text/html\";
$E6 \"MIME-Version: 1.0\";
$E6 \"\";
cat $DATA;

\) \| sendmail -t";

system($cmd2);
}


print "$row[0]\n";



}
