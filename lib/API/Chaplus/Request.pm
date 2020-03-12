package API::Chaplus::Request;
use 5.008001;
use Carp;

our $VERSION = "0.01";

use Mouse;
use Mouse::Util::TypeConstraints;

use API::Chaplus::Request::AgentState;
use API::Chaplus::Request::Addition;
use URL::Encode qw(url_encode_utf8 url_decode_utf8);

use overload (
    '""'  => sub { url_decode_utf8 $_[0]->utterance() },
    '<=>' => sub { $_[0]->score <=> $_[1] },
);

has username => ( is => 'rw', isa => 'Encoded', coerce => 1 );

subtype 'Utterance' => as 'Encoded' =>
  where { /^[A-F0-9%]+$/ and length($_) > 0 }
=> message { "empty utterance was set" };
coerce 'Utterance' => from 'Str' => via { url_encode_utf8($_) };
has utterance => ( is => 'rw', isa => 'Utterance', required => 1, coerce => 1 );

subtype 'AgentState' => as 'HashRef';
coerce 'AgentState', from 'API::Chaplus::Request::AgentState',
  via { API::Chaplus::Request::Addition::serialize($_) };
has agentState => ( is => 'rw', isa => 'AgentState', coerce => 1 );

subtype 'Addition' => as 'HashRef';
coerce 'Addition', from 'API::Chaplus::Request::Addition', via {
    return +{%$_}
};
has addition => ( is => 'rw', isa => 'Addition', coerce => 1 );

no Mouse;

1;
__END__

=encoding utf-8

=head1 NAME

API::Chaplus::Request - objectifier for Requests 

=head1 SYNOPSIS

    use API::Chaplus::Request;
    my $pair = API::Chaplus::UtterancePair->new(
        utterance => '肩凝った', 
        response => '適度に運動しないとね',
    );

    my $addition = API::Chaplus::Request::Addition->new(       
        options        => [qw(疲れた 肩凝った)],
        utterancePairs => $pair,                    # auto optimize to [$pair] by Mouse Coercion
        ngwords        => [ "ため息", "やめてしまえ" ],
    );
    
    my $state = API::Chaplus::Request::AgentState->new(
        agentName => 'エージェント',
        tone      => 'kansai',
        age       => '14歳',
    );

    my $req =  use API::Chaplus::Request->new(
        username   => '太郎',
        utterance  => '調子はどう？',
        agentState => $state,
        addition   => $addition,
    );
    my $api    = API::Chaplus->new( apikey => 'your_key' );
    my $answer = $api->bestResponse($req);
    print $answer;    # お返事が表示される

=head1 DESCRIPTION

API::Chaplus::Request provides you objectified attributes for API::Chaplus; 

=head2 CONSTRUCTOR

=head3 new()

Attribute 'utterance' is required. 
Any other attributes are optional

=head2 METHODS

=head3 username(I<name>)
accepts/returns the name 

=head3 utterance(I<utterance>)

accepts/returns the utterance 

=head3 agentState(I<agentState object>)

accepts/returns 'agentState' Object 

=head3 addition(I<addition object>)

accepts/returns 'addition' Object 

=head1 SEE ALSO

=over

=item L<chaplus-api-doc|https://k-masashi.github.io/chaplus-api-doc/>

=item L<API::Chaplus|https://github.com/worthmine/API-Chaplus>

=back

=head1 LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

worthmine E<lt>worthmine@gmail.comE<gt>

=cut


