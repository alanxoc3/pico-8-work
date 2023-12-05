use strict;
use warnings;
use experimental 'smartmatch';
use Alanxoc3::Pico8FormatUtil;
use Getopt::Long qw(GetOptions);
use IPC::Open2;

use utf8;
use open qw(:std :utf8);
binmode(STDIN, "encoding(UTF-8)");
binmode(STDOUT, "encoding(UTF-8)");

# Constants to worry about:
# DEBUG_BEGIN            -- marks the beginning of debug code. this code is left out of the generated .code.lua unless you pass in the --debug option.
# DEBUG_END              -- marks the end of debug code.
# NORMAL_BEGIN           -- marks the beginning of normal code. this code doesn't trigger in debug mode.
# NORMAL_END             -- marks the end of normal code.
# G_TABLE_KEY_STRING     -- this is used to help populate the _g table with "|[...]| ... $$" matches.
# G_TABLE_VALUES         -- this is used to help populate the _g table with "|[...]| ... $$" matches.

# Syntax to worry about:
# ""    -- raw string, spaces are not deleted from a string with double quotes, and the minifier does not run on it. the minifier does run on strings with '...' or [[...]] though.
# [[]]  -- zobj string, zobj strings are all put together into one variable, and replaced with an index. this is done so that all the strings could be serialized in pico-8 cart data if you want.
# |[...]| ... $$ -- adds something to the _g table. name of item is specified between | and |. value is specified between | and $$.

my $minify;
my $debug_mode;
my $newline;
GetOptions('minify'  => \$minify,     # minify the generated code
           'debug'   => \$debug_mode, # should the generated code include debug code
           'newline' => \$newline, # should the generated code include debug code
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
} else {
   $content =~ s/NORMAL_BEGIN.*?NORMAL_END//gims;
}

$content = remove_comments($content);

# |...| ... $$ syntax

my @global_keys_arr;
my @global_vals_arr;
while ( $content =~ s/\|\[\s*(\w+)\s*\]\|(.*?)\$\$//ms ) {
    my $name = $1; my $value = $2;
    push(@global_keys_arr, $1);
    push(@global_vals_arr, $2);
}

my $groupsize = 100;
my @keys_arr2;
my @vals_arr2;

while (my @keyschunk = splice @global_keys_arr, 0, $groupsize) {
    my @valschunk = splice @global_vals_arr, 0, $groupsize;

    my $keys_str = "";  for my $item (@keyschunk) { $keys_str .= ",".$item.",@"; };  push(@keys_arr2, $keys_str);
    my $vals_str = "";  for my $item (@valschunk) { $vals_str .= ",".$item     ; };  push(@vals_arr2, $vals_str);
}

my $finalzobjstr = "";
for (my $i = 0; $i < scalar @keys_arr2; $i++) {
    my $keystr = substr $keys_arr2[$i], 1;
    my $valstr = $vals_arr2[$i];
    $finalzobjstr .= "f_zobj_set(_g, [[".$keystr."]]".$valstr.")\n";
}

if (length $finalzobjstr) {
    $content =~ s/_G_ZOBJ/$finalzobjstr/ge;
}

# trimming, minimizing, replacing things
$content = tokenize_constants($content, \%constants);
my @texts;
($content, @texts) = remove_texts($content);

# remove spaces must go before cleaning up quotes
$content = remove_spaces($content);

# remove quotes within multiline strings
if (!$newline) {
  $content =~ s/\[\[.*?\]\]/$& =~ s|\n||rg/gimse;
}
$content =~ s/\[\[.*?\]\]/$& =~ s|"||rg/gimse;
$content =~ s/\[\[.*?\]\]/$& =~ s|'||rg/gimse;

# multiline & single quote become double quotes
$content =~ s/\[\[(.*?)\]\]/"$1"/g;
$content =~ s/'(.*?)'/"$1"/g;

# all double quotes have a "global" comment beforehand, for shrinko8

# second pass through minifies with shrinko8
if ($minify) {
    $content =~ s/"(.*?)"/--[[global]]"$1"/g;

    # open(my $pipe, "|-", "cat");
    # open2 my $out, my $in, "python3 ~/repos/shrinko8/shrinko8.py - - --minify --no-minify-rename --format lua --no-minify-lines --no-minify-tokens";
    open2 my $out, my $in, "python3 ~/repos/shrinko8/shrinko8.py - - --minify --rename-members-as-globals --format lua --no-minify-tokens --preserve 'PTEXTLOGIC,' --rename-map .map.txt";
    print $in $content;
    close($in);

    my $output = '';
    while (<$out>) {
        $output .= $_;  # Read the output of the command into a variable
    }

    $content = $output;
}

$content = pop_text_logics($content, \@texts);

print $content;
