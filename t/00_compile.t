use strict;
use Test::More 0.98;
use Test::More::UTF8;

use lib 'lib';
use_ok 'API::Chaplus';    # 01

my $api = new_ok( 'API::Chaplus', [ apikey => '5e66db56cfd39' ] );    # 02
my $que = $api->request( utterance => '調子どう？' );
is exists $que->{'bestResponse'}{'utterance'}, 1,                     # 03
  "succeed to send a request";

$que = $api->bestResponse( utterance => 'ありがとう' );
is ref($que), 'API::Chaplus::Response', "succeed to get Responce object";   # 04
is exists $que->{'utterance'}, 1, "succeed to get bestResponse";            # 05
note $que;

my @ques = $api->Responses( utterance => 'ありがとう' );
is ref( $ques[0] ), 'API::Chaplus::Response',
  "succeed to get Responce object";                                         # 06
is exists $ques[0]->{'utterance'}, 1, "succeed to get Responses";           # 07

done_testing;

