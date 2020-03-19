package API::Chaplus::Request::AgentState;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use URL::Encode qw(url_encode);

use Mouse;
use Mouse::Util::TypeConstraints;

has agentName => ( is => 'rw', isa => 'Str' );
enum 'Tone'   => [qw( normal kansai koshu dechu )];
has tone      => ( is => 'rw', isa => 'Tone' );
has age       => ( is => 'rw', isa => 'Str' );

no Mouse;

sub serialize {
    my $self = shift;
    {
        agentName => url_encode( $self->agentName() ),
        tone      => $self->tone(),
        age       => url_encode( $self->age() ),
    };
}

1;
__END__
