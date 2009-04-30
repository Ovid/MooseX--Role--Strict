package MooseX::Meta::Role::Strict;

use Moose;
extends 'Moose::Meta::Role';

sub apply {
    my ( $self, $other, @args ) = @_;

    ( blessed($other) )
      || Moose->throw_error("You must pass in an blessed instance");

    if ( $other->isa('Moose::Meta::Role') ) {
        require Moose::Meta::Role::Application::ToRole;
        return Moose::Meta::Role::Application::ToRole->new(@args)
          ->apply( $self, $other );
    }
    elsif ( $other->isa('Moose::Meta::Class') ) {
        require MooseX::Meta::Role::Application::ToClass::Strict;
        return MooseX::Meta::Role::Application::ToClass::Strict->new(@args)
          ->apply( $self, $other );
    }
    else {
        require Moose::Meta::Role::Application::ToInstance;
        return Moose::Meta::Role::Application::ToInstance->new(@args)
          ->apply( $self, $other );
    }
}

1;
