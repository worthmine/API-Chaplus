# NAME

API::Chaplus::Request - objectifier for Requests 

# SYNOPSIS

    use API::Chaplus::Request;
    my $pair = API::Chaplus::UtterancePair->new(
        utterance => '肩凝った', 
        response => '適度に運動しないとね',
    );

    my $addition = API::Chaplus::Request::Addition->new(       
        options        => [qw(疲れた 肩凝った)],
        utterancePairs => $pair,                    # auto optimize to [$pair] by Mouse Coercion
        ngwords        => [ "ため息", "やめてしまえ" ],
    );
    
    my $state = API::Chaplus::Request::AgentState->new(
        agentName => 'エージェント',
        tone      => 'kansai',
        age       => '14歳',
    );

    my $req =  use API::Chaplus::Request->new(
        username   => '太郎',
        utterance  => '調子はどう？',
        agentState => $state,
        addition   => $addition,
    );
    my $api    = API::Chaplus->new( apikey => 'your_key' );
    my $answer = $api->bestResponse($req);
    print $answer;    # お返事が表示される

# DESCRIPTION

API::Chaplus::Request provides you objectified attributes for API::Chaplus; 

## CONSTRUCTOR

### new()

Attribute 'utterance' is required. 
Any other attributes are optional

## METHODS

### username(_Name_)
accepts/returns the name 

### utterance(_Name_)

accepts/returns the utterance 

### agentState(_Name_)

accepts/returns 'agentState' Object/HashRef 

### addition(_Name_)

accepts/returns 'addition' Object/HashRef 

# SEE ALSO

- [chaplus-api-doc](https://k-masashi.github.io/chaplus-api-doc/)
- [API::Chaplus](https://github.com/worthmine/API-Chaplus)

# LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

worthmine <worthmine@gmail.com>
