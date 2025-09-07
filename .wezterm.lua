local wezterm = require 'wezterm'

return {
  -- 同梱フォントを優先し、足りない字形はフォールバック
  font = wezterm.font_with_fallback({
    'JetBrains Mono',        -- WezTerm 同梱
    'Nerd Font Symbols',     -- アイコン記号
    'Noto Color Emoji',      -- 絵文字
  }),

  -- （任意）色テーマ：好みで有効化
  -- color_scheme = "Builtin Solarized Dark",

  -- Claude Code で Shift+Enter を改行として使う（tmux 併用なら tmux 側に set -g xterm-keys on も）
  keys = {
    { key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\n") },
  },
}

