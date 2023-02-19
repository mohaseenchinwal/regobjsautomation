use strict;
use warnings;
use XML::Twig;
use XML::Simple;
use Data::Dumper;
use DBI;
use DBD::mysql;
 



my $mpath="/root/eppclient_prod_client/eppclient/replay_tool";
my $FILEPATH="/root/eppclient_ote_clinet/replay_tool";

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


my $cmd7= "/bin/rm -rf $FILEPATH/dc5000.xml";
my $cmd8= "/bin/rm -rf $FILEPATH/dc5001.xml";
my $cmd9= "/bin/rm -rf $FILEPATH/dc5002.xml";
my $cmd10= "/bin/rm -rf $FILEPATH/dc5003.xml";

`$cmd7`;`$cmd8`;`$cmd9`;`$cmd10`;

my $regname;my $admincontactval;my $billingcontactval;my $techcontactval;my $admincontact;my $billingcontact;my $techcontact;my $onlytechcontact;my $onlytechcontactval;my $domainname;my $config;
my $testds;

#refersh the domaininfo file with domaininfo response templates the domaininfo response are processs the bulk_contacts_extarct1.pl script

my $cmd5="/bin/perl $mpath/p1.pl > $FILEPATH/dc3000.xml";
`$cmd5`;


#process the contactinfo file for xml parsing

my $cmd1= "/bin/bash $mpath/run.sh Replay < $FILEPATH/dc4000.xml";
my $cmd4= "/bin/bash $mpath/run.sh Replay < $FILEPATH/dc4001.xml";
my $cmd11= "/bin/bash $mpath/run.sh Replay < $FILEPATH/dc4002.xml";
my $cmd6= "/bin/bash $mpath/run.sh Replay < $FILEPATH/dc4003.xml";
my $cmd2= "/bin/grep -i addr";
my $cmd3 = "/bin/sed \'s/<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>//g\'";
my $path1="$FILEPATH/dc5000.xml";
my $path2="$FILEPATH/dc5001.xml";
my $path3="$FILEPATH/dc5002.xml";
my $path4="$FILEPATH/dc5003.xml";



# dump the extracted date from the epp query from domoininfo xml response into mysql table contactid

my $dbh = DBI->connect("DBI:mysql:northwind", "root", "123")or die "Unable to connect: $DBI::errstr\n";
my $q2 = q{TRUNCATE contactids;};
my $q3 = q{INSERT INTO `contactids`(domainname,Registrant_pri_cont,Registrant_admincont,Registrant_billingcont,Registrant_techcont) VALUES (?,?,?,?,?);};
my $sth = $dbh->prepare($q2)  or die "Prepare failed: " . $dbh->errstr();
$sth->execute();
$sth = $dbh->prepare($q3)  or die "Prepare failed: " . $dbh->errstr();


open (my $handle, '<', '$FILEPATH/dc3000.xml') or die $!;
chomp(my @lines = <$handle>);


for(my $i=0;$i<=$#lines;$i++){


chomp $lines[$i];
$config = XMLin($lines[$i]);

#print Dumper($config);
$domainname=$config->{response}->{resData}->{"domain:infData"}->{"domain:name"};
$regname=$config->{response}->{resData}->{"domain:infData"}->{"domain:registrant"};
$testds=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"};

if(ref $testds eq 'ARRAY'){

$admincontact=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[0]->{type};
$admincontactval=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[0]->{content};

$billingcontact=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[1]->{type};
$billingcontactval=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[1]->{content};

$techcontact=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[2]->{type};
$techcontactval=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[2]->{content};

#handle diffrent cases  for admin and billing contacts supply
if($admincontact eq "admin" && $billingcontact eq "billing" && $techcontact eq "tech")
{$sth->execute($domainname, $regname, $admincontactval, $billingcontactval, $techcontactval)}
elsif($admincontact eq "admin" && $billingcontact eq "tech") #no billing contact
{$techcontactval="A0000001-ICT";$sth->execute($domainname, $regname, $admincontactval, $techcontactval, $billingcontactval)}
elsif($admincontact eq "billing" && $billingcontact eq "tech") #no admin contact
{$techcontactval="A0000001-ICT";$sth->execute($domainname, $regname, $techcontactval, $admincontactval, $billingcontactval)}
else {}}
else {$onlytechcontact=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->{type};$onlytechcontactval=$config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->{content};$billingcontactval="A0000001-ICT";$techcontactval="A0000001-ICT";$sth->execute($domainname, $regname, $techcontactval, $billingcontactval, $onlytechcontactval)}}
close $handle;

#retrive the contactd ids from mysql database and insert into the contactinfo query for contact id extraction

my $q4= q{select * from contactids;};
$sth = $dbh->prepare($q4);
$sth->execute(); 


while(my @row = $sth->fetchrow_array) {


#keep inserting the contact id into contact info EPP Query
open(FH, '>', '$FILEPATH/dc4000.xml') or die "cannot open file";
  select FH;
  my $twig= new XML::Twig(

                           twig_handlers => { 'contact:id' => sub { $_->set_text($row[1]) }  },
                         );
  $twig->parse($xmlStr);
  $twig->print();

#  close FH;

open(FH, '>', '$FILEPATH/dc4001.xml') or die "cannot open file";
  select FH;
   $twig= new XML::Twig(

                           twig_handlers => { 'contact:id' => sub { $_->set_text($row[2]) }  },
                         );
  $twig->parse($xmlStr);
  $twig->print();

 # close FH;

open(FH, '>', '$FILEPATH/dc4002.xml') or die "cannot open file";
  select FH;
   $twig= new XML::Twig(

                           twig_handlers => { 'contact:id' => sub { $_->set_text($row[3]) }  },
                         );
  $twig->parse($xmlStr);
  $twig->print();

  #close FH;




open(FH, '>', '$FILEPATH/dc4003.xml') or die "cannot open file";
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
