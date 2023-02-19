#!/usr/bin/perl
use strict;
use warnings;
use Net::SSH::Expect;
#


use Tk;

my $main = MainWindow->new();
$main->title("QDR Password reset Utility");

my $label1 = $main->Label(-text=>"Enter user name:");
$label1->pack(-side=>"left");
my $txt1 = $main->Entry()->pack(-side=>"left");

my $label2 = $main->Label(-text=>"Enter Old password:");
$label2->pack(-side=>"left");
my $txt2= $main->Entry()->pack(-side=>"left");

my $label3 = $main->Label(-text=>"Enter new password:");
$label3->pack(-side=>"left");
my $txt3= $main->Entry()->pack(-side=>"left");

my $label4 = $main->Label(-text=>"Confirm new password:");
$label4->pack(-side=>"left");
my $txt4= $main->Entry()->pack(-side=>"left");
#MainLoop();



#$txt4->bind("<Return>", \&handle_return);


$main->Button(
        -text => 'Reset Password',
        -command => sub{reset_pass($txt3, $txt4)}
    )->pack;

MainLoop();


sub reset_pass {
my    $txt5 = $txt1->get();
my    $txt6 = $txt2->get();
my    $txt7 = $txt3->get();
my    $txt8 = $txt4->get();

print "You entered $txt5 $txt6 $txt7 $txt8 \n";
exit;


}

##########################################################################################################################################################


 my $chage1;
 my $chage2;
my @host_array1 = ("qapr-backup.qapr.local", "qapr-cloudctl1.qapr.local", "ns1-1.qapr.local", "ns1-2.qapr.local", "ns2-1.qadr.local", "ns2-2.qadr.local");
my @host_array2 = ("qapr-mgmt1.qapr.local", "qapr-mgmt2.qapr.local", "qadr-mgmt1.qadr.local", "qapr-db1.qapr.local", "qapr-db2.qapr.local", "10.206.10.6");
my @host_array3 = ("qadr-db1.qadr.local", "qapr-epp1.qapr.local", "qapr-epp2.qapr.local", "qadr-epp1.qadr.local", "qapr-ote1.qapr.local", "qapr-ote2.qapr.local");
my @host_array4 = ("qadr-web1.qadr.local", "qadr-whois1.qadr.local", "qapr-web1.qapr.local", "qapr-web2.qapr.local", "qapr-whois1.qapr.local", "qapr-whois2.qapr.local");
my @host_array5 = ("reg.qadr.qa");

  open(FH, '>', '/home/mohsin/exp_out.txt') or die "cannot open file";
   select FH;
   #process(@host_array1);
   #process(@host_array2);
   #process(@host_array3);
   #process(@host_array4);
   process(@host_array5);
  close FH;  # in the end

system('mail -s "Linux_systems_Password_Expiry_details" mchinwal\@cra.gov.qa < /home/mohsin/exp_out.txt');








sub   process {
                           my @host_array = @_;
                           my $i;
                           my $username='mohsin';
                           my $password='12Iso*help';
                           my $pass2='qdr123QDR!@#';

                    foreach ($i=0;$i<=$#host_array;$i++) {
                                                        my $ssh = Net::SSH::Expect->new(
                                                        user => $username,                #login into the host with respective field end ":" in the file hosts.txt
                                                        host => $host_array[$i],
                                                        password => $password,
                                                        raw_pty => 1,
                                                        timeout => 3
                                                        );
                                                        my $login_output = $ssh->login();
                                                        print $ssh->peek(0);
                                                        $ssh->eat($ssh->peek(0));
                                                        $ssh->send("sudo -S passwd shamseer");
                                                        $ssh->waitfor('[sudo] password for mohsin\s*', 5);
                                                        print $ssh->peek(5);
                                                        $ssh->send("$password");
                                                        $ssh->waitfor('password:\s*\z', 5);
                                                        print $ssh->peek(5);
                                                        $ssh->send("$pass2");
                                                        print $ssh->peek(5);
                                                        $ssh->waitfor('password:\s*\z', 5);
							$ssh->send("$pass2");
                                                        print $ssh->peek(5);
                                                        #$chage1 = $ssh->exec("chage ");
                                                        #print $chage1;
                                                        #my $chage1 = $ssh->exec(" echo 12Iso\*help | sudo -S chage -d 0 shamseer");
                                                        # print $chage1;
                                                        $login_output = $ssh->close();
                                                        }


                                                #print $chage;


}

