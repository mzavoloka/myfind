use v5.18;
use File::Find;
#use Term::ANSIColor;

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
        #grep { -d $fi $filename eq $_; } @ignore_directories;
        if( grep { -d $filename and $filename eq $_; } @ignore_directories )
        {
            $File::Find::prune = 1; return;
        }
        elsif( $filename =~ /$argument/ )
        {
            push( @output, {
                number   => ++$i,
                filename => $File::Find::name
            } );
        }
    }
}

sub output
{
    my $max_number_length = length $i;
    for my $line ( @output )
    {
        say sprintf( "%${max_number_length}u: %s", $line -> { 'number' }, $line -> { 'filename' } );
    }
}
