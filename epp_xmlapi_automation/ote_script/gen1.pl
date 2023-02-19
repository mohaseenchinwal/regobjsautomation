
use strict;
use warnings;





my $cmd6= "/bin/bash /root/eppclient_ote_clinet/replay_tool/run.sh Replay < /root/eppclient_ote_clinet/replay_tool/dc4003.xml";
my $cmd2= "/bin/grep -i addr";
my $cmd3 = "/bin/sed \'s/<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>//g\'";


system("$cmd6 | $cmd2 | $cmd3");
