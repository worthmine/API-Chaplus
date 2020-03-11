package API::Chaplus::Request::Addition;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use Mouse;
use Mouse::Util::TypeConstraints;

use API::Chaplus::UtterancePair;
use URL::Encode qw(url_encode_utf8);

has options => ( is => 'rw', isa => 'Maybe[Str]' );

#subtype 'UtterancePairs' => as 'ArrayRef';
#coerce 'UtterancePairs', from 'API::Chaplus::UtterancePair', via {
#    return [ +{ map { url_encode_utf8($_) } %$_ } ]
#}, from 'ArrayRef[API::Chaplus::UtterancePair]', via {
#    return [
#        map {
#            +{ map { url_encode_utf8($_) } %$_ }
#        } @$_[0]
#    ]
#};
#has utterancePairs => ( is => 'rw', isa => 'UtterancePairs', coerce => 1 );
has utterancePairs => ( is => 'rw', isa => 'API::Chaplus::UtterancePair' );

#subtype 'Ngwords' => as 'ArrayRef';
#coerce 'Ngwords', from 'ArrayRef[Str]', via {
#    return [ { map { url_encode_utf8($_) } @$_ } ]
#};
#has ngwords => ( is => 'rw', isa => 'Ngwords', coerce => 1 );
has ngwords => ( is => 'rw', isa => 'ArrayRef' );

no Mouse;

1;
__END__



