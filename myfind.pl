use v5.18;
use File::Find;
use Term::ANSIColor;

my @ignore_directories = qw( .git );
my $i = 0;
my @output = ();

find(\&fill_output_array, ".");
&output();

sub fill_output_array
{
    my $filename = $_;
    for my $argument ( @ARGV )
    {
        if( grep { -d $filename and $filename eq $_; } @ignore_directories )
        {
            $File::Find::prune = 1; return;
        }
        elsif( $filename =~ /$argument/ )
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
        print color( 'grey5' );
        print sprintf( "%${max_number_length}u | ", $line -> { 'number' } );
        print( $line -> { 'is_dir' } ? color( 'bold blue' ) : color( 'reset' ) );
        my $slash_for_dir = $line -> { 'is_dir' } ? '/' : '';
        say $line -> { 'filename' }.$slash_for_dir;
        print color( 'reset' );
    }
}
