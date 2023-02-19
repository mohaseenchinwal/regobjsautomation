use strict;
use warnings;
use Data::Dumper;

use DBI;
use DBD::mysql;


my $E="/bin/echo";
my %hash;

my $key;
my $domain;
my $admin;
my $tech;
my $value;







my @email_id = ('shuja\@qu.edu.qa', 'shakeel\@qcci.org', 'shuja\@qu.edu.qa');



my $t1;
my $t2;
my $t3;
my $t4;
my $placeholders;
my $sth;


############################# this section reads file called domains.txt located in the same path as that of script file line by line and sends to an array called lines###########




my $dbh = DBI->connect("DBI:mysql:northwind", "root", "123")or die "Unable to connect: $DBI::errstr\n";


my $q2 = q{SELECT domainname FROM maildata1 WHERE Registrant_Email IN ($placeholders);};

my $q3="SELECT domainname FROM maildata1 WHERE Registrant_Email IN ($placeholders)";



$placeholders = join ",", ("?") x @email_id;
my $sql = "select * from maildata1 where Registrant_Email in ($placeholders)";




my $sth = $dbh->prepare($q2)  or die "Prepare failed: " . $dbh->errstr();
$sth->execute(@email_id);


  while(my @row = $sth->fetchrow_array()){
     $t1=$row[0];
     $t2=$row[1];
     $t3=$row[2];
     $t4=$row[3];
     print "\n$t1 $t2 $t3 $t4\n"
  } 




open FILE1, "mailist.txt" or die;







while (my $line=<FILE1>) {
   chomp($line);
   ($domain, $admin, $tech) = split /:/, $line;

  print "  $domain has a  $admin\n";
  print "  $domain has a  $tech\n";
  



#my $cmd1="\(

#$E \"From: mchinwal\@cra.gov.qa\";
#$E \"To: $admin\";
#$E \"Subject: Qatar Domains Registry Registrars admin Contact updation notification\";
#$E \"Content-Type: text/html\";
#$E \"MIME-Version: 1.0\";
#$E \"\";

#$E Dear Registrar,

#$E Kindly Confirm $domain contacts details;

#$E Regards
#$E QDR
#\) \| sendmail -t";

#system($cmd1);




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

system($cmd2);

}

exit;
