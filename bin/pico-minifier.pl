use strict;
use warnings;
use experimental 'smartmatch';
use Alanxoc3::Pico8FormatUtil;
use Getopt::Long qw(GetOptions);

use utf8;
use open qw(:std :utf8);
binmode(STDIN, "encoding(UTF-8)");
binmode(STDOUT, "encoding(UTF-8)");

# Constants to worry about:
# DEBUG_BEGIN            -- marks the beginning of debug code. this code is left out of the generated .code.lua unless you pass in the --debug option.
# DEBUG_END              -- marks the end of debug code.
# G_TABLE_INITIALIZATION -- if this is found in the code, it is replaced with a suitable initial value for the _g table

# Syntax to worry about:
# ""    -- raw string, spaces are not deleted from a string with double quotes, and the minifier does not run on it. the minifier does run on strings with '...' or [[...]] though.
# [[]]  -- zobj string, zobj strings are all put together into one variable, and replaced with an index. this is done so that all the strings could be serialized in pico-8 cart data if you want.
# || $$ -- adds something to the _g table. name of item is specified between | and |. value is specified between | and $$.

my $minify;
my $ignorelib;
my $debug_mode;
GetOptions('minify'    => \$minify,     # minify the generated code
           'debug'     => \$debug_mode, # should the generated code include debug code
) or die "Usage: $0 [--minify] [--debug]\n";

# Set constants from colon separated keyvalue pairs in arguments.
my %constants;
for (@ARGV) {
    my @pair = split(/:/, $_, 2);
    $constants{$pair[0]} = $pair[1];
}

my $content = join("\n", <STDIN>);

if (not $debug_mode) {
   $content =~ s/DEBUG_BEGIN.*?DEBUG_END//gims;
}

$content = remove_comments($content);

# |...| ... $$ syntax
my $global_keys = "";
my $global_vals = "";
while ( $content =~ s/\|\s*(\w+)\s*\|(.*?)\$\$//ms ) {
    my $name = $1; my $value = $2;
    $global_keys .= ",".$1.",@";
    $global_vals .= ",".$2;
}

if (length $global_keys and length $global_vals) {
    $global_keys = substr $global_keys, 1;
    $content =~ s/G_TABLE_INITIALIZATION/"zobj([[".$global_keys."]]".$global_vals.")"/ge;
} else {
    $content =~ s/G_TABLE_INITIALIZATION/{}/g;
}

$content =~ s/GLOBAL_VALS/$global_vals/ge;

# trimming, minimizing, replacing things
$content = tokenize_lines($content, \%constants);
my @texts;
($content, @texts) = remove_texts($content);

if ($minify) {
    my %vars = populate_vars($content);
    $content = tokenize_lines($content, \%vars);
}

$content = single_quotes_to_double($content);
$content = remove_spaces($content);
$content = pop_text_logics($content, \@texts);

# remove all newlines and quotes from multiline strings
$content =~ s/\[\[.*?\]\]/$& =~ s|\n||rg/gimse;
$content =~ s/\[\[.*?\]\]/$& =~ s|"||rg/gimse;
$content =~ s/\[\[.*?\]\]/$& =~ s|'||rg/gimse;

# This can be used to join all zobj strings on one line. Legacy functionality.
# my $strings = "";
# ($strings, $content) = multiline_string_replace($content);
# $strings =~ s/"//g;
# $content =~ s/ZOBJ_STRINGS/$strings/gme;

print $content;
