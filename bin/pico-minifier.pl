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
my $ignorelib;
my $debug_mode;
GetOptions('minify' => \$minify,     # minifies everything
           'ignorelib' => \$ignorelib, # output is a list of tokens
           'debug' => \$debug_mode,  # includes 
) or die "Usage: $0 [--minify] [--ignorelib] [--debug]\n";

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

if (not $ignorelib) {
    my $tmpcontent = $content;
    $tmpcontent = remove_comments($tmpcontent);
    $tmpcontent = tokenize_lines($tmpcontent, \%constants);
    ($tmpcontent, @_) = remove_texts($tmpcontent);

    my %vars = populate_vars($tmpcontent);
    my %existing_functions = populate_funcs($tmpcontent);
    my $library_text = `cat $ENV{PICO_WORK_DIR}/lib/*.lua`;
    my %library_functions = populate_funcs_with_content($library_text);
    my %imported_functions = get_imported_functions(\%vars, \%library_functions);
    foreach (keys %existing_functions) {
        delete %imported_functions{$_};
    }

    my $imported_content = join "\n\n", (sort (values %imported_functions));
    $content = $imported_content . "\n\n" . $content;
}

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
