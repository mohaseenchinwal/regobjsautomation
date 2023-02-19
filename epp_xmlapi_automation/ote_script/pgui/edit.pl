$ cat > pm_vi_from_perl.txt
Line 1
Line 2
Line 3
ken@ganymede: ~/tmp
$ perl -Mstrict -Mwarnings -e 'my $f = q{./pm_vi_from_perl.txt}; system(vi => $f);'
ken@ganymede: ~/tmp
$ cat pm_vi_from_perl.txt
Line 1
Added after system() called
Line 2
Here also: Added after system() called
Line 3
ken@ganymede: ~/tmp
$ 
