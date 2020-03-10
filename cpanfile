requires 'perl', '5.008001';
requires 'Carp';

requires 'Mouse';
requires 'Data::Dumper::AutoEncode';
requires 'JSON';
requires 'URL::Encode';
requires 'Furl';
requires 'HTTP::Request::JSON';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'Test::More::UTF8';
};

