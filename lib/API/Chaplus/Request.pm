package API::Chaplus::Request;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use Mouse;
use Mouse::Util::TypeConstraints;

use overload (
    '""'  => sub { $_[0]->utterance() },
    '<=>' => sub { $_[0]->score <=> $_[1] },
);

use API::Chaplus::Request::AgentState;
use API::Chaplus::Request::Addition;
use URL::Encode qw(url_encode_utf8);

subtype 'Username' => as 'Str'   => where { /^[A-F0-9%]+$/ };
coerce 'Username'  => from 'Str' => via { url_encode_utf8($_) };
has username => ( is => 'rw', isa => 'Username', coerce => 1 );

subtype 'Utterance' => as 'Str' => where { /^[A-F0-9%]+$/ and length($_) > 0 }
=> message { "empty utterance was set" };
coerce 'Utterance' => from 'Str' => via { url_encode_utf8($_) };
has utterance => ( is => 'rw', isa => 'Utterance', required => 1, coerce => 1 );

subtype 'AgentState' => as 'HashRef';
coerce 'AgentState', from 'API::Chaplus::Request::AgentState', via {
    return { map { url_encode_utf8($_) } %$_ }
};
has agentState => ( is => 'rw', isa => 'AgentState', coerce => 1 );

subtype 'Addition' => as 'HashRef';
coerce 'Addition', from 'API::Chaplus::Request::Addition', via {
    return +{ map { url_encode_utf8($_) } %$_ }
};
has addition => ( is => 'rw', isa => 'Addition', coerce => 1 );

no Mouse;

1;
__END__



