use strict;
use Test::More 0.98;
use Test::More::UTF8;

use lib 'lib';
use API::Chaplus;
my $api = API::Chaplus->new( apikey => '5e66db56cfd39' );

use_ok $_ for qw(
  API::Chaplus::UtterancePair
  API::Chaplus::Request::Addition
  API::Chaplus::Request::AgentState
  API::Chaplus::Request
  );    # 01-04

my $pair = new_ok(    # 05
    'API::Chaplus::UtterancePair',
    [ utterance => 'チャオ！', response => 'チャオ！' ]
);

my $addition = new_ok(    # 06
    'API::Chaplus::Request::Addition',
    [
        options        => 'ボンジュール！',
        utterancePairs => [$pair],
        ngwords        => [qw(うんち)],
    ]
);
my $state = new_ok(       # 07
    'API::Chaplus::Request::AgentState',
    [
        agentName => '茶太郎',
        tone      => 'normal',
        age       => '14歳',
    ]
);

my $req =
  new_ok( 'API::Chaplus::Request', [ utterance => 'こんにちわ' ] );    # 08

$req = new_ok(                                                              # 09
    'API::Chaplus::Request',
    [
        username   => '花子',
        utterance  => 'チャオ！',
        agentState => $state,
        addition   => \%$addition,
    ]
);

#eval { $req = API::Chaplus::Request->new( utterance => '' ) };
#is $@, undef, "succeed to reject empty utterance ";

my $que = $api->bestResponse($req);

done_testing;

__END__

$que = $api->bestResponse( utterance => 'ありがとう' );
is ref($que), 'API::Chaplus::Response', "succeed to get Responce object";   # 08
is exists $que->{'utterance'}, 1, "succeed to get bestResponse";            # 09

my @ques = $api->responses( utterance => 'それでそれで？' );
is ref( $ques[0] ), 'API::Chaplus::Response',                               # 10
  "succeed to get Responce object";
is exists $ques[0]->{'utterance'}, 1, "succeed to get Responses";           # 11

@ques = $api->tokenized( utterance => '仕事終わりのビールは最高' );
is ref( $ques[0] ), 'API::Chaplus::Tokenized',                              # 12
  "succeed to get tokenized object";

#note $_ for @ques;

@ques = $api->options( utterance => 'ふむふむ' );
is ref( $ques[0] ), 'API::Chaplus::Options',                                # 13
  "succeed to get tokenized object";

#note $_ for @ques;


