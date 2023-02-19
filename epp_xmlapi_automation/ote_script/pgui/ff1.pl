#!perl
# file opensave.pl
use Tk;
use strict;
use warnings;
my $mw = MainWindow->new;
$mw->title('Menu');
my $menubar = $mw->Menu(-type => 'menubar');
$mw->configure(-menu => $menubar);
my $mfile = $menubar->cascade(-label => '~File', -tearoff => 0);
$mfile->command(-label => '~Open',
                -accelerator => 'Control+o',
                -command => \&open_file);
$mfile->command(-label => '~Save',
                -accelerator => 'Control+s',
                -command => \&save_file);
my $exit = $mw->Button(-text => 'Exit',
                       -command => [$mw => 'destroy']);
$mw->bind('<Control-o>', [\&open_file]);
$mw->bind('<Control-s>', [\&save_file]);
$exit->pack;
my $types = [ ['Perl files', '.pl'],
              ['All Files',   '*'],];
MainLoop;

sub open_file {
  my $open = $mw->getOpenFile(-filetypes => $types,
                              -defaultextension => '.pl');
  print qq{You chose to open "$open"\n} if $open;
}

sub save_file {
  my $save = $mw->getSaveFile(-filetypes => $types, 
                             -initialfile => 'test',
                             -defaultextension => '.pl');
  print qq{You chose to save as "$save"\n} if $save;
}
