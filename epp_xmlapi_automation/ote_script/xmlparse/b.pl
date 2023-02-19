  use XML::Simple;
  my $config = XMLin(b.xml);
  use Data::Dumper;
  print Dumper($config);

print $config->{response}->{resData}->{"domain:infData"}->{"domain:registrant"};
print $config->{response}->{resData}->{"domain:infData"}->{"domain:name"};


print $config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[0]->{type};
print $config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[0]->{content};



print $config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[1]->{type};
print $config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[1]->{content};


print $config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[2]->{type};
print $config->{response}->{resData}->{"domain:infData"}->{"domain:contact"}->[2]->{content};

