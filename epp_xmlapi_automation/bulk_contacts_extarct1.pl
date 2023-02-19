use strict;
use warnings;
use XML::Twig;




my $cmd1= "/bin/bash /root/eppclient_prod_client/eppclient/replay_tool//run.sh Replay < /root/eppclient_prod_client/eppclient/replay_tool//dc1000.xml";
my $cmd2= "/bin/grep -i registrant";
my $cmd3 = "/bin/sed \'s/<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>//g\'";

my $path1="/root/eppclient_ote_clinet/replay_tool/bxml";



my $xmlStr = <<XML;
<epp xmlns="urn:ietf:params:xml:ns:epp-1.0">
<command>
<info>
<domain:info xmlns:domain="urn:ietf:params:xml:ns:domain-1.0">
<domain:name>obzschool.sch.qa</domain:name></domain:info>
</info><clTRID>qadr_epp</clTRID>
</command>
</epp>
XML





############################# this section reads file called domains.txt located in the same path as that of script file line by line and sends to an array called lines###########


open (my $handle, '<', 'domains.txt') or die $!;
chomp(my @lines = <$handle>);
#print @lines;




##################################This section is used to open loop to read  the domains from the array lines



for(my $i=0;$i<=$#lines;$i++){


############################## 

#1)Opens a file called dc1000.xml
#2)Inserts the domains name  which are array elements   from the array lines in the domain create template.
#3)dumps the xml query with  inserted domain name into dc1000.xml file
#4)closes the file dc1000.xml.



open(FH, '>', 'dc1000.xml') or die "cannot open file";
select FH;
my $twig= new XML::Twig(

    twig_handlers => { 'domain:name' => sub { $_->set_text($lines[$i]) }  },
);
$twig->parse($xmlStr);
$twig->print();

close FH;

############################## 

system("$cmd1 | $cmd2 | $cmd3");


}

##Finally domains.txt file is closed 
close $handle;
exit;
