# NAME

API::Chaplus - It's API modile for Chaplus

# SYNOPSIS

    use API::Chaplus;
    my $api    = API::Chaplus->new( apikey => 'your_key' );
    my $answer = $api->request( utterance => '調子どう？' );
    print $answer;    # お返事が表示される

# DESCRIPTION

API::Chaplus is a test implement for Chaplus-API

# SEE ALSO

- [Botが雑談に応えられるようにするWEB APIを公開してみた話【個人開発】](https://qiita.com/maKunugi/items/b1afb6441571119729a7)
- [chaplus-api-doc](https://k-masashi.github.io/chaplus-api-doc/)

# LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

worthmine <worthmine@gmail.com>
