#!/usr/bin/perl

use 5.010;
use strict;
use warnings;

use XML::Twig;



my $xml = `/bin/cat dc2002.xml`; 

my $twig = XML::Twig->new;

$twig->parse( $xml );


my $commit   = $twig->first_elt( 'commit' );


my $author   = $commit->first_child_text( 'author' );
my $date     = $commit->first_child_text( 'date' );


my $revision = $commit->att( 'revision' );

print "Revision $revision\n";
print "author $author\n";
print "date $date\n";
