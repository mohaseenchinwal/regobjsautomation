#!/usr/bin/perl
use strict;
use warnings;
use Net::SSH::Expect;
use IO::CaptureOutput qw/capture/;
#


use Tk;
use Tk::Dialog;


my $PWD=`/bin/pwd`;
my ($stdout, $stderr);

my $command;

my $main = MainWindow->new();

$main -> geometry ("1000x1000");

$main -> Label(-background =>'black');


$main->title("QDR EPP WEB CLIENT");
my $image = $main->Photo(-file => "QDRlogo.gif");

my $labelimg = $main->Label(-image=>$image);
$labelimg->pack(-side=>"top");

my $output = $main->Label(-text=>"Console:");
$output->place(-relx => 0.1179,-rely => 0.1);

my $footer = $main->Label(-text=>"QDR EPP WEB CLIENT copy write owned by Mohaseen Khan 2017-18",-background => '#FFFFFF' );
$footer->pack(-side=>"bottom");



$main->Button(
        -text => 'Edit Config File',
        -command => \&Open_CS
             )->pack(-side => "left");
$main->Button(
        -text => 'Edit Command',
        -command => \&open_Command_setup
             )->place(-relx => 0.0,-rely => 0.65);

$main->Button(
        -text => 'LoadCommand',
        -command => \&Command_select 
             )->place(-relx => 0.0,-rely => 0.2);

$main->Button(
        -text => 'Run Command',
        -command =>  \&Command_Run
             )->place(-relx => 0.0,-rely => 0.3);

$main->Button(
        -text => 'SaveResponse',
        -command => \&Save_Response
             )->place(-relx => 0.0,-rely => 0.4);

$main->Button(
        -text => 'Clear Console',
        -command => \&Clear_Screen
             )->place(-relx => 0.0,-rely => 0.75);

$main->Button(
        -text => 'Upload Certs',
        -command => \&Upload_Certs
             )->place(-relx => 0.0,-rely => 0.9);





$main->bind('<Control-o>', [\&open_Command_setup]);
my $types = [ ['Perl files', '.pl'],
              ['xml Files',   '.xml'],['All Files',   '*'],['text Files',   '.txt'],];


$main->bind('<Control-s>', [\&Save_Response]);
my $types = [ ['Perl files', '.pl'],
              ['xml Files',   '.xml'],['All Files',   '*'],['text Files',   '.txt'],];


my $textWidget=$main->Scrolled(
          'Text',
          -height=>'1130',
          -width=>'1400',
          -font=>'50'
         )->pack;

tie *STDOUT, 'Tk::Text', $textWidget;


MainLoop();



sub open_Command_setup {
  my $open = $main->getOpenFile(-filetypes => $types,
                              -defaultextension => '.pl');
  print qq{You chose to open "$open"\n};
 # `/bin/cat $open`; 
  system("/usr/bin/gedit $open");
}



sub Open_CS {

 my $Conf_file='$PWD/etc/toolkit-Replay.properties';
 print $Conf_file;
 system("/usr/bin/gedit $Conf_file");

}


sub Command_select {

 $command = $main->getOpenFile(-filetypes => $types, -defaultextension => '.xml');
# $stdout=`bash /home/mohsin2/pgui/EPPGUI/replaytest/replay_tool/commands/run.sh Replay < $command`;
}




sub Command_Run {
 $stdout=`bash /home/mohsin2/pgui/EPPGUI/replaytest/replay_tool/commands/run.sh Replay < $command`;
 print $stdout;

} 



sub Save_Response {
 
  my $save = $main->getSaveFile(-filetypes => $types, 
                             -initialfile => 'test',
                             -defaultextension => '.txt');
  print qq{You chose to save as "$save"\n} if $save;
   open(FH, '>', $save) or die "cannot open file";
   select FH;
  print $stdout;
  close FH; 
 }

sub Clear_Screen {
                    $textWidget->delete('0.0','end'); 
                 }
                    
sub Upload_Certs {

                   my  $cert = $main->getOpenFile(-filetypes => $types, -defaultextension => '.jks'); 
                     
                   system("cp $cert /home/mohsin2/pgui/EPPGUI/replaytest/replay_tool/etc");

                 }
