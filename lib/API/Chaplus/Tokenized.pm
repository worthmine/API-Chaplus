package API::Chaplus::Tokenized;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use overload (
    '""'  => sub { $_[0]->token() },
    'cmp' => sub { $_[0]->token() cmp $_[1] },
);

use Mouse;

has token => ( is => 'ro', isa => 'Str' );

no Mouse;

1;
__END__



