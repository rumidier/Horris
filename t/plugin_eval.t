#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Horris::Connection;
use Test::More (tests => 1);

my @TEST_MESSAGE = (
	#'eval: print 1 .. 10;', 
	'eval: print 나는미남;', 
);

my $a = '12345678910';

my $conn = Horris::Connection->new(
	nickname => '', 
	port     => '', 
	password => '', 
	server   => '', 
	username => '', 
	plugins	 => ['Eval'], 
);

for my $msg (@TEST_MESSAGE) {
    my $message = Horris::Message->new(
        channel => '#test', # not used, but required for L<Horris::Connection>
        message => $msg, 
        from	=> 'test',  # not used, but required for L<Horris::Connection>
    );

    foreach my $plugin (@{ $conn->plugin_list }) {
        my $msg = $plugin->_eval($message) if $plugin->can('_eval');
        #is ($msg, '12345678910', 'correct stdout');
        is ($msg, '나는미남', 'correct stdout - unicode');
    }
}


