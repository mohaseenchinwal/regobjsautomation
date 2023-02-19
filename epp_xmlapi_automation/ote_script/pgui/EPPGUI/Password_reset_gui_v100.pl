#!/usr/bin/perl
use strict;
use warnings;
use Net::SSH::Expect;
#


use Tk;
use Tk::Dialog;
use Tk::ProgressBarPlus;


my $percent_done=0;
my $position;
my $PWD=`/bin/pwd`;

my $command;

my $main = MainWindow->new();
$main -> geometry ("1000x800");
$main -> Label(-background =>'black');
#$main->geometry("800x500");
$main->title("QDR EPP WEB CLIENT");
my $image = $main->Photo(-file => "QDRlogo.gif");






my $labelimg = $main->Label(-image=>$image);
$labelimg->pack(-side=>"top");

my $footer = $main->Label(-text=>"QDR EPP WEB CLIENT copy write owned by Mohaseen Khan 2017-18",-background => '#FFFFFF' );
$footer->pack(-side=>"bottom");






$main->Button(
        -text => 'Client Setup',
        -command => \&Open_CS
             )->pack(-side=>"top");
$main->Button(
        -text => 'Commands Setup',
        -command => \&open_Command_setup
             )->pack(-side=>"top");

$main->Button(
        -text => 'Choose Command to run',
        -command => \&Command_select 
             )->pack(-side=>"top");

$main->Button(
        -text => 'Run',
        -command =>  \&Command_select
             )->pack(-side=>"top");



$main->Button(
        -text => 'Save Response',
        -command => sub{reset_pass()}
             )->pack(-side=>"top");

$main->Button(
        -text => 'Save Logs',
        -command => sub{reset_pass()}
             )->pack(-side=>"top");


$main->bind('<Control-o>', [\&open_file]);
my $types = [ ['Perl files', '.pl'],
              ['xml Files',   '.xml'],['All Files',   '*'],];


MainLoop();




sub open_Command_setup {
  my $open = $main->getOpenFile(-filetypes => $types,
                              -defaultextension => '.pl');
  print qq{You chose to open "$open"\n};
 # `/bin/cat $open`; 
  system("/usr/bin/gedit $open");
}

sub Open_CS {

 my $Conf_file='$PWD/replaytest/replay_tool/etc/toolkit-Replay.properties';
 print $Conf_file;
 system("/usr/bin/gedit $Conf_file");

}


sub Command_select {

 $command = $main->getOpenFile(-filetypes => $types,
                              -defaultextension => '.xml');
 print $command;
 system("bash /home/mohsin2/pgui/EPPGUI/replaytest/replay_tool/commands/run.sh Replay < $command");

}

sub Command_Run {

    system("bash /home/mohsin2/pgui/EPPGUI/replaytest/replay_tool/commands/run.sh Replay < $command");
 
}
