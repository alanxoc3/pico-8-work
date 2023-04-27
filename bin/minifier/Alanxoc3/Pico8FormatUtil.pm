package Alanxoc3::Pico8FormatUtil;
use strict;
use warnings;
use experimental 'smartmatch';

use Exporter;
our @ISA = 'Exporter';
our @EXPORT = qw(tokenize_constants remove_comments pop_text_logics remove_texts remove_spaces);

sub remove_spaces {
   my $content = shift;
   my @new_lines;

   for (split /\n/, $content) {
      my $line = $_;
      $line =~ s/^\s+|\s+$//g;
      $line =~ s/ +/ /g;
      $line =~ s/" and/"and/g;
      $line =~ s/" or/"or/g;
      $line =~ s/" then/"then/g;
      # get rid of spaces between symbols.
      $line =~ s/\s?([\|\@\:\;\%\!\/\-\*\+\=\<\>\{\}\(\)\[\]\,\.])\s?/$1/g;
      if (length($line) > 0) {
         push @new_lines, $line;
      }
   }

   return join("\n", @new_lines);
}

sub remove_comments {
   my $content = shift;
   $content =~ s/\-\-.*?$//gm;
   return $content;
}

sub text_logic {
   my $texts = shift;
   my $quote = shift;
   push @{$texts}, $quote;
   return "\"PTEXTLOGIC\"";
}

# Removes tbox texts, similar to removing comments. ($|, "|)
sub remove_texts {
   my $content = shift;
   my @texts;
   $content =~ s/\"(.*?)\"/text_logic(\@texts, $1)/ge;
   return ($content, @texts);
}

sub pop_text_logics {
   my $content = shift;
   my $texts = shift;
   $content =~ s/(PTEXTLOGIC)/shift @{$texts}/ge;
   return $content
}

sub test_eval {
   my $punc = shift;
   my $var = shift;
   my $vars_ref = shift;

   if (exists($vars_ref->{$var})) {
      $var = $vars_ref->{$var};
   }

   return "$punc$var";
}

# constants can have underscores. vars are minified, underscore separated.
# that's the reason for separating these methods out.
sub tokenize_constants {
   my $content = shift;
   my $vars_ref = shift;
   $content =~ s/([\W]*\b)([a-zA-Z_]\w*)/test_eval($1,$2,$vars_ref)/ge;
   return $content;
}

1;
