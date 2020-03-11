package API::Chaplus::Request::Addition;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use Mouse;
use Mouse::Util::TypeConstraints;

use API::Chaplus::UtterancePair;
use URL::Encode qw(url_encode_utf8);

subtype 'NotEncoded' => as 'Str' => where { $_ !~ /^[A-F0-9%]+$/ };
subtype 'Encoded'    => as 'Str' => where { /^[A-F0-9%]+$/ };
coerce 'Encoded' => from 'NotEncoded' => via { url_encode_utf8($_) };

subtype 'Options' => as 'ArrayRef[Encoded]';
coerce 'Options', from 'ArrayRef[NotEncoded]', via {
    [ map { url_encode_utf8($_) } @$_ ]
}, from 'NotEncoded', via { [ url_encode_utf8($_) ] };
has options => ( is => 'rw', isa => 'Options', coerce => 1 );

subtype 'UtterancePairs' => as 'ArrayRef[HashRef]';
coerce 'UtterancePairs', from 'ArrayRef[API::Chaplus::UtterancePair]', via {
    [ map { serialize($_) } @$_ ];
}, from 'API::Chaplus::UtterancePair', via { [ serialize($_) ] };
has utterancePairs => ( is => 'rw', isa => 'UtterancePairs', coerce => 1 );

subtype 'Ngwords' => as 'ArrayRef[Encoded]';
coerce 'Ngwords', from 'ArrayRef[NotEncoded]', via {
    return [ map { url_encode_utf8($_) } @$_ ]
}, from 'NotEncoded', via { [ url_encode_utf8($_) ] };
has ngwords => ( is => 'rw', isa => 'Ngwords', coerce => 1 );

no Mouse;

sub serialize {
    my $obj   = shift;
    my $pairs = {};
    while ( my ( $key, $value ) = each %$obj ) {
        $pairs->{$key} = url_encode_utf8($value);
    }
    return $pairs;
}

1;
__END__



