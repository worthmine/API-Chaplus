package API::Chaplus::Response;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use Mouse;

has utterance => ( is => 'ro', isa => 'Str' );
has score     => ( is => 'ro', isa => 'Num' );
has url       => ( is => 'ro', isa => 'Str' );

no Mouse;

1;
__END__



