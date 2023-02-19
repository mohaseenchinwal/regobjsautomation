#!/usr/bin/perl -w



#use Net::SSH::Expect;
#use Text::Table;
use Tk;

$main = MainWindow->new();
$main->title("QDR Password reset Utility");

$label1 = $main->Label(-text=>"Enter user name:");
$label1->pack(-side=>"left");
$txt1 = $main->Entry()->pack(-side=>"left");

$label2 = $main->Label(-text=>"Enter Old password:");
$label2->pack(-side=>"left");
$txt2= $main->Entry()->pack(-side=>"left");

$label3 = $main->Label(-text=>"Enter new password:");
$label3->pack(-side=>"left");
$txt3= $main->Entry()->pack(-side=>"left");

$label3 = $main->Label(-text=>"Confirm new password:");
$label3->pack(-side=>"left");
$txt4= $main->Entry()->pack(-side=>"left");
MainLoop();



$txt4->bind("<Return>", \&handle_return);
#MainLoop();


sub handle_return {
    $txt5 = $txt1->get();
    $txt6 = $txt2->get();
    $txt7 = $txt3->get();
    $txt8 = $txt4->get();
 
print "You entered $txt5 $txt6 $txt7 $txt8 \n";
exit;


}
