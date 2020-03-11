package API::Chaplus::UtterancePair;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use Mouse;
use Mouse::Util::TypeConstraints;
use URL::Encode qw(url_encode_utf8);

subtype 'Encoded' => as 'Str'   => where { /^[A-F0-9%]+$/ };
coerce 'Encoded'  => from 'Str' => via { url_encode_utf8($_) };

has utterance => ( is => 'rw', isa => 'Encoded', required => 1, coerce => 1 );
has response  => ( is => 'rw', isa => 'Encoded', required => 1, coerce => 1 );

no Mouse;

1;
__END__



