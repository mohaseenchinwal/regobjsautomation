use strict;
use warnings;
use XML::Twig;


my $xmlStr = <<XML;
<epp xmlns="urn:ietf:params:xml:ns:epp-1.0">
<command>
<update>
<domain:update xmlns:domain="urn:ietf:params:xml:ns:domain-1.0">
<domain:name>abamesnad.sch.qa</domain:name>
</domain:update>
</update>
<extension><update xmlns="urn:X-ar:params:xml:ns:kv-1.0"><kvlist name="qa"><item key="eligibilityType">Education Institution</item><item key="registrantName">QATAR</item></kvlist></update></extension>
<clTRID>ABC-12345</clTRID>
</command>
</epp>
XML

############################# this section reads file called domains.txt located in the same path as that of script file line by line and sends to an array called lines###########


open (my $handle, '<', 'domains.txt') or die $!;
chomp(my @lines = <$handle>);
print @lines;




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

`bash /root/eppclient_prod_client/eppclient/replay_tool/run.sh Replay < /root/eppclient_prod_client/eppclient/replay_tool/dc1000.xml`;

}

##Finally domains.txt file is closed 
close $handle;
exit;
