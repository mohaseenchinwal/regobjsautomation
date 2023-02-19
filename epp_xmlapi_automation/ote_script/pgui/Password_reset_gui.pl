#!/usr/bin/perl
use strict;
use warnings;
use Net::SSH::Expect;
#


use Tk;
use Tk::Dialog;

my @host_array5 = ("reg.qadr.qa", "10.206.10.6");













my $main = MainWindow->new();
$main -> geometry ("820x480");
#$main->geometry("800x500");
$main->title("QDR Password reset Utility");
my $image = $main->Photo(-file => "QDRlogo.gif");




my $labelimg = $main->Label(-image=>$image);
$labelimg->pack(-side=>"top");

my $footer = $main->Label(-text=>"QDR Servers password reset tool for internal use only copy write owned by Mohaseen Khan 2017-18");
$footer->pack(-side=>"bottom");


my $label1 = $main->Label(-text=>"Enter user name:");
$label1->pack(-side=>"top");
my $usr = $main->Entry()->pack(-side=>"top");

my $label2 = $main->Label(-text=>"Enter Old password:");
$label2->pack(-side=>"top");
my $oldpass= $main->Entry(-show=>'*')->pack(-side=>"top");

my $label3 = $main->Label(-text=>"Enter new password:");
$label3->pack(-side=>"top");
my $newpass= $main->Entry(-show=>'*')->pack(-side=>"top");

my $label4 = $main->Label(-text=>"Confirm new password:");
$label4->pack(-side=>"top");
my $cnewpass= $main->Entry(-show=>'*')->pack(-side=>"top");


$main->Button(
        -text => 'Reset Password',
        -command => sub{reset_pass($usr, $oldpass, $newpass, $cnewpass, @host_array5)}
             )->pack(-side=>"top");

MainLoop();



#$txt4->bind("<Return>", \&handle_return);





sub reset_pass {
#my    $txt5 = $txt1->get();
#my    $txt6 = $txt2->get();

my ($username, $oldpassword, $newpassword, $confnewpassword, @host_array5_passed)= @_;
my $subusr = $username->get;
my $suboldpass = $oldpassword->get;
my $subnewpass = $newpassword->get;
my $subcnewpass = $confnewpassword->get;
my $sudousername = 'mohsin';
my $sudopass = '12Iso*help';
my $i;

  foreach ($i=0;$i<=$#host_array5_passed;$i++) {
                                                        my $ssh = Net::SSH::Expect->new(
                                                        user => $sudousername,                #login into the host with respective field end ":" in the file hosts.txt
                                                        host => $host_array5_passed[$i],
                                                        password => $sudopass,
                                                        raw_pty => 1,
                                                        timeout => 3
                                                        );
                           
                                                         print "Password Change Begins  for username $subusr on host $host_array5_passed[$i]\n";
                                                        my $login_output = $ssh->login();
                                                        print $ssh->peek(0);
                                                        $ssh->eat($ssh->peek(0));
                                                        $ssh->send("sudo -S passwd $subusr");
                                                        $ssh->waitfor("[sudo] password for $subusr\s*", 5);
                                                        print $ssh->peek(5);
                                                        $ssh->send("$sudopass");
                                                        $ssh->waitfor('password:\s*\z', 5);
                                                        print $ssh->peek(5);
                                                        $ssh->send("$subcnewpass");
                                                        print $ssh->peek(5);
                                                        $ssh->waitfor('password:\s*\z', 5);
                                                        $ssh->send("$subcnewpass");
                                                        print $ssh->peek(5);
                                                        $login_output = $ssh->close();

                                                     print "Password Changed sucesfully !!!!!!!! for username $subusr on host $host_array5_passed[$i]\n";



                                             }




                                    my $answer = $main->messageBox(-title => 'Password Changed', -message => "Password Reset Completed", -type => 'Ok');
                                          if ($answer eq 'Ok') {
                                                                  exit;
                                                                
                                                               }



}

