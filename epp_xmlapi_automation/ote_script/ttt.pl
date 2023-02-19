#!/usr/bin/perl --
use strict;
use warnings;
use XML::Twig;
use DBI;
use DBD::mysql;
use XML::Simple;
use Data::Dumper;




my $E6="/bin/echo";
my $CAT="/bin/cat";
my $DATA="/root/eppclient_ote_clinet/replay_tool/output.html";
my $FILEPATH="/root/eppclient_ote_clinet/replay_tool";


`echo "<tr><td>row1[0]</td><td>row1[1]</td><td>row1[2]</td><td>row1[3]</td><td>row1[4]</td></tr>" > $DATA`;
