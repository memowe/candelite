#!/usr/bin/env perl

use Mojo::Base -strict, -signatures;

use Test::More;
use Test::Mojo;
use FindBin;

# Neccessary to load versions from modules
use Mojo::Loader 'load_class';
use lib map "$FindBin::Bin/../$_" => qw(lib viralgiral/lib);

# Prepare tester
$ENV{MOJO_LOG_LEVEL} = 'fatal';
require "$FindBin::Bin/../candelite";
my $t = Test::Mojo->new;

subtest Versions => sub {
    $t->get_ok('/__versions__')->status_is(200);
    
    subtest Perl => sub {
        $t->element_exists('#perl-version');
        $t->text_is('#perl-version' => "perl version: $^V");
    };

    subtest Modules => sub {
        my @modules     = qw(Mojolicious EventStore::Tiny ViralGiral Candelite);
        my $mod_rows    = $t->tx->res->dom('#module-versions tbody tr');
        is $mod_rows->size => scalar(@modules),
            'Correct module version row count';

        for my $mod (sort @modules) { subtest $mod => sub {
            my $row = $mod_rows->first(sub {$_->at('th')->text eq $mod});
            ok defined($row) => "Correct row found";
            load_class $mod;
            is $row->at('td')->text => eval('$' . $mod . '::VERSION') =>
                "Correct version displayed";
        }}
    };
};

done_testing;
