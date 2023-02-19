   #!/usr/bin/perl -w  
    use Tk;
    use strict;

    my $mw = MainWindow->new;
    $mw->Label(-text => 'QDR Password Mangement Utility')->pack;
    $mw->Button(
        -text    => 'Quit',
        -command => sub { exit },
    )->pack;
    my $label= $mw;
    $mw->pack(-side=>"left");



   my  $entry = $mw->Entry();

    $entry->bind("<Return>", \&handle_return );
    $entry->pack(-side=>"left");
    MainLoop;



 sub handle_return {
   my  $txt = $entry->get();
    print "You entered $txt\n";
    exit;
}
