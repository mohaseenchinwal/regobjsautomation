# script
use strict;
use XML::Twig;

my $file = $ARGV[0];

my $twig = XML::Twig->new();

$twig->parsefile($file);

my $root = $twig->root;

foreach my $acl ($root->children('ACL')){
    print $acl->att('id');
    print "\n";
    print $acl->first_child('USERNAME');
    print "\n";
    print $acl->first_child('HOST');
    print "\n";
    print $acl->first_child('PERMISSION');
    print "\n";
}
