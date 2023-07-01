package Alanxoc3::Pico8FormatUtil;
use strict;
use warnings;
use experimental 'smartmatch';

use Exporter;
our @ISA = 'Exporter';
our @EXPORT = qw(tokenize_lines populate_vars single_quotes_to_double remove_comments pop_text_logics remove_texts remove_spaces @lua_keywords multiline_string_replace);

our @lua_keywords = qw(
n b0d0 P_TEXT_LOGIC

break do else elseif end false for function goto if in local nil not or repeat
return then true until while and table string boolean unknown number

ipairs unpack chr ord split label screen rec video audio_rec audio_end pause
reset breadcrumb shutdown _g g_gunvals_raw _init _update _update60 _draw
setmetatable getmetatable cocreate coresume lshr costatus cd yield load save
folder ls run resume reboot stat info flip printh clip pget pset sget sset fget
fset print cursor color ceil cls camera oval ovalfill circ circfill line rect
rectfill pal palt spr sspr add del deli all foreach pairs btn btnp sfx music
mget mset map peek peek2 poke2 peek4 poke4 poke memcpy reload cstore memset max
min mid flr cos sin atan2 sqrt abs rnd srand band bor bxor bnot shl shr
cartdata dget dset sub sgn stop menuitem type tostr tonum extcmd ls fillp time
assert t _update_buttons count mapdraw self ? __index rotl
);

sub get_next_var_name {
   my $cur_chars_ref = shift;
   # Order of commonly used letters in the English language.
   # Saves *about* 30 compression tokens.
   my $char_inc = "etaoinsrhldcumfpgwybvkxjqz_";

   my @new_char_arr;
   my $next_bump = 1;
   foreach (reverse(@{$cur_chars_ref})) {
      my $char_ind = (index($char_inc, $_)+$next_bump) % length($char_inc);
      push(@new_char_arr, substr($char_inc, $char_ind, 1));
      $next_bump = ($next_bump == 1 and $char_ind == 0) ? 1 : 0;
   }

   if ($next_bump == 1) {
      push(@new_char_arr, 'e');
   }

   @{$cur_chars_ref} = reverse(@new_char_arr);
   my $ret = join("", @{$cur_chars_ref});
   if ($ret ~~ @lua_keywords) {
      return get_next_var_name($cur_chars_ref);
   } else {
      return $ret;
   }
}

my %multiline_strings;
my $multiline_number = 1;
sub test_multiline_string {
   my $str = shift;
   my @strings = split(/\|/, $str);
   my @retarr;

   foreach my $x (@strings) {
      if (not exists($multiline_strings{$x})) {
         $multiline_strings{$x} = $multiline_number++;
      }
      push(@retarr, $multiline_strings{$x});
   }

   return "[[" . join('|', @retarr) . "]]";
}

sub multiline_string_replace {
   my $file = shift;
   $file =~ s/\[\[(.*?)\]\]/test_multiline_string($1)/gimse;

   my $gunval_strs = "";
   foreach my $name (sort { $multiline_strings{$a} <=> $multiline_strings{$b} } keys %multiline_strings) {
      $name =~ s/\n//g;
      $gunval_strs = $gunval_strs . $name . "|";
   }
   $gunval_strs = $gunval_strs;

   return ($gunval_strs, $file)
}

sub remove_spaces {
   my @new_lines;

   for (@_) {
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

   return @new_lines;
}

sub remove_comments {
   my @new_lines;

   for (@_) {
      my $line = $_;

      my @matches = ($line =~ /--.*/g);
      foreach(@matches) { $line =~ s/\Q$_\E//g; }

      if (length($line) > 0) {
         push @new_lines, $line;
      }
   }

   return @new_lines;
}

sub populate_vars {
   # tokenize based on most used tokens.
   # this saves about 100 compression tokens.
   my %vars;
   for (@_) {
      my $line = $_;
      my @matches = ($line =~ /[\W]*\b([a-z_]\w*)/g);
      foreach(@matches) {
         if (not ($_ ~~ @lua_keywords)) {
            if (not exists($vars{$_})) {
               $vars{$_} = 0;
            } else {
               $vars{$_}++;
            }
         }
      }
   }

   # assign most used tokens to correct variables.
   my @cur_chars;
   foreach my $name (reverse sort { $vars{$a} <=> $vars{$b} } keys %vars) {
       $vars{$name} = get_next_var_name(\@cur_chars);
   }

   return %vars;
}

my @texts;
sub text_logic {
   my $quote = shift;
   push @texts, $quote;
   return "\"P_TEXT_LOGIC\"";
}

# Removes tbox texts, similar to removing comments. ($|, "|)
sub remove_texts {
   my @new_lines;

   for (@_) {
      my $line = $_;
      $line =~ s/\"(.*?)\"/text_logic($1)/ge;
      push @new_lines, $line;
   }

   return @new_lines
}

sub pop_text {
   my $thing = shift;
   my $item = shift @texts;
   return $item;
}

sub pop_text_logics {
   my @new_lines;

   for (@_) {
      my $line = $_;
      $line =~ s/(P_TEXT_LOGIC)/pop_text($1)/ge;
      push @new_lines, $line;
   }

   return @new_lines
}

# Consistent quotes in project. Gun_vals assumes double quotes too.
sub single_quotes_to_double {
   my @new_lines;

   for (@_) {
      my $line = $_;
      $line =~ s/\'/\"/g;
      push @new_lines, $line;
   }

   return @new_lines
}

sub test_eval {
   my $punc = shift;
   my $var = shift;
   my $vars_ref = shift;

   if (not ($var ~~ @lua_keywords)) {
      if (exists($vars_ref->{$var})) {
         $var = $vars_ref->{$var};
      }
   }

   return "$punc$var";
}

sub tokenize_lines {
   my $lines_ref = shift;
   my $vars_ref = shift;

   my @lines = @{$lines_ref};

   my @new_lines;

   for (@lines) {
      my $line = $_;
      $line =~ s/([\W]*\b)([a-zA-Z_]\w*)/test_eval($1,$2,$vars_ref)/ge;
      push @new_lines, $line;
   }

   return @new_lines
}

1;
