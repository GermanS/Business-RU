package Business::RU::INN;

use strict;
use warnings;

use Moose::Role;
requires 'inn';

sub validate_inn {
    my $self = shift;

    return $self -> _validate_inn_10()
        if length $self -> inn() == 10;

    return $self -> _validate_inn_12()
        if length $self -> inn() == 12;

    return;
}

sub _validate_inn_10 {
    my $self = shift;

    my @weights = qw(2 4 10 3 5 9 4 6 8 0);

    my $result = 0;
    for (my $i = 0; $i < 10; $i++) {
        $result += substr( $self -> inn(), $i, 1 ) * $weights[ $i ];
    }

    return
        substr( $self -> inn(), 9, 1 ) == ($result % 11 % 10);
}


sub _validate_inn_12 {
    my $self = shift;

    my @weights = qw(3 7 2 4 10 3 5 9 4 6 8 0);

    my $result_11 = 0;
    for (my $i = 0; $i < 11; $i++) {
        $result_11 += substr( $self -> inn(), $i, 1 ) * $weights[ $i + 1 ];
    }

    my $result_12 = 0;
    for (my $i = 0;  $i < 12; $i++) {
        $result_12 += substr( $self -> inn(), $i, 1 ) * $weights[ $i ];
    }

    return
        substr( $self -> inn(), 10, 1 ) == ( $result_11 % 11 % 10 ) &&
        substr( $self -> inn(), 11, 1 ) == ( $result_12 % 11 % 10 );
}

1;

__END__

=head1 NAME

Business::RU::INN

=head1 SYSNOPSIS

package myDecorator;
use Moose;
has 'inn' => ( is => 'ro', isa => 'Int' );
with 'Business::RU::INN';

...

my $decorator = myDecorator -> new( inn => 123456789 );
if( $decorator -> validate_inn() ) {
    ... success ...
} else {
    ... process error ...
}

=head1 DESCRIPTION

=head1 METHODS

=head2 validate_inn()

Validate INN. 
return true if INN valid

=head2 _validate_inn_10()

Validate short INN. Internal method.

=head2 _validate_inn_12()

Validate long INN. Internal method.

=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut