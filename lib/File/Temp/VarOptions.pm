package File::Temp::VarOptions;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001; # for //
use strict 'subs', 'vars';
use warnings;
use File::Temp ();

use Exporter qw(import);
our @EXPORT_OK   = @File::Temp::EXPORT_OK;
our %EXPORT_TAGS = %File::Temp::EXPORT_TAGS;

my @our_funcs = qw(tempfile tempdir);
for my $func (@EXPORT_OK) {
    next if grep {$_ eq $func} @our_funcs;
    *{$func} = \&{"File::Temp::$func"};
}

# defaults from File/Temp.pm
our $TEMPLATE = undef;
our $DIR      = undef;
our $SUFFIX   = '';
our $UNLINK   = 0;
our $OPEN     = 1;
our $TMPDIR   = 0;
our $EXLOCK   = 0;
sub tempfile {
    my $template;
    if (@_ % 2) { $template = shift }

    File::Temp::tempfile(
        TEMPLATE => $template // $TEMPLATE,
        DIR      => $DIR,
        SUFFIX   => $SUFFIX,
        UNLINK   => $UNLINK,
        OPEN     => $OPEN,
        TMPDIR   => $TMPDIR,
        EXLOCK   => $EXLOCK,
        @_,
    );
}

# defaults from File/Temp.pm
our $CLEANUP = 0;
sub tempdir {
    my $template;
    if (@_ % 2) { $template = shift }

    File::Temp::tempdir(
        CLEANUP  => $CLEANUP,
        DIR      => $DIR,
        TMPDIR   => $DIR,
        @_,
    );
}

1;
#ABSTRACT: Like File::Temp, but allowing to set options with variables

=head1 SYNOPSIS

 use File::Temp::VarOptions qw(tempfile tempdir);

 {
     local $File::Temp::VarOptions::SUFFIX = '.html';
     ($fh, $filename) = tempfile(); # use .html suffix
     ...
     ($fh, $filename) = tempfile('XXXXXXXX', SUFFIX=>''); # use empty suffix
 }
 ...
 ($fh, $filename) = tempfile(); # use empty suffi


=head1 EXPORTS

Same as L<File::Temp>'s.


=head1 VARIABLES

=head2 $TEMPLATE

=head2 $DIR

=head2 $SUFFIX

=head2 $UNLINK

=head2 $OPEN

=head2 $TMPDIR

=head2 $EXLOCK

=head2 $CLEANUP


=head1 SEE ALSO

L<File::Temp>
