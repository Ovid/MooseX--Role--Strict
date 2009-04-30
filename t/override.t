#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most 'no_plan', 'die';
use lib 'lib';

{

    package My::Role::Example;
    use MooseX::Role::Strict;

    sub munge { 'munge role' }
}

isa_ok +My::Role::Example->meta, 'MooseX::Meta::Role::Strict';

eval <<'END_EVAL';
package Foo;
use Moose;
with 'My::Role::Example';
sub munge { 'munge foo' }
END_EVAL

my $error = $@;
like $error, qr/\QThe class Foo has implicitly overridden the method (munge)/,
  'Implicitly overridding methods should be fatal';
show $error;

eval <<'END_EVAL';
package Bar;
use Moose;
with 'My::Role::Example' => { excludes => ['munge'] };
sub munge { 'munge bar' }
END_EVAL

$error = $@;
ok !$error, '... but explicitly exluding the conflicting errors should be fine';
is Bar->munge, 'munge bar', '... and the correct method should be available';
