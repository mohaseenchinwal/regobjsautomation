#!/usr/bin/perl

# http://perlmonks.org/?node_id=1166095

use strict;
use warnings;
use Tk;

my $numcel = 1;

my $mw = new MainWindow -title => 'Celcius to Farienhiet Converter';
$mw->geometry( '500x500' );

my $scl = $mw->Scale(
  -label=>"No of Celcius Values to Enter:",
  -orient => 'h', -digit => 2,
  -from => 1, -to => 10, -tickinterval => 1,
  -variable => \$numcel,
  )->pack( -fill => 'x' );

$mw->Button(
  -text=>"Push Me", -command =>\&push_button_sec,
  )->pack();

my $frame = $mw->Frame->pack( -fill => 'x' );

MainLoop;

sub push_button_sec
  {
  $_->destroy for $frame->children;
  for my $i (1..$numcel)
    {
    my $answer = '';
    my $input = '';
    my $item = $frame->Frame()->pack(-fill => 'x');
    $item->Label(
      -text => "Enter Celsius Value:",
      )->pack(-side => 'left');
    my $output = $item->Entry(
      -textvariable => \$input,
      )->pack(-side => 'left');
    $item->Label(
      -textvariable => \$answer,
      )->pack(-side => 'left');
    $output->bind( '<Return>' => sub {
      $answer = sprintf '%.1f', $input * 9 / 5 + 32;
      });
    }
  }
