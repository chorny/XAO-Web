package XAO::DO::Web::MyAction;
use strict;
use XAO::Utils;
use XAO::Objects;
use base XAO::Objects->load(objname => 'Web::Action');

# display_* only

sub display_test_one ($@) {
    my $self=shift;
    my $args=get_args(\@_);

    $args->{'arg'} || throw $self "- no 'arg'";

    $self->textout('test-one-ok');
}

# data_* and display_*

sub data_test_two ($@) {
    my $self=shift;
    my $args=get_args(\@_);

    return {
        'foo'       => 'bar',
        'hashref'   => { a => 'aa', b => 'bb' },
        'arg'       => 'xx'.($args->{'arg'} || throw $self "- no 'arg'"),
    };
}

sub display_test_two ($@) {
    my $self=shift;
    my $args=get_args(\@_);

    my $data=$args->{'data'} || throw $self "- no 'data'";

    ref($data) eq 'HASH' || throw $self "- data is not a hash";

    $data->{'arg'} eq 'xx'.$args->{'arg'};

    $self->textout('test-two-ok');
}

# data_* only, no display_*, array ref data

sub data_test_three ($@) {
    my $self=shift;
    my $args=get_args(\@_);

    return [
        'foo',
        'bar',
    ];
}

# data_* only, no display_*, hash ref data

sub data_test_four ($@) {
    my $self=shift;
    my $args=get_args(\@_);

    return {
        'foo'   => 'scalar',
        'bar'   => { 'hash' => 'ref' },
    };
}

# Old style

sub check_mode ($%) {
    my $self=shift;
    my $args=get_args(\@_);
    my $mode=$args->{mode} || 'no-mode';
    if($mode eq 'foo') {
        $self->textout('Got FOO');
    }
    elsif($mode eq 'no-mode') {
        $self->textout('Got MODELESS');
    }
    else {
        $self->SUPER::check_mode($args);
    }
}

1;
