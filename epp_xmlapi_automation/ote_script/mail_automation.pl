use strict;
use warnings;
use Data::Dumper;

use DBI;
use DBD::mysql;


my $E="/bin/echo";

my @row;
my $domain;
my $tech;
my $admin;


my $cmd1 = "/bin/perl /root/eppclient_ote_clinet/replay_tool/bulk_contacts_extarct3.pl";

#`$cmd1`;






my $sth;


############################# this section reads file called domains.txt located in the same path as that of script file line by line and sends to an array called lines###########


sub domainvalue {

my $dbh = DBI->connect("DBI:mysql:northwind", "root", "123")or die "Unable to connect: $DBI::errstr\n";



my $q1= q{select * from contactids};
$sth = $dbh->prepare($q1);
$sth->execute();


while( @row = $sth->fetchrow_array) {



return $row[0];

}


}

my $test= domainvalue();

print $test;


my $cmd2="\(

$E \"From: mchinwal\@cra.gov.qa\";
$E \"To: mchinwal\@cra.gov.qa\";
$E \"Subject: CRA Qatar Domains Contacts Auditing \| Please Verify Your Domain Contacts\";
$E \"Content-Type: text/plain\";
$E \"MIME-Version: 1.0\";
$E \"\";

$E Dear Domain Owner,	

\n

$E Writing this as part of Communications Regulatory Authority’s Qatar Domains Contacts Auditing activity.

\n

$E According to our registry system your domain’s $domain’s contacts is as below:

\n

$E Domain Owner:
\n

$E Email:

\n 

$E Domain Tech Contact: 

\n

$E Email:$tech

\n

$E Domain Admin Contact:

\n

$E Email: $admin

\n

$E Domain Billing Contact:

\n

$E Email: 

\n

$E Requesting you to please verify the aforementioned contacts and please email your change request to support\@domains.qa in case you need any changes.

\n

$E Best Regards.

\n

$E CRA – Qatar Domains Registry Support


\) \| sendmail -t";

#system($cmd2);



exit;
