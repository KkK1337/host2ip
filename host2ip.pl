#!/usr/bin/perl -w
# host2ip.pl translates a hostname to the corresponding
# IP address. The subroutine host2ip() is invoked with a
# hostname as the only mandatory argument and returns the 
# corresponding IP address.
#
# Copyright 2003, Ramiro Gómez.
#
# This program is free software; you can redistribute
# it and/or modify it under the same terms as Perl itself.
use strict;
use warnings;
use Socket;
use LWP::UserAgent;
use HTTP::Request::Common;

# die if no argument was given
# die "Usage: $0 hostname\n" unless @ARGV;


my $filename = 'list.txt';
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";
 
while (my $row = <$fh>) {
  chomp $row;
  print "\n";
  $ARGV[0] = $row;
  
  
  my $website1 = $ARGV[0];
  my $ip = host2ip( shift );
  print "http://$website1 >> $ip";
  open(BEN,">>ips.txt");
  print BEN "$ip\n";
  close(BEN);

sub host2ip {
    my $host2ip = shift;
    my $packed_addr = gethostbyname( $host2ip );
    
    die "Hostname $host2ip doesn't exist.\n" unless $packed_addr;
    
    return inet_ntoa( $packed_addr );
}
}
