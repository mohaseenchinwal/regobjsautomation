#!/usr/bin/perl

use strict;
use warnings;
use Tk;
use Tk::NoteBook;

my $starttime;
my $raisetime;
my $progressbar;
my $percent_done;

my $mw = MainWindow->new();
$mw->geometry("400x100");
my $book = $mw->NoteBook()->pack( -fill => 'both', -expand => 1 );
my $tab1 =
  $book->add( "Sheet 1", -label => "Start", -createcmd => \&getStartTi+me );
my $tab2 =
  $book->add( "Sheet 2", -label => "Continue", -raisecmd => \&getCurre+ntTime );
my $tab3 =
  $book->add( "Sheet 3", -label => "Progress", -createcmd => \&getProg+ressBar );
my $tab4 =
  $book->add( "Sheet 4", -label => "Command", -createcmd => \&getExecu+teCommand );
my $tab5 = $book->add( "Sheet 5", -label => "End", -state => 'disabled+' );
$tab1->Label( -textvariable => \$starttime )->pack( -expand => 1 );
$tab2->Label( -textvariable => \$raisetime )->pack( -expand => 1 );
$tab3->Button( -text => 'Quit', -command => sub { exit; } )
  ->pack( -expand => 1 );

MainLoop;

sub getStartTime {
    $starttime = "Started at " . localtime;
}

sub getCurrentTime {
    $raisetime = " Last raised at " . localtime;
    $book->pageconfigure( "Sheet 3", -state => 'normal' );
}

sub getProgressBar {
    my $mw = MainWindow->new( -title => 'ProgressBar example' );
    my $progress = $mw->ProgressBar(
        -width    => 30,
        -from     => 0,
        -to       => 100,
        -blocks   => 50,
        -colors   => [ 0, 'green', 50, 'yellow', 80, 'red' ],
        -variable => \$percent_done
    )->pack( -fill => 'x' );
    $mw->Button(
        -text    => 'Go!',
        -command => sub {
            for ( my $i = 0 ; $i < 1000 ; $i++ ) {
                $percent_done = $i / 10;
                print "$i\n";
                $mw->update;
            }
        }
    )->pack( -side => 'bottom' );
    MainLoop;
}

sub getExecuteCommand {

use Tk;
use Tk::ExecuteCommand;
use Tk::widgets qw/LabEntry/;
use strict;

my $mw = MainWindow->new;

my $ec = $mw->ExecuteCommand(
    -command    => '',
    -entryWidth => 50,
    -height     => 10,
    -label      => '',
    -text       => 'Execute',
                  )->pack;
$ec->configure(-command => 'date; sleep 10; date');


my $button = $mw->Button(-text =>'Do_it',
                         -background =>'hotpink',
                         -command => sub{ $ec->execute_command },
                        )->pack;
 
MainLoop;
}
