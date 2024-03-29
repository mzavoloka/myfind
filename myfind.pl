use strict;
use feature 'say';
use File::Find;
use Term::ANSIColor;
use Encode qw( encode_utf8 decode_utf8 );

my @ignore_directories = qw( .git .svn );
my $i = 0;
my @output = ();

find(\&fill_output_array, ".");
&output();

sub fill_output_array
{
    my $filename = decode_utf8 $_;

    for my $argument ( @ARGV )
    {
        my $argument = decode_utf8($argument);
        if( grep { -d $filename and $filename eq $_; } @ignore_directories )
        {
            $File::Find::prune = 1; return;
        }
        elsif( $filename =~ /$argument/i )
        {
            push( @output, {
                number   => ++$i,
                filename => $File::Find::name,
                is_dir   => -d $filename
            } );
        }
    }
}

sub output
{
    my $max_number_length = length $i;
    for my $line ( @output )
    {
        print color( 'grey14' );
        print sprintf( "%${max_number_length}u | ", $line -> { 'number' } );
        print( $line -> { 'is_dir' } ? color( 'bold blue' ) : color( 'reset' ) );
        my $slash_for_dir = $line -> { 'is_dir' } ? '/' : '';
        say $line -> { 'filename' }.$slash_for_dir;
        print color( 'reset' );
    }
}
