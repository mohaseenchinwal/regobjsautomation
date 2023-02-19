#!/bin/perl -w

#########################################################################
#                                                                       #
#  This example shows how to create, and paste elements                 #
#  It creates a new element named blg, for each player                  #
#                                                                       #
#########################################################################

use strict;
use XML::Twig;

my $twig= new XML::Twig;

$twig->parsefile( "dc2001.xml");    # build the twig
my $root= $twig->root;           # get the root of the twig (stats)
my @players= $root->children;    # get the player list

my $g;
my $blk;                                 
foreach my $player (@players)     
 { $g  = $player->first_child( 'epp')->text;    # get the text of g            
   #$blk= $player->first_child( 'domain:name')->text;  # get the text of blk
   #my $blg= sprintf( "%2.3f", $blk/$g);          # compute blg
   #my $eblg= new XML::Twig::Elt( 'blg', $blg);   # create the element
   #$eblg->paste( 'last_child', $player);         # paste it in the document   
 }

$twig->print;  

#print "$g";
print $root;
#print "$blk";
