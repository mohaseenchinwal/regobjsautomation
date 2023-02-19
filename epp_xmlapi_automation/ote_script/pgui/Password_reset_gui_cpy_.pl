#!/usr/bin/perl
use strict;
use warnings;
use Net::SSH::Expect;
#


use Tk;
use Tk::Dialog;
use Time::Stopwatch;
use Tk::ProgressBar;



my $percent_done =0;
#tie my $percent_done, 'Time::Stopwatch';
my @host_array5 = ("reg.qadr.qa");











my $main = MainWindow->new();

#$main->geometry("800x500");
$main->title("QDR Password reset Utility");






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
        -command => sub{                                         
        

                              reset_pass($usr, $oldpass, $newpass, $cnewpass, @host_array5)
                  }
    )->pack(-side=>"top",-expand => 1,-fill => 'x');

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
#my $subprogress = $recprogress->get;
my $percent_done =0;

  foreach ($i=0;$i<=$#host_array5_passed;$i++) {        
                                                        my $ssh = Net::SSH::Expect->new(
                                                        user => $sudousername,                #login into the host with respective field end ":" in the file hosts.txt
                                                        host => $host_array5_passed[$i],
                                                        password => $sudopass,
                                                        raw_pty => 1,
                                                        timeout => 3
                                                        );
                                                           
                                                                     

                                                                         my $mw = MainWindow->new(-title => 'ProgressBar example');

                                                                         my  $progress = $mw->ProgressBar(
                                                                                                  -width => 30,
                                                                                                  -from => 0,
        											 -to => 100,
						                                                 -blocks => 50,
				                                                                 -colors => [0, 'green', 50, 'yellow' , 80, 'red'],
	                                                                                 	 -variable => \$percent_done
	                                                                                      )->pack(-fill => 'x');

									$mw->Button(-text => 'Go!', -command=> sub {
									   for ($i = 0; $i < 1000; $i++) { 
									     $percent_done = $i/10;
									     print "$i\n";
									     $mw->update;  # otherwise we don't see how far we are.
									  }
									 })->pack(-side => 'bottom');

								MainLoop;  





												  
								   
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

											     print "Password Changed sucesfully in  seconds!!!!!!!! for username $subusr on host $host_array5_passed[$i]\n";

										 my $answer = $main->messageBox(-title => 'Password Changed', -message => "Password Reset Completed", -type => 'Ok');
											      # -bitmap => 'question' )->Show( );
										  if ($answer eq 'Ok') {
													  exit;
													}


										     }

					}

