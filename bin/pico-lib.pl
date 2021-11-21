use strict;
use warnings;
use experimental 'smartmatch';
use Alanxoc3::Pico8FormatUtil;
use Getopt::Long qw(GetOptions);

use utf8;
use open qw(:std :utf8);
binmode(STDIN, "encoding(UTF-8)");
binmode(STDOUT, "encoding(UTF-8)");

# Set constants from colon separated keyvalue pairs in arguments.
my %library_functions;

sub test_func {
   my $funcname = shift;
   my $funcdef = shift;
   $library_functions{$funcname} = $funcdef;
   return "";
}

# Go through the actual minifying.
my $input = join("", <STDIN>);
$input =~ s/(^function (\w+)\s*?\(.*?^end.*?$)/test_func($2, $1)/gimse;

my %imported_functions;

for (@ARGV) {
    if ($library_functions{$_}) {
        $imported_functions{$_} = $library_functions{$_};
    }
}

my $imported_str = "";
my $prev_size = 0;

while (scalar (keys %imported_functions) != $prev_size) {
    $prev_size = keys %imported_functions;
    $imported_str = (join "\n\n", (sort (values %imported_functions)));
    my %vars = populate_vars(split(/\n/, $imported_str));
    for (keys %vars) {
        if ($library_functions{$_}) {
            $imported_functions{$_} = $library_functions{$_};
        }
    }
}

print (join "\n\n", (sort (values %imported_functions)));
