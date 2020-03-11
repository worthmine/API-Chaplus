package API::Chaplus::UtterancePair;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use Mouse;

has utterance => ( is => 'rw', isa => 'Str', required => 1 );
has response  => ( is => 'rw', isa => 'Str', required => 1 );

no Mouse;

1;
__END__



