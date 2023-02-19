#!/usr/bin/env perl

use strict;
use warnings 'all';

use XML::Twig;

my $twig = XML::Twig->parse( \*DATA );

#we can use the 'root' method to find the root of the XML.
my $root = $twig->root;

#first_child finds the first child element matching a value.
my $title = $root->first_child('epp');

#text reads the text of the element.
my $title_text = $title->text;

print "Title is: ", $title_text, "\n";

#The above could be combined:
print $twig ->root->first_child_text('epp'), "\n";

## You can use the 'children' method to iterate multiple items:
#my $list = $twig->root->first_child('list');

#children can optionally take an element 'tag' - otherwise it just returns all of them.
#foreach my $element ( $list->children ) {

   #the 'att' method reads an attribute
#   print "Element with ID: ", $element->att('id') // 'none here', " is ", $element->text,
#     "\n";
#}

#And if we need to do something more complicated, we an use 'xpath'.
#get_xpath or findnodes do the same thing:
#return a list of matches, or if you specify a second numeric argument, just that numbered match.

#xpath syntax is fairly extensive, but in this one - we search:
# anywhere in the tree: //
#nodes called 'item'
#with an id attribute [@id]
#and with that id attribute equal to "1000". 
#by specifying '0' we say 'return just the first match'.

#print "Item 1000 is: ", $twig->get_xpath( '//item[@id="1000"]', 0 )->text, "\n";

#this combines quite well with `map` to e.g. do the same thing on multiple items
#print "All IDs:\n", join ( "\n", map { $_ -> att('id') } $twig -> get_xpath('//item')); 
#note how this also finds the item under 'summary', because of //

__DATA__
<start><epp xmlns="urn:ietf:params:xml:ns:epp-1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:ietf:params:xml:ns:epp-1.0 epp-1.0.xsd"><response><result code="1000"><msg lang=
"en">Command completed successfully</msg></result><resData><domain:infData xmlns:domain="urn:ietf:params:xml:ns:domain-1.0" xsi:schemaLocation="urn:ietf:params:xml:ns:domain-1.0 domain-1.0.xsd"><domain:name>qa
targbc.org.qa</domain:name><domain:roid>D0016309D5A16814CC1B757F446A0C346-QDR</domain:roid><domain:status s="ok"/><domain:registrant>QDR000102</domain:registrant><domain:contact type="tech">QDR000102</domain:c
ontact><domain:ns><domain:hostObj>ns-1538.awsdns-00.co.uk</domain:hostObj><domain:hostObj>ns-1495.awsdns-58.org</domain:hostObj><domain:hostObj>ns-879.awsdns-45.net</domain:hostObj><domain:hostObj>ns-129.awsdn
s-16.com</domain:hostObj></domain:ns><domain:clID>QDR</domain:clID><domain:crID>Registry</domain:crID><domain:crDate>2012-03-11T07:29:57.0Z</domain:crDate><domain:upID>Registry</domain:upID><domain:upDate>2020
-05-18T09:22:17.0Z</domain:upDate><domain:exDate>2025-03-11T07:29:57.0Z</domain:exDate><domain:authInfo><domain:pw>QF387)($%</domain:pw></domain:authInfo></domain:infData></resData><extension> <infData xmlns="
urn:X-ar:params:xml:ns:kv-1.0"><kvlist name="qa"><item key="eligibilityType">Public Benefit Organization</item><item key="registrantName">IT Service Center - Qatar Foundation</item></kvlist></infData></extensi
on><trID><clTRID>qadr_epp</clTRID><svTRID>70268578</svTRID></trID></response></epp><epp xmlns="urn:ietf:params:xml:ns:epp-1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:ietf
:params:xml:ns:epp-1.0 epp-1.0.xsd"><response><result code="1000"><msg lang="en">Command completed successfully</msg></result><resData><domain:infData xmlns:domain="urn:ietf:params:xml:ns:domain-1.0" xsi:schem
aLocation="urn:ietf:params:xml:ns:domain-1.0 domain-1.0.xsd"><domain:name>difi.org.qa</domain:name><domain:roid>D50DE3CE01A2720B30DEA09081E8444E5-QDR</domain:roid><domain:status s="ok"/><domain:registrant>QT98
998</domain:registrant><domain:contact type="tech">QT98998</domain:contact><domain:ns><domain:hostObj>ns1-05.azure-dns.com</domain:hostObj><domain:hostObj>ns3-05.azure-dns.org</domain:hostObj><domain:hostObj>n
s4-05.azure-dns.info</domain:hostObj></domain:ns><domain:clID>QDR</domain:clID><domain:crID>Registry</domain:crID><domain:crDate>2013-04-18T08:41:43.0Z</domain:crDate><domain:upID>Registry</domain:upID><domain
:upDate>2021-04-15T07:16:34.0Z</domain:upDate><domain:exDate>2026-04-18T08:41:43.0Z</domain:exDate><domain:authInfo><domain:pw>18APth!@</domain:pw></domain:authInfo></domain:infData></resData><extension> <infD
ata xmlns="urn:X-ar:params:xml:ns:kv-1.0"><kvlist name="qa"><item key="eligibilityType">Public Benefit Organization</item><item key="registrantName">Qatar Foundation - Information Technology</item></kvlist></i
nfData></extension><trID><clTRID>qadr_epp</clTRID><svTRID>70268727</svTRID></trID></response></epp></start>
