package Class::MaybeXSAccessor;

1;
# ABSTRACT: Generate accessors/constructor

=for Pod::Coverage .+

=head1 SYNOPSIS

In F<lib/Your/Class.pm>:

 package Your::Class;
 use Class::MaybeXSAccessor;

 has foo => (is => 'rw');
 has bar => (is => 'rw');

In code that uses your class:

 use Your::Class;

 my $obj = Your::Class->new;
 $obj->foo(1980);
 $obj->bar(12);


=head1 DESCRIPTION

This module can be used to generate accessors/constructor. It will use
L<Class::XSAccessor> if available, falling back to L<Class::Accessor::Array>.

Please make sure that you only use the features that both class support.


=head1 SEE ALSO

L<Class::Accessor>

L<Class::XSAccessor>
