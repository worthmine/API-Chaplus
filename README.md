# NAME

API::Chaplus - It's an API module for [Chaplus](https://www.chaplus.jp/) with perl

# SYNOPSIS

    use API::Chaplus;
    my $api    = API::Chaplus->new( apikey => 'your_key' );
    my $answer = $api->bestResponse( utterance => '調子どう？' );
    print $answer;    # お返事が表示される

# DESCRIPTION

API::Chaplus is a test implement for [Chaplus-API](https://k-masashi.github.io/chaplus-api-doc/)

## CONSTRUCTOR

### new( apikey => YOUR\_KEY )

attribute 'apikey' is required

## METHODS

### request( utterance => '日本語で話しかけよう', ... )

attribute 'utterance' is required

returns Perl hash decoded from JSON 

### bestResponse( utterance => '日本語で話しかけよう', ... )

attribute 'utterance' is required

returns Response object

### responses( utterance => '日本語で話しかけよう', ... )

attribute 'utterance' is required

returns list of response objects

### tokenized( utterance => '日本語で話しかけよう', ... )

attribute 'utterance' is required

returns list of tokenized objects

### options( utterance => '日本語で話しかけよう', ... )

attribute 'utterance' is required

returns list of options objects

# SEE ALSO

- [Botが雑談に応えられるようにするWEB APIを公開してみた話【個人開発】](https://qiita.com/maKunugi/items/b1afb6441571119729a7)
- [chaplus-api-doc](https://k-masashi.github.io/chaplus-api-doc/)
- [API::Chaplus::Request.md](https://github.com/worthmine/API-Chaplus/blob/master/lib/API/Chaplus/Request.md)

# LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

worthmine <worthmine@gmail.com>
