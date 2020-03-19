use strict;
use Test::More 0.98 tests => 13;

use Test::More::UTF8 qw(-utf8);
use Data::Dumper::AutoEncode qw(Dumper eDumper);
use Encode qw(decode_utf8 encode_utf8);

use lib 'lib';
use_ok 'API::Chaplus';    # 01

my $api = new_ok( 'API::Chaplus', [ apikey => '5e66db56cfd39' ] );    # 02
my $que = $api->request( utterance => '調子どう？' );
isnt $que, undef, "succeed to send a request";                        # 03
is exists $que->{'bestResponse'}, 1, "bestResponse exists";           # 04
is exists $que->{'responses'},    1, "responses exist";               # 05
is exists $que->{'tokenized'},    1, "tokenized exist";               # 06
is exists $que->{'options'},      1, "options exist";                 # 07

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

@ques = $api->options( utterance => 'ふむふむ' );
is ref( $ques[0] ), 'API::Chaplus::Options',                                # 13
  "succeed to get tokenized object";

done_testing;

