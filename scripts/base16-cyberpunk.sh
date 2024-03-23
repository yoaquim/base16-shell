#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Green Screen scheme by Chris Kempson (http://chriskempson.com)

color00="15/15/15" # Base 00 - Black (Dark Grey)
color01="ff/00/80" # Base 08 - Pink/Red
color02="08/f0/00" # Base 0B - Neon Green
color03="ff/fa/00" # Base 0A - Yellow
color04="00/80/ff" # Base 0D - Blue
color05="ff/00/ff" # Base 0E - Magenta
color06="00/ff/ff" # Base 0C - Cyan
color07="d0/d0/d0" # Base 05 - Light Gray
color08="50/50/50" # Base 03 - Dark Gray
color09="ff/60/70" # Base 09
color10="c0/ff/00" # Base 0B - Bright Green
color11="ff/d0/00" # Base 0A - Bright Yellow
color12="00/b0/ff" # Base 0D - Bright Blue
color13="ff/60/ff" # Base 0E - Bright Magenta
color14="50/ff/ff" # Base 0C - Bright Cyan
color15="ff/ff/ff" # Base 07 - White
color16="ff/90/00" # Base 09 - Orange
color17="ff/00/60" # Base 0F - Deep Pink
color18="28/28/28" # Base 01
color19="38/38/38" # Base 02
color20="b0/b0/b0" # Base 04
color21="e0/e0/e0" # Base 06
color_foreground="d0/d0/d0" # Base 05
color_background="15/15/15" # Base 00 - Dark Grey Background

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg 00bb00 # foreground
  put_template_custom Ph 000000 # background
  put_template_custom Pi 00bb00 # bold color
  put_template_custom Pj 005500 # selection color
  put_template_custom Pk 00bb00 # selected text color
  put_template_custom Pl 00bb00 # cursor
  put_template_custom Pm 001100 # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
