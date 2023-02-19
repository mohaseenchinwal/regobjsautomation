use strict;
use warnings;
use XML::Twig;


my $output;



my $cmd1= "/bin/bash /root/eppclient_prod_client/eppclient/replay_tool/run.sh Replay < /root/eppclient_prod_client/eppclient/replay_tool//dc1000.xml";
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





my $xmlStr2 = <<XML;
<epp xmlns="urn:ietf:params:xml:ns:epp-1.0"xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:ietf:params:xml:ns:epp-1.0 epp-1.0.xsd">
<response>
<result code="1000"><msg lang="en">Command completed successfully</msg></result>
<resData>
<domain:infDataxmlns:domain="urn:ietf:params:xml:ns:domain-1.0" xsi:schemaLocation="urn:ietf:params:xml:ns:domain-1.0 domain-1.0.xsd">
<domain:name>difi.org.qa</domain:name>
<domain:roid>D50DE3CE01A2720B30DEA09081E8444E5-QDR</domain:roid>
<domain:status s="ok"/><domain:registrant>QT98998</domain:registrant><domain:contact type="tech">QT98998</domain:contact>
<domain:ns><domain:hostObj>ns1-05.azure-dns.com</domain:hostObj><domain:hostObj>ns3-05.azure-dns.org</domain:hostObj><domain:hostObj>ns4-05.azure-dns.info</domain:hostObj></domain:ns>
<domain:clID>QDR</domain:clID><domain:crID>Registry</domain:crID><domain:crDate>2013-04-18T08:41:43.0Z</domain:crDate><domain:upID>Registry</domain:upID><domain:upDate>2021-04-15T07:16:34.0Z</domain:upDate>
<domain:exDate>2026-04-18T08:41:43.0Z</domain:exDate>
<domain:authInfo><domain:pw>18APth!@</domain:pw></domain:authInfo>
</domain:infData>
</resData>
<extension>
<infDataxmlns="urn:X-ar:params:xml:ns:kv-1.0"><kvlist name="qa"><item key="eligibilityType">Public Benefit Organization</item><item key="registrantName">Qatar Foundation - Information Technology</item></kvlist></infData></extension><trID><clTRID>qadr_epp</clTRID><svTRID>70263980</svTRID></trID>
</response>
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

#system("$cmd1 | $cmd2 | $cmd3");

`$cmd1 | $cmd2 | $cmd3 >> exp_out.txt`



#open (FH1, '<', 'exp_out.txt') or die "cannot open file";
#select FH1;
#my $twig1= new XML::Twig();
#$twig1->parse($xmlStr2);
#$twig1->print();
#close FH1;







}





##Finally domains.txt file is closed 
close $handle;
exit;
