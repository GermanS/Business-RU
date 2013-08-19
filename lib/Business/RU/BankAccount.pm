package Business::RU::BankAccount;

use strict;
use warnings;

use Moose::Role;
requires 'current_account',
         'correspondent_account',
         'bic';

sub validate_current_account {
    my $self = shift;

    return $self -> _validate_account(
        sprintf "%s%s", substr( $self -> bic(), 6, 3 ), $self -> current_account()
    );
}

sub validate_correspondent_account {
    my $self = shift;    

    return $self -> _validate_account(
        sprintf "0%s%s", substr( $self -> bic(), 4, 2), $self -> correspondent_account()
    );
}

sub _validate_account {
    my ($self, $account) = @_;

    my @weights = qw(7 1 3 7 1 3 7 1 3 7 1 3 7 1 3 7 1 3 7 1 3 7 1);
    my $result = 0;
    for ( my $i = 0; $i < 23; $i++ ) {
        $result += substr( $account, $i, 1 ) * $weights[$i];
    }

    return $result % 10 == 0;
}

sub validate_bic {
    my $self = shift;

    return 
        length( $self -> bic()) == 9  &&  
        $self -> bic() =~ /^04/ &&
        $self -> bic() !~ /00[3-9]$|0[1-4]\d$/;
}

1;

__END__

=head1 NAME

Business::RU::BankAccount

=head1 SYNOPSIS

package myDecorator;
use Moose;
has 'current_account' => ( is => 'ro', isa => 'Int' );
has 'correspondent_account' => ( is => 'ro', isa => 'Int' );
has 'bic' => ( is => 'ro', isa => 'Int' );
with 'Business::RU::BankAccount';

...

my $decorator = myDecorator  ->  new( 
    current_account => $current_account,
    correspondents_account => $correspondent_account,
    bic => $bic,    
);
if( $decorator -> validate_bic() &&
    $decorator -> validate_current_account() &&
    $decorator -> validate_correspondent_account() ) {
    ... success ...
} else {
    ... process error ...
}

=head1 DESCRIPTION

Validate bank account details - current and correspondent accounts.

=head1 METHODS

=head2 validate_current_account()

=head2 validate_correspondent_account()

=head2 validate_bic()

=head2 _validate_account()

Calculate bank accont check sum.
Internal method.

=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut