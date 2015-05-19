#!/usr/bin/perl

use strict;
use warnings;
use lib::Disque;

my $disque = Disque->new(servers => ["localhost:7711", "localhost:7712"]);

while (1) {
    my @jobs = $disque->get_job("test");
    foreach (@jobs) {
        my $queue = @{$_}[0];
        my $job_id = @{$_}[1];
        my $job = @{$_}[2];
        warn "Received job: '$job' $!at queue: '$queue' $!\n";
        $disque->ack_job($job_id);
    }
}

$disque->quit();
