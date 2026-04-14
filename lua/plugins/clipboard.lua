local function has_executable(cmd)
  return vim.fn.executable(cmd) == 1
end

local function is_wsl()
  return vim.fn.has "wsl" == 1 or vim.env.WSL_DISTRO_NAME ~= nil
end

local function wsl_clipboard()
  local paste_cmd =
    [[powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))]]

  return {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = paste_cmd,
      ["*"] = paste_cmd,
    },
    cache_enabled = 0,
  }
end

local function has_native_clipboard()
  if vim.fn.has "mac" == 1 then return has_executable "pbcopy" and has_executable "pbpaste" end

  if vim.env.WAYLAND_DISPLAY then
    return (has_executable "wl-copy" and has_executable "wl-paste")
      or (has_executable "waycopy" and has_executable "waypaste")
  end

  if vim.env.DISPLAY then return has_executable "xclip" or has_executable "xsel" end

  return has_executable "win32yank.exe"
    or (has_executable "clip" and has_executable "powershell")
    or (has_executable "clip.exe" and has_executable "powershell.exe")
    or (has_executable "putclip" and has_executable "getclip")
    or has_executable "termux-clipboard-set"
    or (vim.env.TMUX and has_executable "tmux")
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  init = function()
    local is_ssh = vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil

    if vim.g.clipboard == nil and is_wsl() and has_executable "clip.exe" and has_executable "powershell.exe" then
      vim.g.clipboard = wsl_clipboard()
      return
    end

    -- Prefer OSC52 when editing remotely and no native clipboard provider is available.
    if vim.g.clipboard == nil and is_ssh and not has_native_clipboard() then vim.g.clipboard = "osc52" end
  end,
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = {
        clipboard = "unnamedplus",
      },
    },
  },
}
