use v5.20.0;

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Candelite',
    AUTHOR              => 'Mirko Westermeier <mirko@westermeier.de>',
    VERSION_FROM        => 'lib/Candelite.pm',
    LICENSE             => 'mit',
    MIN_PERL_VERSION    => '5.20.0',
    PREREQ_PM           => {
        'Mojolicious'       => '7.93',
        'EventStore::Tiny'  => '0.6',
    },
    META_MERGE          => {resources => {
        bugtracker => 'http://github.com/memowe/candelite/issues',
        repository => 'http://github.com/memowe/candelite',
    }},
    test                => {TESTS => 't/*.t t/*/*.t'}
);
