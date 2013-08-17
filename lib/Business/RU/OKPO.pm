package Business::RU::OKPO;

use strict;
use warnings;

use Moose::Role;
requires 'okpo';

sub validate_okpo {
   my $self = shift;

   return unless $self -> okpo();

    my $result1 = 0;
    my $result2 = 0;
    for ( my $i = 0; $i < length( $self -> okpo() ) - 1; $i ++ ) {
        $result1 += substr( $self -> okpo(), $i, 1) * ( ( $i + 1 ) % 11 );
        $result2 += substr( $self -> okpo(), $i, 1) * ( ( $i + 3 ) % 11 );
    }

    return 
        ( ( $result1 % 11 ) > 9 )
            ? substr( $self -> okpo(), length( $self -> okpo() ) - 1, 1 ) == $result2 % 11 % 10
            : substr( $self -> okpo(), length( $self -> okpo() ) - 1, 1 ) == $result1 % 11;
}

1;

__END__

=head1 NAME

Business::RU::OKPO

=head1 SYNOPSIS

package myDecorator;
use Moose;
has 'okpo' => ( is => 'ro', isa => 'Int' );
with 'Business::RU::OKPO';

my $decorator = myDecorator  ->  new( okpo => 123456789 );
if( $decorator  ->  validate_okpo() ) {
    ... success ...
} else {
    ... process error ...
}

=head1 METHODS

=head2 validate_okpo()

Validate OKPO.
Return true if OKPO valid.

=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut