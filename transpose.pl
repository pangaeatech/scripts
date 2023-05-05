#!/usr/bin/perl -wT

# Transpose the specified file

my $delim = "\t";
open (FILE, "<&STDIN");
for (my $i = 0; $i <= $#ARGV; $i++) {
    if ($ARGV[$i] eq "-h" or $ARGV[$i] eq "-?" or $ARGV[$i] eq "--help") {
        &usage;
        exit;
    } elsif ($ARGV[$i] eq "-d") {
        $i++;
        $delim = $ARGV[$i];
    } elsif ($ARGV[$i] =~ m/^--delimiter=(.*)$/) {
        $delim = $1;
    } elsif ($i == $#ARGV and $ARGV[$i] !~ /^-/) {
        open (FILE, $ARGV[$i]);
    } else {
        print STDERR "ERROR: Unknown option $ARGV[$i]\n\n";
        &usage;
        exit;
    }
}

my %data = ();
my $cols = 0;
my $rows = 0;

# Load file into memory (sparse matrix)
while (<FILE>) {
    $_ =~ s/\r?\n?$//;
    my @line = split $delim;
    for (my $i=0; $i <= $#line; $i++) {
        $data{"$rows\t$i"} = $line[$i] unless ($line[$i] eq "");
    }
    $cols = $#line + 1 if ($#line >= $cols);
    $rows++;
}

# Print file to stdout
for (my $i=0; $i < $cols; $i++) {
    for (my $j=0; $j < $rows; $j++) {
        print "\t" if ($j > 0);
        print $data{"$j\t$i"} if defined($data{"$j\t$i"});
    }
    print "\n";
}

exit;

sub usage
{
    print STDERR "Usage $0 [OPTION]... [FILE]\n";
    print STDERR "Transpose the data in the FILE to standard output.\n\n";
    print "  -d, --delimiter=DELIM   use DELIM instead of TAB for field delimiter\n";
    print "  -h, --help              display this help and exit\n";
}
