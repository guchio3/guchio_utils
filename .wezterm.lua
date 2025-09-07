local wezterm = require 'wezterm'

return {
  -- $BF1:-%U%)%s%H$rM%@h$7!"B-$j$J$$;z7A$O%U%)!<%k%P%C%/(B
  font = wezterm.font_with_fallback({
    'JetBrains Mono',        -- WezTerm $BF1:-(B
    'Nerd Font Symbols',     -- $B%"%$%3%s5-9f(B
    'Noto Color Emoji',      -- $B3(J8;z(B
  }),

  -- $B!JG$0U!K?'%F!<%^!'9%$_$GM-8z2=(B
  -- color_scheme = "Builtin Solarized Dark",

  -- Claude Code $B$G(B Shift+Enter $B$r2~9T$H$7$F;H$&!J(Btmux $BJ;MQ$J$i(B tmux $BB&$K(B set -g xterm-keys on $B$b!K(B
  keys = {
    { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\n") },
  },
}

