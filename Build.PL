use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'MooseX::Role::Strict',
    license           => 'perl',
    dist_author       => 'Curtis "Ovid" Poe <ovid@cpan.org>',
    dist_version_from => 'lib/MooseX/Role/Strict.pm',
    build_requires    => { 
        'Test::Most' => 0.21,
    },
    requires          => {
        'Moose' => 0.75,    # for --metaclass
    },
    add_to_cleanup     => ['MooseX-Role-Strict-*'],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
