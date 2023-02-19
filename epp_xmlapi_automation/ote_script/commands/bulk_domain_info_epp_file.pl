use strict;
use warnings;
use XML::Twig;

#my @domainnames = ("klcecet1231.qa", "baselmission1231.qa", "basaveshwar1231.qa");

my $FP="/home/mohsin2/pgui/EPPGUI/replaytest/replay_tool/commands/";
my $i;
my $xmlStr = <<XML;
<epp xmlns="urn:ietf:params:xml:ns:epp-1.0">
<command>
<info>
<domain:info xmlns:domain="urn:ietf:params:xml:ns:domain-1.0"><domain:name>mascus.com.qa</domain:name></domain:info>
</info>
<clTRID>qadr_epp</clTRID>
</command>
</epp>
XML

 `rm -rf $FP/res1.txt`;
 `touch $FP/res1.txt`;
  

open (my $handle, '<', 'domains.txt') or die $!;
chomp(my @lines = <$handle>);
#print @lines;


for($i=0;$i<=$#lines;$i++){
    

                                open(FH, '>', 'dc1000.xml') or die "cannot open file";
                                select FH;
                                my $twig= new XML::Twig(
                                       #PrettyPrint   => 'indented',
                                twig_handlers => { 'domain:name' => sub { $_->set_text($lines[$i]) }  },
                                );
                                $twig->parse($xmlStr);
                                $twig->print();


                                close FH;

                                `bash $FP/run.sh Replay < $FP/dc1000.xml >> $FP/res1.txt`;
                                 $twig->parse('$FP/res1.txt');

                                # $twig->parse('dc1000.xml');
                                # print $twig -> root -> children -> text;
                                
                            }
close $handle;
exit;
