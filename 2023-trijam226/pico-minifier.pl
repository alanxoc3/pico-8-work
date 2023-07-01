use strict;
use warnings;
use experimental 'smartmatch';
use Alanxoc3::Pico8FormatUtil;
use Getopt::Long qw(GetOptions);

use utf8;
use open qw(:std :utf8);
binmode(STDIN, "encoding(UTF-8)");
binmode(STDOUT, "encoding(UTF-8)");

my $minify;
my $debug_mode;
GetOptions('minify' => \$minify,
           'debug' => \$debug_mode,
) or die "Usage: $0 [--minify] [--debug]\n";

# Constants for game.
my %constants;

# Go through the actual minifying.
my @lines = <>;
chomp(@lines);

# Preprocess, remove unneeded code.
if (not $debug_mode) {
   my $content = join("\n", @lines);
   $content =~ s/DEBUG_BEGIN.*?DEBUG_END//gims;
   @lines = split(/\n/, $content);
}

my $content = join("\n", @lines);
@lines = split(/\n/, $content);

# Remove comments and spaces, preserve quotes...
@lines = remove_comments(@lines);
@lines = tokenize_lines(\@lines, \%constants);
@lines = remove_texts(@lines);
@lines = single_quotes_to_double(@lines);
@lines = remove_spaces(@lines);

if ($minify) {
   my %vars = populate_vars(@lines);
   @lines = tokenize_lines(\@lines, \%vars);
}

# Uncomment for each thing to go on its own line.
# Note that this is slightly more compression space.
# $lines[0] =~ s/([^\"]) ([^\"])/$1\n$2/g;
@lines = pop_text_logics(@lines);

my ($strings, $contents) = multiline_string_replace(join("\n", @lines));

# Ztable doesn't use the quotes in the string data, so remove them.
$strings =~ s/"//g;

$contents =~ s/ZTABLE_STRINGS/$strings/gme;

print $contents;
