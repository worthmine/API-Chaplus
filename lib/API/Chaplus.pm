package API::Chaplus;
use 5.008001;
use strict;
use warnings;
use Carp;

use Data::Dumper::AutoEncode qw(eDumper);
use JSON;
my $j = JSON->new()->utf8();

use URL::Encode qw(url_encode_utf8);
use Furl;
use HTTP::Request::JSON;
my $rj = HTTP::Request::JSON->new();

our $VERSION = "0.01";

sub new {
    my $class = shift;
    my $self  = bless {}, $class;
    my %attr  = @_;

    $self->{'apikey'} = $attr{'apikey'} || croak "missing param 'apikey'";
    $self->{'endPoint'} =
      'https://www.chaplus.jp/v1/chat?apikey=' . $attr{'apikey'};

    return $self;
}

sub request {
    my $self = shift;
    my %attr = map { url_encode_utf8 $_ } @_;
    croak "missing key utterance" unless $attr{'utterance'};

    my $params = $rj->json_content( \%attr );
    my $f      = Furl->new;
    my $req    = Furl::Request->new( 'POST', $self->{'endPoint'},
        { 'Content-Type' => 'application/json' }, $params );
    my ($res) = $f->request($req);

    if ( $res->{'code'} eq '200' ) {
        return $j->decode( $res->{'content'} )->{'bestResponse'}{'utterance'};
    }
    else {
        croak "something wrong to post by Furl" . eDumper($res);
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

API::Chaplus - It's API modile for Chaplus

=head1 SYNOPSIS

    use API::Chaplus;
    my $api    = API::Chaplus->new( apikey => 'your_key' );
    my $answer = $api->request( utterance => '調子どう？' );
    print $answer;    # お返事が表示される

=head1 DESCRIPTION

API::Chaplus is a test implement for Chaplus-API

=head1 SEE ALSO

=over

=item L<Botが雑談に応えられるようにするWEB APIを公開してみた話【個人開発】|https://qiita.com/maKunugi/items/b1afb6441571119729a7>

=item L<chaplus-api-doc|https://k-masashi.github.io/chaplus-api-doc/>

=back

=head1 LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

worthmine E<lt>worthmine@gmail.comE<gt>

=cut

