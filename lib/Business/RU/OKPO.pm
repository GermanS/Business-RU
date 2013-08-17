package Business::RU::OKPO;

use strict;
use warnings;

use Moose::Role;
requires 'okpo';

sub validate_okpo {
    my $self = shift;

    return;
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

my $decorator = myDecorator -> new( okpo => 123456789 );
if( $decorator -> validate_okpo() ) {
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