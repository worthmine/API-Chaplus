package API::Chaplus::Request::AgentState;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use Mouse;
use Mouse::Util::TypeConstraints;

use overload (
    '""'  => sub { $_[0]->agentName() },
    'cmp' => sub { $_[0]->age() cmp $_[1] },
);

has agentName => ( is => 'rw', isa => 'Str' );
enum 'Tone'   => qw( normal kansai koshu dechu );
has tone      => ( is => 'rw', isa => 'Tone' );
has age       => ( is => 'rw', isa => 'Str' );

no Mouse;

1;
__END__
