use strict;
use warnings;
use XML::Twig;

#my @domainnames = ("klcecet1231.qa", "baselmission1231.qa", "basaveshwar1231.qa");

my $i;
my $xmlStr = <<XML;
<?xml version="1.0" encoding="UTF-8" standalone="no"?><epp xmlns="urn:ietf:params:xml:ns:epp-1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:ietf:params:xml:ns:epp-1.0
epp-1.0.xsd"><command><renew><domain:renew xmlns:domain="urn:ietf:params:xml:ns:domain-1.0" xsi:schemaLocation="urn:ietf:params:xml:ns:domain-1.0 domain-1.0.xsd"><domain:name>example.co.uk</domain:name><domain:curExpDate>2018-07-26</domain:curExpDate><domain:period unit="y">5</domain:period></domain:renew></renew><clTRID>ABC-12345</clTRID></command></epp>
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
