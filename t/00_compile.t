use strict;
use Test::More 0.98;
use Test::More::UTF8;

use lib 'lib';
use_ok $_ for qw(
  API::Chaplus
);

my $api    = API::Chaplus->new( apikey => '5e66db56cfd39' );
my $answer = $api->request( utterance => '調子どう？' );

note $answer;

done_testing;

