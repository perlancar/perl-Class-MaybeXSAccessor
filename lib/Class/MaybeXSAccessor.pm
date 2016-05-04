package Class::MaybeXSAccessor;

# DATE
# VERSION

use 5.010001;
use strict 'subs', 'vars';
use warnings;

our $_target_spec;

sub import {
    my $pkg = shift;
    my $spec = shift;

    my $caller = caller();

    if (eval { require Class::XSAccessor; 1 }) {
        $_target_spec = {
            constructor => 'new',
            accessors => { map { $_ => $_ } @{ $spec->{accessors} // [] } },
        };
        eval "package $caller; Class::XSAccessor->import(\$Class::MaybeXSAccessor::_target_spec);";
        die if $@;
    } else {
        require Class::Accessor;
        push @{"$caller\::ISA"}, "Class::Accessor";
        $caller->_mk_accessors('rw', @{ $spec->{accessors} });
    }
}

1;
# ABSTRACT: Generate accessors/constructor

=for Pod::Coverage .+

=head1 SYNOPSIS

In F<lib/Your/Class.pm>:

 package Your::Class;
 use Class::MaybeXSAccessor {
     accessors => [qw/foo bar/],
 };

In code that uses your class:

 use Your::Class;

 my $obj = Your::Class->new;
 $obj->foo(1980);
 $obj->bar(12);


=head1 DESCRIPTION

B<EARLY, EXPERIMENTAL>.

This module can be used to generate accessors/constructor. It will use
L<Class::XSAccessor> if available, falling back to L<Class::Accessor>. Note that
not all features from Class::Accessor nor Class::XSAccessor are supported.


=head1 SEE ALSO

L<Class::Accessor>

L<Class::XSAccessor>

L<Class::MaybeXSAccessor::Array>
