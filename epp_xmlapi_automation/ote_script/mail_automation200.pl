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







my $t1;
my $t2;
my $t3;
my $t4;
my $placeholders;
my $sth;


############################# this section reads file called domains.txt located in the same path as that of script file line by line and sends to an array called lines###########









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

$E According to our registry system your domain’s  contacts is as below:

\n

$E Domain Owner:
\n

$E Email:

\n 

$E Domain Tech Contact: 

\n

$E Email:

\n

$E Domain Admin Contact:

\n

$E Email:

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


exit;
