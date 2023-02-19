use strict;
use warnings;
use XML::Twig;

#my @domainnames = ("klcecet1231.qa", "baselmission1231.qa", "basaveshwar1231.qa");

my $i;
my $xmlStr = <<XML;
<epp xmlns="urn:ietf:params:xml:ns:epp-1.0">
<command>
<create>
<domain:create xmlns:domain="urn:ietf:params:xml:ns:domain-1.0">
<domain:name>gma.qa</domain:name>
<domain:period unit="y">1</domain:period>
<domain:ns><domain:hostObj>ns1.sec.gov.qa</domain:hostObj><domain:hostObj>ns2.sec.gov.qa</domain:hostObj><domain:hostObj>ns3.sec.gov.qa</domain:hostObj></domain:ns>
<domain:registrant>QDR000620</domain:registrant>
<domain:contact type="admin">QDR000620</domain:contact>
<domain:contact type="tech">QDR000618</domain:contact>
<domain:contact type="billing">QDR000621</domain:contact>
<domain:authInfo>
<domain:pw>Lj^7*4hT</domain:pw>
</domain:authInfo>
</domain:create>
</create>
<extension>
<create xmlns="urn:X-ar:params:xml:ns:kv-1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:X-ar:params:xml:ns:kv-1.0 kv-1.0.xsd">
<kvlist name="qa"><item key="eligibilityType">School</item><item key="registrantName">Mohamad Samak</item></kvlist>
</create>
</extension>
<clTRID>ABC-12345</clTRID>
</command>
</epp>
XML



open (my $handle, '<', 'domains.txt') or die $!;
chomp(my @lines = <$handle>);
#print @lines;


for($i=0;$i<=$#lines;$i++){
    

                                open(FH, '>', 'dc1000.xml') or die "cannot open file";
                                select FH;
                                my $twig= new XML::Twig(
                                #    PrettyPrint   => 'indented',
                                twig_handlers => { 'domain:name' => sub { $_->set_text($lines[$i]) }  },
                                );
                                $twig->parse($xmlStr);
                                $twig->print();


                                close FH;

                                `bash /home/mohsin2/pgui/EPPGUI/replaytest/replay_tool/commands/run.sh Replay < /home/mohsin2/pgui/EPPGUI/replaytest/replay_tool/commands/dc1000.xml`;


                                # $twig->parse('dc1000.xml');
                                # print $twig -> root -> children -> text;
                                
                            }
close $handle;
exit;
