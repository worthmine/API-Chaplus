package API::Chaplus::Request::AgentState;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use Mouse;
use Mouse::Util::TypeConstraints;

use overload (
    '""'  => sub { $_[0]->agentName() },
    'cmp' => sub { $_[0]->age() cmp $_[1] },
);

has agentName => ( is => 'rw', isa => 'Str' );
enum 'Tone'   => qw( normal kansai koshu dechu );
has tone      => ( is => 'rw', isa => 'Tone' );
has age       => ( is => 'rw', isa => 'Str' );

no Mouse;

1;
__END__

{
    "addition":{
    "ngwords":["%E3%81%86%E3%82%93%E3%81%A1"],
    "options":"%E3%83%9C%E3%83%B3%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%EF%BC%81",
    "utterancePairs":[{
        "response":"%E3%83%81%E3%83%A3%E3%82%AA%EF%BC%81",
        "utterance":"%E3%83%81%E3%83%A3%E3%82%AA%EF%BC%81"}]
        },
    "agentState":{
        "age":"14%E6%AD%B3",
        "agentName":"%E8%8C%B6%E5%A4%AA%E9%83%8E",
        "tone":"normal"
    },
    "username":"%E8%8A%B1%E5%AD%90",
    "utterance":"%E3%83%81%E3%83%A3%E3%82%AA%EF%BC%81"
}',


