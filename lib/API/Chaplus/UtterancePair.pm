package API::Chaplus::UtterancePair;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use URL::Encode qw(url_encode);

use Mouse;
use Mouse::Util::TypeConstraints;

has utterance => ( is => 'rw', isa => 'Str', required => 1 );
has response  => ( is => 'rw', isa => 'Str', required => 1 );

no Mouse;

sub serialize {
    my $self = shift;
    {
        utterance => url_encode( $self->utterance() ),
        response  => url_encode( $self->response() ),
    };
}

1;
__END__



