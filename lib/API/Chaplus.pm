package API::Chaplus;
use 5.008001;
use strict;
use warnings;
use Carp;

use Encode qw(encode_utf8 decode_utf8);
use URL::Encode qw(url_encode url_decode);
use Data::Dumper::AutoEncode qw(eDumper);

use JSON;
my $j = JSON->new();

use Furl;
my $f = Furl->new;

use HTTP::Request::JSON;
my $rj = HTTP::Request::JSON->new();

use API::Chaplus::Response;
use API::Chaplus::Tokenized;
use API::Chaplus::Options;

our $VERSION = "0.01";

=encoding utf-8

=head1 NAME

API::Chaplus - It's an API module for L<Chaplus|https://www.chaplus.jp/> with perl

=head1 SYNOPSIS

    use API::Chaplus;
    my $api    = API::Chaplus->new( apikey => 'your_key' );
    my $answer = $api->bestResponse( utterance => '調子どう？' );
    print $answer;    # お返事が表示される

=head1 DESCRIPTION

API::Chaplus is a test implement for L<Chaplus-API|https://k-masashi.github.io/chaplus-api-doc/>

=head2 CONSTRUCTOR

=head3 new( apikey => YOUR_KEY )

attribute 'apikey' is required

=cut

sub new {
    my $class = shift;
    my $self  = bless {}, $class;
    my %attr  = @_;

    $self->{'apikey'} = $attr{'apikey'} || croak "missing param 'apikey'";
    $self->{'endPoint'} =
      'https://www.chaplus.jp/v1/chat?apikey=' . $attr{'apikey'};

    return $self;
}

=head2 METHODS

=head3 request( utterance => '日本語で話しかけよう', ... )

attribute 'utterance' is required

returns Perl hash decoded from JSON 

=cut 

sub request {
    my $self = shift;
    my %attr = ();
    if ( @_ > 1 ) {
        %attr = map { decode_utf8 $_ } @_;
        croak "missing key utterance" unless $attr{'utterance'};
    }
    elsif ( ref $_[0] eq 'API::Chaplus::Request' ) {
        %attr = %{ shift; };
    }

    my $ref = _encode(%attr);

    my $params = $rj->json_content($ref);

    my $req =
      Furl::Request->new( 'POST', $self->{'endPoint'},
        { 'Content-Type' => 'application/json' },
        encode_utf8($params) );

    my ($res) = $f->request($req);

    if ( exists $res->{'code'} and $res->{'code'} eq '200' ) {
        my $content = $j->decode( $res->{'content'} );
        return $content;
    }
    else {
        croak "something wrong to post by Furl: " . url_decode eDumper($res);
    }
}

=head3 bestResponse( utterance => '日本語で話しかけよう', ... )

attribute 'utterance' is required

returns Response object

=cut 

sub bestResponse {
    my $self = shift;
    my $q    = $self->request(@_);
    return API::Chaplus::Response->new( $q->{'bestResponse'} );
}

=head3 responses( utterance => '日本語で話しかけよう', ... )

attribute 'utterance' is required

returns list of response objects

=cut 

sub responses {
    my $self = shift;
    my $q    = $self->request(@_);
    my @list = map { API::Chaplus::Response->new($_) } @{ $q->{'responses'} };
    return wantarray ? @list : \@list;
}

=head3 tokenized( utterance => '日本語で話しかけよう', ... )

attribute 'utterance' is required

returns list of tokenized objects

=cut 

use Encode qw(encode_utf8 decode_utf8);

sub tokenized {
    my $self = shift;
    my $q    = $self->request(@_);
    my @list = map { API::Chaplus::Tokenized->new( token => $_ ) }
      @{ $q->{'tokenized'} };
    return wantarray ? @list : \@list;
}

=head3 options( utterance => '日本語で話しかけよう', ... )

attribute 'utterance' is required

returns list of options objects

=cut 

sub options {
    my $self = shift;
    my $q    = $self->request(@_);
    my @list =
      map { API::Chaplus::Options->new( suggest => $_ ) } @{ $q->{'options'} };
    return wantarray ? @list : \@list;
}

sub _encode {
    my %origin  = @_;
    my $hashref = {};
    while ( my ( $key, $value ) = each %origin ) {
        $hashref->{$key} = $value->serialize() and next if ref $value;
        $hashref->{$key} = url_encode $value;
    }
    return $hashref;
}

1;
__END__

=head1 SEE ALSO

=over

=item L<Botが雑談に応えられるようにするWEB APIを公開してみた話【個人開発】|https://qiita.com/maKunugi/items/b1afb6441571119729a7>

=item L<chaplus-api-doc|https://k-masashi.github.io/chaplus-api-doc/>

=item L<API::Chaplus::Request.md|https://github.com/worthmine/API-Chaplus/blob/master/lib/API/Chaplus/Request.md>

=back

=head1 LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

worthmine E<lt>worthmine@gmail.comE<gt>

=cut
