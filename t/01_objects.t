use strict;
use Test::More 0.98 tests => 10;
use Test::More::UTF8;

use Encode qw(decode_utf8);
use Data::Dumper::AutoEncode qw(eDumper);

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
        options        => ['ボンジュール！'],
        utterancePairs => [$pair],
        ngwords        => [qw(うんち)],
    ]
);

$addition = new_ok(       # 07
    'API::Chaplus::Request::Addition',
    [
        options        => 'ボンジュール！',
        utterancePairs => $pair,
        ngwords        => 'うんち',
    ]
);

my $state = new_ok(       # 08
    'API::Chaplus::Request::AgentState',
    [
        agentName => '茶太郎',
        tone      => 'normal',
        age       => '14歳',
    ]
);

my $req =
  new_ok( 'API::Chaplus::Request', [ utterance => 'こんにちわ' ] );    # 09
my $que = $api->request($req);

#note decode_utf8 eDumper $que;

$req = new_ok(                                                              # 10
    'API::Chaplus::Request',
    [
        username   => '花子',
        utterance  => 'チャオ！',
        agentState => $state,
        addition   => $addition,
    ]
);

note $req;

#=cut

$que = $api->request($req);

#note decode_utf8 eDumper $que;

done_testing;
