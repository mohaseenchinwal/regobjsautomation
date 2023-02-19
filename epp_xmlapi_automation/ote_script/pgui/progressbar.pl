#!/usr/bin/perl
use strict;
use warnings;
use Tk;
use Tk::ProgressBar;
use Time::Stopwatch;

my $i=0;
my $mw = MainWindow->new(-title => 'Processing');

my $Progress = $mw->ProgressBar(
                 -width => 30,
                -from => 0,
                -to => 100,
                -blocks => 50,
                -colors => [
                        1000000000, 'green',
                        5000000000000, 'yellow' ,
                        8000000000000, 'red',
                       ],
                -variable => \$i
                   )->pack(-fill => 'x');

$mw->Button(-text => 'Go!', -command=> sub {
        #  my $i;
          for ($i =0; $i < 100000;) {
         tie my $i, 'Time::Stopwatch';
        $i = $i/10;
       # print STDOUT "$i\n";
        print "\ntime to bar $i\n";
        $mw->update; 
          }
        })->pack(-side => 'bottom');

MainLoop();
