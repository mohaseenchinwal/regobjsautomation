use strict;
use warnings;
use diagnostics;

use Tk;
use Tk::NoteBook;

my @types=();
my $file_array=undef;
my ($page,$content)=undef;

my $mw = MainWindow -> new(-title => "Testing");

$mw->Button(-text => "Open", -command =>\&fopen)->pack(-anchor => 'center', -side=>"left");  
$mw->Button(-text => "Save", -command =>\&save)->pack(-anchor => 'center', -side=>"left");  

my $nb = $mw->NoteBook(-background=> 'white', -inactivebackground => 'grey',  )->pack(-expand => 1, -fill => 'both');  
my $maintab="Main Window";
my $frame = $nb->add($maintab,-label => $maintab);
my $txt=$frame-> Text(-width=>240, -height=>50)->pack(); 

MainLoop;

sub file_open {
 @types =( ["Log files", [qw/.log/]],
 ["Text files", [qw/.txt/]],
  ["All files", '*'],
 );

my $aref = $mw->getOpenFile(
 -filetypes => \@types ,
 -initialdir => '.',
 -multiple =>1
 );
    return($aref);
}

sub fopen {
$file_array=&file_open;
print "\n";
print join("\n", @$file_array);
print "\n";
for my $tab (@$file_array){
     my $frame = $nb->add($tab,-label => $tab);
     $txt=$frame-> Text(-width=>240, -height=>50)->pack(); 
     open FR, "<$tab"  or die "Cant open file:$!\n";
     $content=join "", <FR>;
     $txt->insert('end',"$content");
     close(FR);
     } 
}


sub save {
 $page=$nb->raised();
 $content=$txt->get("1.0", "end");
 print "\nsaving content= $content\n";
 open FW,">$page" or die "Cant Write to file:$!\n";
 print FW $content;
 close(FW);  
}
