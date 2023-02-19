use strict;
use warnings;
use XML::Twig;

my @domainnames = ("klcecet100.qa", "baselmission100.qa", "basaveshwar100.qa");

my $xmlStr = <<XML;
<epp xmlns="urn:ietf:params:xml:ns:epp-1.0">
<command>
<create>
<domain:create xmlns:domain="urn:ietf:params:xml:ns:domain-1.0">
<domain:name>gma.qa</domain:name>
<domain:period unit="y">1</domain:period>
<domain:registrant>qdr123</domain:registrant>
<domain:contact type="admin">qdr123</domain:contact>
<domain:contact type="tech">qdr123</domain:contact>
<domain:authInfo>
<domain:pw>qdr.123</domain:pw>
</domain:authInfo>
</domain:create>
</create>
<clTRID>ABC-12345</clTRID>
</command>
</epp>
XML

foreach my $i (0 .. $#domainnames) {

open(FH, '>', 'dc1000.xml') or die "cannot open file";
select FH;
my $twig= new XML::Twig(
#    PrettyPrint   => 'indented',
    twig_handlers => { 'domain:name' => sub { $_->set_text($domainnames[$i]) }  },
);
$twig->parse($xmlStr);
$twig->print();



close FH;

`bash /home/mohsin2/pgui/EPPGUI/replaytest/replay_tool/commands/run.sh Replay < /home/mohsin2/pgui/EPPGUI/replaytest/replay_tool/dc1000.xml`;
 #$twig->parse('/home/mohsin2/pgui/EPPGUI/replaytest/replay_tool/dc1000.xml');
 #print $twig -> root -> children -> text;


}
exit;












