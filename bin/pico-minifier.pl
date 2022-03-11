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
# DEBUG_BEGIN         -- marks the beginning of debug code. this code is left out of the generated .code.lua unless you pass in the --debug option.
# DEBUG_END           -- marks the end of debug code.
# ZTABLE_STRINGS      -- if this is found in the code, it is replaced with all the multiline (ztable) strings put together, separated by a "|"
# ACTOR_TEMPLATE_KEYS -- if this is found in the code, it is replaced with a ztable syntax of all the keys for the (...) -{...}- syntax
# ACTOR_TEMPLATE_VALS -- if this is found in the code, it is replaced with a code snippet calling ztable

# Syntax to worry about:
# ""   -- raw string, spaces are not deleted from a string with double quotes, and the minifier does not run on it. the minifier does run on strings with '...' or [[...]] though.
# [[]] -- ztable string, ztable strings are all put together into one variable, and replaced with an index. this is done so that all the strings could be serialized in pico-8 cart data if you want.

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

# Parsing ACTOR_BEGIN -> ACTOR_END sections
my $actor_template_keys = "";
my $actor_template_vals = "";
while ( $content =~ s/ACTOR_BEGIN\s*\(\s*(\w+)\s*\)\s*(.*?ACTOR_END)//ms ) {
    my $name = $1; my $value = $2;
    $actor_template_keys .= $name.";";
    while ( $value =~ m/KEY\s*\(\s*(\w+)\s*\)\s*(.*?)(?=KEY|ACTOR_END)/gms ) {
        $actor_template_keys .= $1.":";
        $actor_template_vals .= $2.",";
    }
    $actor_template_keys .= ";";
}

$actor_template_vals =~ s/\n+/\n/g;
$content =~ s/ACTOR_TEMPLATE_KEYS/$actor_template_keys/ge;
$content =~ s/ACTOR_TEMPLATE_VALS/$actor_template_vals/ge;

# trimming, minimizing, replacing things
$content = remove_comments($content);
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

my $strings = "";
($strings, $content) = multiline_string_replace($content);
$strings =~ s/"//g;
$content =~ s/ZTABLE_STRINGS/$strings/gme;

print $content;
