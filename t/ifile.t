use strict;
use Test::More tests => 20;
use Iterator::IO;

# Check that ifile and ifile_reverse work as promised.

sub begins_with
{
    my ($actual, $expected, $test_name) = @_;

    $actual = substr($actual, 0, length $expected);
    @_ =  ($actual, $expected, $test_name);
    goto &is;
}

my ($file, @vals);

# ifile bad chomp value (4)
eval
{
    $file = ifile 't/test_data.txt', 'barf';
};

isnt ($@, q{}, q{Bad option to ifile threw exception});
ok (Iterator::X->caught(), q{Bad-option exception is correct base class});
ok (Iterator::X::Parameter_Error->caught(),
    q{Bad-option exception is correct specific class});
begins_with ($@, q{Invalid "chomp" argument to ifile},
             q{Bad-option exception formatted properly});

# ifile normal operation (2)
@vals = ();
eval
{
    $file = ifile 't/test_data.txt';
    push @vals, $file->value()  while $file->isnt_exhausted();
};

is ($@, q{}, q{ifile Iterator created and executed.});
is_deeply (\@vals, ['First line', 'Second line', 'Third line', 'Fourth line'],
           q{ifile returned proper values.});

# ifile without chomping (2)
@vals = ();
eval
{
    $file = ifile 't/test_data.txt', 'nochomp';
    push @vals, $file->value()  while $file->isnt_exhausted();
};

is ($@, q{}, q{ifile Iterator created and executed.});
is_deeply (\@vals, ["First line\n", "Second line\n", "Third line\n", "Fourth line\n"],
           q{ifile returned proper values.});

# ifile separator (2)
@vals = ();
eval
{
    $file = ifile 't/test_data.txt', 'chomp', " line\n";
    push @vals, $file->value()  while $file->isnt_exhausted();
};

is ($@, q{}, q{ifile Iterator created and executed.});
is_deeply (\@vals, ["First", "Second", "Third", "Fourth"],
           q{ifile returned proper values.});



# ifile_reverse bad chomp value (4)
eval
{
    $file = ifile_reverse 't/test_data.txt', 'barf';
};

isnt ($@, q{}, q{Bad option to ifile_reverse threw exception});
ok (Iterator::X->caught(), q{Bad-option exception is correct base class});
ok (Iterator::X::Parameter_Error->caught(),
    q{Bad-option exception is correct specific class});
begins_with ($@, q{Invalid "chomp" argument to ifile_reverse},
             q{Bad-option exception formatted properly});


# ifile_reverse normal operation (2)
@vals = ();
eval
{
    $file = ifile_reverse 't/test_data.txt';
    push @vals, $file->value()  while $file->isnt_exhausted();
};

is ($@, q{}, q{ifile Iterator created and executed.});
is_deeply (\@vals, ['Fourth line', 'Third line', 'Second line', 'First line'],
           q{ifile returned proper values.});

# ifile_reverse without chomping (2)
@vals = ();
eval
{
    $file = ifile_reverse 't/test_data.txt', 'nochomp';
    push @vals, $file->value()  while $file->isnt_exhausted();
};

is ($@, q{}, q{ifile Iterator created and executed.});
is_deeply (\@vals, ["Fourth line\n", "Third line\n", "Second line\n", "First line\n"],
           q{ifile returned proper values.});

# ifile_reverse line separator (2)
@vals = ();
eval
{
    $file = ifile_reverse 't/test_data.txt', 'chomp', " line\n";
    push @vals, $file->value()  while $file->isnt_exhausted();
};

is ($@, q{}, q{ifile Iterator created and executed.});
is_deeply (\@vals, ["Fourth", "Third", "Second", "First"],
           q{ifile returned proper values.});

