use strict;
use warnings;
use XML::Twig;
use XML::Simple;
use Data::Dumper;
use DBI;
use DBD::mysql;
 

#Contact info query template 
my $xmlStr = <<XML;
<epp xmlns="urn:ietf:params:xml:ns:epp-1.0">
<command>
<info>
<contact:info xmlns:contact="urn:ietf:params:xml:ns:contact-1.0">
<contact:id>QDR123</contact:id>
</contact:info>
</info>
<clTRID>qadr_epp</clTRID>
</command>
</epp>
XML


my $cmd7= "/bin/rm -rf /root/eppclient_prod_client/eppclient/replay_tool/dc5000.xml";
my $cmd8= "/bin/rm -rf /root/eppclient_prod_client/eppclient/replay_tool/dc5001.xml";
my $cmd9= "/bin/rm -rf /root/eppclient_prod_client/eppclient/replay_tool/dc5002.xml";
my $cmd10= "/bin/rm -rf /root/eppclient_prod_client/eppclient/replay_tool/dc5003.xml";

`$cmd7`;`$cmd8`;`$cmd9`;`$cmd10`;

my $regname;my $admincontactval;my $billingcontactval;my $techcontactval;my $admincontact;my $billingcontact;my $techcontact;my $onlytechcontact;my $onlytechcontactval;my $domainname;my $config;
my $testds;

#refersh the domaininfo file with domaininfo response templates the domaininfo response are processs the bulk_contacts_extarct1.pl script

my $cmd5="/bin/perl /root/eppclient_prod_client/eppclient/replay_tool/bulk_contacts_extarct1.pl > /root/eppclient_prod_client/eppclient/replay_tool/dc3000.xml";
`$cmd5`;


#process the contactinfo file for xml parsing

my $cmd1= "/bin/bash /root/eppclient_prod_client/eppclient/replay_tool/run.sh Replay < /root/eppclient_prod_client/eppclient/replay_tool/dc4000.xml";
my $cmd4= "/bin/bash /root/eppclient_prod_client/eppclient/replay_tool/run.sh Replay < /root/eppclient_prod_client/eppclient/replay_tool/dc4001.xml";
my $cmd11= "/bin/bash /root/eppclient_prod_client/eppclient/replay_tool/run.sh Replay < /root/eppclient_prod_client/eppclient/replay_tool/dc4002.xml";
my $cmd6= "/bin/bash /root/eppclient_prod_client/eppclient/replay_tool/run.sh Replay < /root/eppclient_prod_client/eppclient/replay_tool/dc4003.xml";
my $cmd2= "/bin/grep -i addr";
my $cmd3 = "/bin/sed \'s/<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>//g\'";
my $path1="/root/eppclient_prod_client/eppclient/replay_tool/dc5000.xml";
my $path2="/root/eppclient_prod_client/eppclient/replay_tool/dc5001.xml";
my $path3="/root/eppclient_prod_client/eppclient/replay_tool/dc5002.xml";
my $path4="/root/eppclient_prod_client/eppclient/replay_tool/dc5003.xml";



# dump the extracted date from the epp query from domoininfo xml response into mysql table contactid

my $dbh = DBI->connect("DBI:mysql:northwind", "root", "123")or die "Unable to connect: $DBI::errstr\n";
my $q2 = q{TRUNCATE contactids;};
my $q3 = q{INSERT INTO `contactids`(domainname,Registrant_pri_cont,Registrant_admincont,Registrant_billingcont,Registrant_techcont) VALUES (?,?,?,?,?);};
my $sth = $dbh->prepare($q2)  or die "Prepare failed: " . $dbh->errstr();
$sth->execute();
$sth = $dbh->prepare($q3)  or die "Prepare failed: " . $dbh->errstr();


open (my $handle, '<', 'dc3000.xml') or die $!;
chomp(my @lines = <$handle>);


for(my $i=0;$i<=$#lines;$i++){


chomp $lines[$i];
$config = XMLin($lines[$i]);

#print Dumper($config);
$domainname=$config->{response}->{resData}->{"domain:infData"}->{"domain:name"};#print "\n--$domainname\n";
$regname=$config->{response}->{resData}->{"domain:infData"}->{"domain:registrant"};#print "\n--$regname\n";
$testds=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"};#print "\n--$testds\n";

if(ref $testds eq 'ARRAY'){

$admincontact=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[0]->{type};print "\n--val1--$admincontact\n";
$admincontactval=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[0]->{content};print "\n--val2--$admincontactval\n";

$billingcontact=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[1]->{type};print "\n--val3--$billingcontact\n";
$billingcontactval=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[1]->{content};print "\n--val4--$billingcontactval\n";

$techcontact=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[2]->{type};print "\n--val5--$techcontact\n";
$techcontactval=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[2]->{content};print "\n--val6--$techcontactval\n";

#handle diffrent cases  for admin and billing contacts supply ## P(3, 3) = 6 (A B C, A C B, B A C, B C A, C A B, C B A)
if($admincontact eq "admin" && $billingcontact eq "billing" && $techcontact eq "tech") #all case 1
{print "/n1 $admincontact $billingcontact $techcontact/n";$sth->execute($domainname, $regname, $admincontactval, $billingcontactval, $techcontactval)}

elsif($admincontact eq "admin" && $billingcontact eq "tech" && $techcontact eq "billing") #all case 2
{print "/n2 $admincontact $billingcontact $techcontact /n";$sth->execute($domainname, $regname, $admincontactval, $techcontactval, $billingcontactval)}

elsif($admincontact eq "billing" && $billingcontact eq "admin" && $techcontact eq "tech") #all case 3
{print "/n3 $admincontact $billingcontact $techcontact/n";$sth->execute($domainname, $regname, $billingcontactval, $admincontactval, $techcontactval)}

elsif($admincontact eq "billing" && $billingcontact eq "tech" && $techcontact eq "admin") #all case 4
{print "/n3 $admincontact $billingcontact $techcontact/n";$sth->execute($domainname, $regname, $techcontactval, $admincontactval, $billingcontactval)}

elsif($admincontact eq "tech" && $billingcontact eq "admin" && $techcontact eq "billing") #all case 5
{print "/n3 $admincontact $billingcontact $techcontact/n";$sth->execute($domainname, $regname, $billingcontactval, $techcontactval, $admincontactval)}

elsif($admincontact eq "tech" && $billingcontact eq "billing" && $techcontact eq "admin") #all case 6
{print "/n3 $admincontact $billingcontact $techcontact/n";$sth->execute($domainname, $regname, $techcontactval, $billingcontactval, $admincontactval)}



elsif($admincontact eq "admin" && $billingcontact eq "tech") #no billing contact
{print "/n4 $admincontact $billingcontact $techcontact/n";$techcontactval="A0000001-ICT";$sth->execute($domainname, $regname, $admincontactval, $techcontactval, $billingcontactval)}

elsif($admincontact eq "tech" && $billingcontact eq "admin") #no billing contact2
{print "/n5 $admincontact $billingcontact $techcontact/n";$techcontactval="A0000001-ICT";$sth->execute($domainname, $regname, $billingcontactval, $techcontactval, $admincontactval)}

elsif($admincontact eq "billing" && $billingcontact eq "tech") #no admin contact
{print "/n6$admincontact $billingcontact $techcontact/n";$techcontactval="A0000001-ICT";$sth->execute($domainname, $regname, $techcontactval, $admincontactval, $billingcontactval)}

elsif($admincontact eq "tech" && $billingcontact eq "billing") #no admin contact2
{print "/n7$admincontact $billingcontact $techcontact/n";$techcontactval="A0000001-ICT";$sth->execute($domainname, $regname, $techcontactval, $billingcontactval, $admincontactval)}
else {}}

else {$onlytechcontact=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->{type};$onlytechcontactval=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->{content};$billingcontactval="A0000001-ICT";$techcontactval="A0000001-ICT";$sth->execute($domainname, $regname, $techcontactval, $billingcontactval, $onlytechcontactval)}}
close $handle;

#retrive the contactd ids from mysql database and insert into the contactinfo query for contact id extraction

my $q4= q{select * from contactids;};
$sth = $dbh->prepare($q4);
$sth->execute(); 


while(my @row = $sth->fetchrow_array) {


#keep inserting the contact id into contact info EPP Query
open(FH, '>', 'dc4000.xml') or die "cannot open file";
  select FH;
  my $twig= new XML::Twig(

                           twig_handlers => { 'contact:id' => sub { $_->set_text($row[1]) }  },
                         );
  $twig->parse($xmlStr);
  $twig->print();

#  close FH;

open(FH, '>', 'dc4001.xml') or die "cannot open file";
  select FH;
   $twig= new XML::Twig(

                           twig_handlers => { 'contact:id' => sub { $_->set_text($row[2]) }  },
                         );
  $twig->parse($xmlStr);
  $twig->print();

 # close FH;

open(FH, '>', 'dc4002.xml') or die "cannot open file";
  select FH;
   $twig= new XML::Twig(

                           twig_handlers => { 'contact:id' => sub { $_->set_text($row[3]) }  },
                         );
  $twig->parse($xmlStr);
  $twig->print();

  #close FH;




open(FH, '>', 'dc4003.xml') or die "cannot open file";
  select FH;
   $twig= new XML::Twig(

                           twig_handlers => { 'contact:id' => sub { $_->set_text($row[4]) }  },
                         );
  $twig->parse($xmlStr);
  $twig->print();

  close FH;


#finaly process the contact info response as per requirement
  system("$cmd1 | $cmd2 | $cmd3 >> $path1");
  system("$cmd4 | $cmd2 | $cmd3 >> $path2");
  system("$cmd11 | $cmd2 | $cmd3 >> $path3");
  system("$cmd6 | $cmd2 | $cmd3 >> $path4");
}
