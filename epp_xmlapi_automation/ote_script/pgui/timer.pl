    use Time::Stopwatch;
    tie my $timer, 'Time::Stopwatch';

   
    print "Did something in $timer seconds.\n";

  #  my @times = map {
  #      $timer = 0;
  #      $timer;
  #  } 1 .. 5;
