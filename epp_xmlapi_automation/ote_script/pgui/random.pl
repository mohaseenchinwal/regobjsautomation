#!/usr/bin/perl
use warnings;
use strict;

use Tk;

my $mw = MainWindow->new();
my $tx = $mw->Text()->pack();

tie *STDOUT, 'Tk::Text', $tx;

$mw->repeat(1000, \&tick);

MainLoop;

my $count;
sub tick {
  ++$count;
  print "$count\n" ;
  print " its easy ";
}
