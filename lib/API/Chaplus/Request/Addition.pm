package API::Chaplus::Request::Addition;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use URL::Encode qw(url_encode);
use URI::Encode;

use Mouse;
use Mouse::Util::TypeConstraints;

use API::Chaplus::UtterancePair;

subtype 'Options' => as 'ArrayRef[Str]';
coerce 'Options', from 'Str', via { [$_] };
has options => ( is => 'rw', isa => 'Options', coerce => 1 );

subtype 'UtterancePairs' => as 'ArrayRef[API::Chaplus::UtterancePair]';
coerce 'UtterancePairs', from 'API::Chaplus::UtterancePair', via { [$_] };
has utterancePairs => ( is => 'rw', isa => 'UtterancePairs', coerce => 1 );

subtype 'Ngwords' => as 'ArrayRef[Str]';
coerce 'Ngwords', from 'Str', via { [$_] };
has ngwords => ( is => 'rw', isa => 'Ngwords', coerce => 1 );

no Mouse;

sub serialize {
    my $self = shift;
    {
        options => [ map { url_encode $_ } @{ $self->options() } ],
        utterancePairs =>
          [ map { $_->serialize() } @{ $self->utterancePairs() } ],
        ngwords => [ map { url_encode $_ } @{ $self->ngwords() } ],
    };
}

1;
__END__
