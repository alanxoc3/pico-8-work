package Alanxoc3::Pico8FormatUtil;
use strict;
use warnings;
use experimental 'smartmatch';

use Exporter;
our @ISA = 'Exporter';
our @EXPORT = qw(tokenize_constants tokenize_vars populate_vars populate_funcs populate_funcs_with_content single_quotes_to_double remove_comments pop_text_logics remove_texts remove_spaces @lua_keywords multiline_string_replace get_imported_functions);

our @lua_keywords = qw(
n b0d0 PTEXTLOGIC

break do else elseif end false for function goto if in local nil not or repeat
return then true until while and table string boolean unknown number

_ipairs _unpack _chr _ord _split _label _screen _rec _video _audio_rec _audio_end _pause
_reset _breadcrumb _shutdown _g _g_gunvals_raw _init _update _update60 _draw
_setmetatable _getmetatable _cocreate _coresume _lshr _costatus _cd _yield _load _save
_folder _ls _run _resume _reboot _stat _info _flip _printh _clip _pget _pset _sget _sset _fget
_fset _print _cursor _color _ceil _cls _camera _oval _ovalfill _circ _circfill _line _rect
_rectfill _pal _palt _spr _sspr _add _del _deli _all _foreach _pairs _btn _btnp _sfx _music
_mget _mset _map _peek _peek2 _poke2 _peek4 _poke4 _poke _memcpy _reload _cstore _memset _max
_min _mid _flr _cos _sin _atan2 _sqrt _abs _rnd _srand _band _bor _bxor _bnot _shl _shr
_cartdata _dget _dset _sub _sgn _stop _tline _menuitem _type _tostr _tonum _extcmd _ls _fillp _time
_assert _t _update_buttons _count _mapdraw _self _? __index _rotl _ENV
);

sub get_next_var_name {
   my $cur_chars_ref = shift;
   # Order of commonly used letters in the English language.
   # Saves *about* 30 compression tokens.
   my $char_inc = "etaoinsrhldcumfpgwybvkxjqz";

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

sub test_multiline_string {
   my $str = shift;
   my $multiline_strings = shift;
   my @strings = split(/\|/, $str);
   my @retarr;

   foreach my $x (@strings) {
      if (not exists($multiline_strings->{$x})) {
         my $size = keys %{$multiline_strings};
         $multiline_strings->{$x} = $size + 1;
      }
      push(@retarr, $multiline_strings->{$x});
   }

   return "[[" . join('|', @retarr) . "]]";
}

sub multiline_string_replace {
   my $file = shift;
   my %multiline_strings;

   $file =~ s/\[\[(.*?)\]\]/test_multiline_string($1,\%multiline_strings)/gimse;

   my $gunval_strs = "";
   foreach my $name (sort { $multiline_strings{$a} <=> $multiline_strings{$b} } keys %multiline_strings) {
      $name =~ s/\n//g;
      $gunval_strs = $gunval_strs . $name . "|";
   }
   $gunval_strs = $gunval_strs;

   return ($gunval_strs, $file)
}

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

sub populate_vars {
   my $content = shift;
   my %vars;
   # regex should match tokenize_lines

   while ($content =~ /[\W]*\b([a-z_]\w*)/g) {                                                                                                                 
   # new: while ($content =~ /[^a-zA-Z0-9]*([a-zA-Z][a-zA-Z0-9]*)/g) {
      if (not ($1 ~~ @lua_keywords)) {
        $vars{$1}++;
      }
   }

   # assign most used tokens to correct variables.
   my @cur_chars;
   foreach my $name (reverse sort { $vars{$a} <=> $vars{$b} } keys %vars) {
       $vars{$name} = get_next_var_name(\@cur_chars);
   }

   return %vars;
}

sub populate_funcs {
   my %funcs;
   my $line = shift;
   my @matches = ($line =~ /\bfunction\s+(\w+)\s*\(/g);
   foreach(@matches) {
     if (not ($_ ~~ @lua_keywords)) {
       $funcs{$_} = 1;
     }
   }

   return %funcs;
}

sub populate_funcs_with_content {
   my %funcs;
   my $content = shift;

   while($content =~ /(^function (\w+)\s*?\(.*?^end.*?$)/gms) {
     if (not ($2 ~~ @lua_keywords)) {
       $funcs{$2} = $1;
     }
   }

   return %funcs;
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

# Consistent quotes in project. Gun_vals assumes double quotes too.
sub single_quotes_to_double {
   my $content = shift;
   $content =~ s/\'/\"/g;
   return $content
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

sub get_imported_functions {
    my $vars = shift;
    my $library_functions = shift;
    my %imported_functions;

    for (keys %{$vars}) {
        if ($library_functions->{$_}) {
            $imported_functions{$_} = $library_functions->{$_};
        }
    }

    my $prev_size = 0;
    while (scalar (keys %imported_functions) != $prev_size) {
        $prev_size = keys %imported_functions;
        my %vars = populate_vars(join "\n\n", (sort (values %imported_functions)));
        for (keys %vars) {
            if ($library_functions->{$_}) {
                $imported_functions{$_} = $library_functions->{$_};
            }
        }
    }

    return %imported_functions;
}

# constants can have underscores. vars are minified, underscore separated.
# that's the reason for separating these methods out.
sub tokenize_constants {
   my $content = shift;
   my $vars_ref = shift;
   $content =~ s/([\W]*\b)([a-zA-Z_]\w*)/test_eval($1,$2,$vars_ref)/ge;
   return $content;
}

sub tokenize_vars {
   my $content = shift;
   my $vars_ref = shift;
   # regex should match populate_vars
   $content =~ s/([\W]*\b)([a-zA-Z_]\w*)/test_eval($1,$2,$vars_ref)/ge;
   # new: $content =~ s/(\b|_)([a-zA-Z][a-zA-Z0-9]*)/test_eval($1,$2,$vars_ref)/ge;
   return $content;
}

1;
