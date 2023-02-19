#!/usr/bin/perl --
use strict;
use warnings;
use Tk qw' tkinit ';

Main( @ARGV );
exit( 0 );

sub Main {
    my $mw = tkinit;
    MakeStuff( $mw, 3 );
    $mw->MainLoop;
}

sub MakeStuff {
    my( $w, $howmany ) = @_;
    for my $n ( 1 .. $howmany ){
        MakeOne( $w, $n );
    }
}
sub MakeOne {
    my( $w, $text )= @_;
    $w->Button( -text => $text )->pack;
}
