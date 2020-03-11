package API::Chaplus::Options;

use 5.008001;
use Carp;

our $VERSION = "0.01";

use overload (
    '""'  => sub { $_[0]->suggest() },
    'cmp' => sub { $_[0]->suggest() cmp $_[1] },
);

use Mouse;

has suggest => ( is => 'ro', isa => 'Str' );

no Mouse;

1;
__END__



