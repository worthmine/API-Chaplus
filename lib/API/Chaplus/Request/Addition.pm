package API::Chaplus::Request::Addition;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use Mouse;
use Mouse::Util::TypeConstraints;

use API::Chaplus::UtterancePair;
use URL::Encode qw(url_encode_utf8);

subtype 'Options' => as 'Maybe[Encoded]';
coerce 'Options', from 'NotEncoded', via { url_encode_utf8($_) };
has options => ( is => 'rw', isa => 'Options', coerce => 1 );

#subtype 'UtterancePairs' => as 'ArrayRef[Encoded]';
#coerce 'UtterancePairs', from 'API::Chaplus::UtterancePair', via {
#    return [ +{%$_} ]
#}, from 'ArrayRef[API::Chaplus::UtterancePair]', via {
#    return [
#        map {
#            map { url_encode_utf8($_) } %$_
#        } @$_
#    ]
#};
#has utterancePairs => ( is => 'rw', isa => 'UtterancePairs', coerce => 1 );

has utterancePairs =>
  ( is => 'rw', isa => 'ArrayRef[API::Chaplus::UtterancePair]' );

subtype 'Ngwords' => as 'ArrayRef[Encoded]';
coerce 'Ngwords', from 'ArrayRef[NotEncoded]', via {
    return [ map { url_encode_utf8($_) } @$_ ]
};
has ngwords => ( is => 'rw', isa => 'Ngwords', coerce => 1 );

no Mouse;

1;
__END__



