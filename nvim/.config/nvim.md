# Combined Files Documentation

**Generated on:** 2026-01-22 09:41:51
**Source directory:** `/home/ka/.dotfiles/nvim/.config/nvim`
**Output file:** `/home/ka/.dotfiles/nvim/.config/nvim.md`

## Summary
This document contains combined contents of text/source files from the specified directory.

---

## File: `doc/zig.txt`
```text
*zig.txt*  Zig development commands

==============================================================================
CONTENTS                                                         *zig-contents*

    1. Build & Run ............................................. |zig-build|
    2. Testing ................................................. |zig-test|
    3. Code Quality ............................................ |zig-quality|
    4. Project Management ...................................... |zig-project|
    5. Documentation ........................................... |zig-docs|
    6. Compilation & Analysis .................................. |zig-compile|
    7. Build Steps ............................................. |zig-steps|
    8. Navigation .............................................. |zig-nav|

==============================================================================
1. BUILD & RUN                                                      *zig-build*

:ZigBuild [args]                                                    *:ZigBuild*
    Run `zig build`.
    Examples: >
        :ZigBuild
        :ZigBuild -Doptimize=Debug
<

:ZigBuildRelease                                              *:ZigBuildRelease*
    Run `zig build -Doptimize=ReleaseFast`.

:ZigBuildSafe                                                    *:ZigBuildSafe*
    Run `zig build -Doptimize=ReleaseSafe`.

:ZigRun [args]                                                        *:ZigRun*
    Run `zig build run` in a terminal split.
    Arguments after command are passed to the executable.
    Examples: >
        :ZigRun
        :ZigRun arg1 arg2
<

:ZigRunFile [args]                                                *:ZigRunFile*
    Run `zig run` on the current file directly.
    Useful for single-file scripts.
    Examples: >
        :ZigRunFile
        :ZigRunFile arg1 arg2
<

==============================================================================
2. TESTING                                                           *zig-test*

:ZigTest [args]                                                      *:ZigTest*
    Run `zig build test` in a terminal split.
    Examples: >
        :ZigTest
        :ZigTest --summary
<

:ZigTestFile                                                      *:ZigTestFile*
    Run `zig test` on the current file directly.

:ZigTestFilter {name}                                            *:ZigTestFilter*
    Run tests matching a filter.
    Example: >
        :ZigTestFilter myTestName
<

==============================================================================
3. CODE QUALITY                                                   *zig-quality*

:ZigFmt                                                              *:ZigFmt*
    Format the current file with `zig fmt`.

:ZigFmtAll                                                        *:ZigFmtAll*
    Format all .zig files in the project.

:ZigFmtCheck                                                      *:ZigFmtCheck*
    Check formatting without making changes.

==============================================================================
4. PROJECT MANAGEMENT                                             *zig-project*

:ZigInit                                                            *:ZigInit*
    Initialize a new Zig project with `zig init`.
    Creates build.zig and src/ directory.

:ZigFetch {url}                                                    *:ZigFetch*
    Fetch a dependency and get its hash.
    Hash is automatically copied to clipboard.
    Example: >
        :ZigFetch https://github.com/user/repo/archive/v1.0.0.tar.gz
<

:ZigVersion                                                      *:ZigVersion*
    Display the installed Zig version.

==============================================================================
5. DOCUMENTATION                                                     *zig-docs*

:ZigDoc [topic]                                                      *:ZigDoc*
    Open Zig language documentation in browser.
    Examples: >
        :ZigDoc
        :ZigDoc Pointers
<

:ZigStdDoc [topic]                                                *:ZigStdDoc*
    Open Zig standard library documentation in browser.
    Examples: >
        :ZigStdDoc
        :ZigStdDoc std.mem
<

:ZigHelp [command]                                                  *:ZigHelp*
    Show `zig help` in a terminal split.
    Examples: >
        :ZigHelp
        :ZigHelp build
<

==============================================================================
6. COMPILATION & ANALYSIS                                         *zig-compile*

:ZigAst                                                              *:ZigAst*
    Run `zig ast-check` on the current file.
    Shows AST errors and analysis.

:ZigTranslateC {header}                                        *:ZigTranslateC*
    Translate a C header file to Zig.
    Example: >
        :ZigTranslateC /usr/include/stdio.h
<

==============================================================================
7. BUILD STEPS                                                      *zig-steps*

:ZigBuildSteps                                                  *:ZigBuildSteps*
    Show available build steps defined in build.zig.
    Runs `zig build --help`.

:ZigBuildStep {step}                                            *:ZigBuildStep*
    Run a specific build step.
    Examples: >
        :ZigBuildStep install
        :ZigBuildStep docs
<

==============================================================================
8. NAVIGATION                                                         *zig-nav*

:ZigAlt                                                              *:ZigAlt*
    Switch between source and test file.
    - `foo.zig` <-> `foo_test.zig`

:ZigAltV                                                            *:ZigAltV*
    Switch to alt file in a vertical split.

==============================================================================
vim:tw=78:ts=4:ft=help:norl:

```

## File: `doc/rust.txt`
```text
*rust.txt*  Rust/Cargo development commands

==============================================================================
CONTENTS                                                        *rust-contents*

    1. Build & Run ............................................. |rust-build|
    2. Testing ................................................. |rust-test|
    3. Code Quality ............................................ |rust-quality|
    4. Dependencies ............................................ |rust-deps|
    5. Documentation ........................................... |rust-docs|
    6. Project Management ...................................... |rust-project|
    7. Utilities ............................................... |rust-utils|
    8. Navigation .............................................. |rust-nav|
    9. Tool Installation ....................................... |rust-tools|

==============================================================================
1. BUILD & RUN                                                     *rust-build*

:CargoBuild [args]                                                *:CargoBuild*
    Run `cargo build`.
    Examples: >
        :CargoBuild
        :CargoBuild --features foo
        :CargoBuild -p my-crate
<

:CargoBuildRelease                                          *:CargoBuildRelease*
    Run `cargo build --release`.

:CargoRun [args]                                                    *:CargoRun*
    Run `cargo run` in a terminal split.
    Arguments after command are passed to the binary.
    Examples: >
        :CargoRun
        :CargoRun arg1 arg2
<

:CargoRunRelease [args]                                      *:CargoRunRelease*
    Run `cargo run --release`.

==============================================================================
2. TESTING                                                          *rust-test*

:CargoTest [args]                                                  *:CargoTest*
    Run `cargo test` in a terminal split.
    Examples: >
        :CargoTest
        :CargoTest test_name
        :CargoTest -- --nocapture
<

:CargoTestFunc                                                  *:CargoTestFunc*
    Test the function under cursor using treesitter.
    Runs with `--exact --nocapture` flags.

==============================================================================
3. CODE QUALITY                                                  *rust-quality*

:CargoCheck                                                      *:CargoCheck*
    Run `cargo check` asynchronously.

:CargoClippy [args]                                              *:CargoClippy*
    Run `cargo clippy` in a terminal split.
    Examples: >
        :CargoClippy
        :CargoClippy -- -W clippy::pedantic
<

:CargoFmt                                                          *:CargoFmt*
    Run `cargo fmt` and reload buffers.

:CargoFmtCheck                                                  *:CargoFmtCheck*
    Run `cargo fmt --check` to verify formatting.

==============================================================================
4. DEPENDENCIES                                                     *rust-deps*

:CargoAdd {crate}                                                  *:CargoAdd*
    Add a dependency using `cargo add`.
    Examples: >
        :CargoAdd serde
        :CargoAdd tokio --features full
        :CargoAdd --dev mockall
<

:CargoRemove {crate}                                            *:CargoRemove*
    Remove a dependency using `cargo remove`.

:CargoUpdate                                                    *:CargoUpdate*
    Run `cargo update` to update Cargo.lock.

:CargoTree [args]                                                 *:CargoTree*
    Show dependency tree in a terminal split.
    Examples: >
        :CargoTree
        :CargoTree -i serde
<

==============================================================================
5. DOCUMENTATION                                                    *rust-docs*

:CargoDoc[!]                                                       *:CargoDoc*
    Build documentation with `cargo doc`.
    Use :CargoDoc! to open in browser.

:RustDoc [crate]                                                    *:RustDoc*
    Open docs.rs for a crate. If no argument, uses word under cursor.
    Examples: >
        :RustDoc serde
        :RustDoc tokio
        :RustDoc           " uses <cword>
<

==============================================================================
6. PROJECT MANAGEMENT                                            *rust-project*

:CargoNew {name} [--lib]                                          *:CargoNew*
    Create a new Cargo project.
    Examples: >
        :CargoNew my-project
        :CargoNew my-lib --lib
<

:CargoInit [--lib]                                                *:CargoInit*
    Initialize a Cargo project in current directory.

:CargoClean                                                      *:CargoClean*
    Run `cargo clean` to remove target directory.

==============================================================================
7. UTILITIES                                                       *rust-utils*

:CargoExpand [item]                                              *:CargoExpand*
    Expand macros using cargo-expand.
    Requires: cargo-expand (install via :CargoInstallTools)
    Examples: >
        :CargoExpand
        :CargoExpand main
<

:CargoAudit                                                      *:CargoAudit*
    Check for security vulnerabilities.
    Requires: cargo-audit (install via :CargoInstallTools)

:CargoOutdated                                                  *:CargoOutdated*
    Check for outdated dependencies.
    Requires: cargo-outdated (install via :CargoInstallTools)

:CargoBench [args]                                                *:CargoBench*
    Run benchmarks with `cargo bench`.

==============================================================================
8. NAVIGATION                                                        *rust-nav*

:RustAlt                                                            *:RustAlt*
    Switch between lib.rs/main.rs and tests/mod.rs.

==============================================================================
9. TOOL INSTALLATION                                               *rust-tools*

:CargoInstallTools                                          *:CargoInstallTools*
    Install useful cargo subcommands:
    - cargo-expand     (macro expansion)
    - cargo-audit      (security audit)
    - cargo-outdated   (check outdated deps)
    - cargo-edit       (add/remove/upgrade deps)
    - cargo-watch      (watch for changes)
    - cargo-nextest    (better test runner)
    - cargo-flamegraph (flamegraph profiling)

:CargoInstallTool [name]                                    *:CargoInstallTool*
    Install a specific cargo tool. Tab completion available.
    Run without arguments to see available tools.
    Example: >
        :CargoInstallTool cargo-expand
<

==============================================================================
vim:tw=78:ts=4:ft=help:norl:

```

## File: `doc/go.txt`
```text
*go.txt*  Go development commands

==============================================================================
CONTENTS                                                          *go-contents*

    1. Build & Run ............................................. |go-build|
    2. Testing ................................................. |go-test|
    3. Module Management ....................................... |go-mod|
    4. Code Tools .............................................. |go-tools|
    5. Struct Tags ............................................. |go-tags|
    6. Navigation .............................................. |go-nav|
    7. Binary Management ....................................... |go-binaries|

==============================================================================
1. BUILD & RUN                                                      *go-build*

:GoBuild [args]                                                     *:GoBuild*
    Run `go build`. Default: `./...`
    Examples: >
        :GoBuild
        :GoBuild ./cmd/myapp
        :GoBuild -race ./...
<

:GoRun [args]                                                         *:GoRun*
    Run `go run` in a terminal split.
    Examples: >
        :GoRun
        :GoRun .
        :GoRun ./cmd/server
<

:GoGenerate [args]                                                *:GoGenerate*
    Run `go generate`. Default: `./...`
    Examples: >
        :GoGenerate
        :GoGenerate ./internal/...
<

==============================================================================
2. TESTING                                                           *go-test*

:GoTest [args]                                                       *:GoTest*
    Run `go test -v` in a terminal split.
    Examples: >
        :GoTest
        :GoTest ./...
        :GoTest -race ./...
        :GoTest -tags=integration ./...
<

:GoTestFunc                                                       *:GoTestFunc*
    Test the function under cursor. Uses treesitter to find the test
    function name. Cursor must be inside a `Test*` function.

:GoTestFile                                                       *:GoTestFile*
    Test the current package (directory of current file).

:GoCoverage [args]                                                *:GoCoverage*
    Run tests with coverage and open HTML report in browser.
    Examples: >
        :GoCoverage
        :GoCoverage ./internal/...
<

==============================================================================
3. MODULE MANAGEMENT                                                  *go-mod*

:GoModTidy                                                        *:GoModTidy*
    Run `go mod tidy`.

:GoModInit {module}                                               *:GoModInit*
    Run `go mod init {module}`.
    Example: >
        :GoModInit github.com/user/myproject
<

:GoGet {package}                                                      *:GoGet*
    Run `go get {package}`.
    Examples: >
        :GoGet github.com/gorilla/mux
        :GoGet -u ./...
<

==============================================================================
4. CODE TOOLS                                                       *go-tools*

:GoVet [args]                                                         *:GoVet*
    Run `go vet`. Default: `./...`

:GoLint [args]                                                       *:GoLint*
    Run `golangci-lint run`. Default: `./...`
    Requires: golangci-lint (install via :GoInstallBinaries)

:GoDoc [symbol]                                                       *:GoDoc*
    Open `go doc` in a terminal split.
    If no argument, uses word under cursor.
    Examples: >
        :GoDoc fmt.Println
        :GoDoc json.Marshal
        :GoDoc                   " uses <cword>
<

:GoImpl {receiver} {interface}                                       *:GoImpl*
    Generate interface implementation stubs.
    Requires: impl (install via :GoInstallBinaries)
    Examples: >
        :GoImpl 's *Service' io.Reader
        :GoImpl 'c *Client' http.Handler
        :GoImpl 'w *Writer' io.WriteCloser
<

:GoIfErr                                                             *:GoIfErr*
    Insert `if err != nil { return err }` block at cursor.
    If `iferr` tool is installed, generates smarter return values.

:GoModernize                                                     *:GoModernize*
    Run gopls modernize analyzer on current file.
    Automatically applies fixes for deprecated patterns.

:GoFillStruct                                                   *:GoFillStruct*
    Fill struct literal with default field values.
    Uses gopls LSP code action. Cursor must be on a struct literal.

==============================================================================
5. STRUCT TAGS                                                       *go-tags*

:GoAddTags [tags]                                                  *:GoAddTags*
    Add struct tags to the struct under cursor. Default: `json`
    Requires: gomodifytags (install via :GoInstallBinaries)
    Examples: >
        :GoAddTags              " adds json tags
        :GoAddTags json,xml
        :GoAddTags yaml
<

:GoRemoveTags [tags]                                            *:GoRemoveTags*
    Remove struct tags from the struct under cursor. Default: `json`
    Examples: >
        :GoRemoveTags
        :GoRemoveTags json,xml
<

==============================================================================
6. NAVIGATION                                                         *go-nav*

:GoAlt                                                                 *:GoAlt*
    Switch between source and test file.
    - `foo.go` <-> `foo_test.go`

:GoAltV                                                               *:GoAltV*
    Switch between source and test file in a vertical split.

==============================================================================
7. BINARY MANAGEMENT                                              *go-binaries*

:GoInstallBinaries                                        *:GoInstallBinaries*
    Install all Go tool binaries:
    - goimports
    - gomodifytags
    - impl
    - iferr
    - gotests
    - golangci-lint
    - dlv (delve debugger)
    - staticcheck
    - govulncheck

:GoUpdateBinaries                                          *:GoUpdateBinaries*
    Update all Go tool binaries to latest versions.

:GoInstallBinary [name]                                    *:GoInstallBinary*
    Install a specific tool. Tab completion available.
    Example: >
        :GoInstallBinary impl
        :GoInstallBinary golangci-lint
<
    Run without arguments to see available tools.

==============================================================================
vim:tw=78:ts=4:ft=help:norl:

```

## File: `.luacheckrc`
```text
-- Luacheck configuration for Neovim
globals = {
    "vim", -- Neovim global
}

-- Ignore line length warnings
max_line_length = false

-- Ignore unused arguments warnings for common patterns
ignore = {
    "631", -- Line too long
    "212", -- Unused argument
    "213", -- Unused loop variable
    "122", -- Setting read-only field (false positive for vim.opt and vim.g)
}

-- Read-only globals
read_globals = {
    "vim",
}

-- Specific rules for test files
files["*_spec.lua"] = {
    std = "+busted",
}

-- Don't report unused self arguments of methods
self = false

```

## File: `stylua.toml`
```toml
# StyLua configuration for Neovim Lua development
# https://github.com/JohnnyMorganz/StyLua

# Column width for line wrapping (100 is a good balance for modern displays)
column_width = 100

# Line endings (Unix for cross-platform compatibility)
line_endings = "Unix"

# Indentation settings
indent_type = "Spaces"
indent_width = 2

# Quote style
# AutoPreferDouble: Automatically determines quote style, preferring double quotes
# Options: "AutoPreferDouble", "AutoPreferSingle", "ForceDouble", "ForceSingle"
quote_style = "AutoPreferDouble"

# Call parentheses
# Always: Always use parentheses for function calls
# Options: "Always", "NoSingleString", "NoSingleTable", "None"
call_parentheses = "Always"

# Collapse simple statements
# Never: Keep simple statements expanded for better readability
# Options: "Never", "FunctionOnly", "ConditionalOnly", "Always"
collapse_simple_statement = "Never"

# Space after function names
# Never: No space between function name and parentheses (Lua convention)
# Options: "Never", "Definitions", "Calls", "Always"
space_after_function_names = "Never"

# Sort requires
# Enable to automatically sort require statements
[sort_requires]
enabled = false
```

## File: `lua/utils/web_dev.lua`
```lua
-- .config/nvim/lua/utils/web_dev.lua
local M = {}

-- Tự động phát hiện Package Manager (pnpm > yarn > bun > npm)
local function get_package_manager()
  local root = vim.fn.getcwd()
  if vim.fn.filereadable(root .. "/pnpm-lock.yaml") == 1 then
    return "pnpm"
  end
  if vim.fn.filereadable(root .. "/yarn.lock") == 1 then
    return "yarn"
  end
  if vim.fn.filereadable(root .. "/bun.lockb") == 1 then
    return "bun"
  end
  return "npm"
end

-- Hàm setup các lệnh cho buffer hiện tại
function M.setup_commands()
  local pm = get_package_manager()

  -- Helper chạy lệnh trong Snacks Terminal
  local function run_term(cmd)
    Snacks.terminal(cmd, {
      win = { position = "bottom", height = 0.4, border = "rounded" },
      interactive = true,
      start_insert = true,
    })
  end

  -- 1. Lệnh :NpmInstall (Tự động dùng đúng pnpm/yarn/npm)
  vim.api.nvim_buf_create_user_command(0, "NpmInstall", function(opts)
    local args = opts.args or ""
    local cmd = pm .. " install " .. args
    if pm == "yarn" and args == "" then
      cmd = "yarn"
    end -- yarn install chỉ là yarn
    run_term(cmd)
  end, { nargs = "?", desc = "Install dependencies with detected PM" })

  -- 2. Lệnh :NpmRun (Quét package.json và hiện menu chọn script)
  vim.api.nvim_buf_create_user_command(0, "NpmRun", function()
    local package_json = vim.fn.getcwd() .. "/package.json"
    if vim.fn.filereadable(package_json) == 0 then
      vim.notify("No package.json found", vim.log.levels.WARN)
      return
    end

    -- Đọc và parse package.json
    local content = vim.fn.readfile(package_json)
    local json = vim.json.decode(table.concat(content, ""))

    if not json.scripts then
      vim.notify("No scripts found in package.json", vim.log.levels.WARN)
      return
    end

    -- Tạo danh sách script để chọn
    local scripts = {}
    for name, cmd in pairs(json.scripts) do
      table.insert(scripts, { name = name, cmd = cmd })
    end

    -- Dùng Snacks.picker để chọn script đẹp mắt
    Snacks.picker.select(scripts, {
      prompt = "Run Script (" .. pm .. ")",
      format_item = function(item)
        return string.format("%-15s %s", item.name, item.cmd)
      end,
    }, function(item)
      if item then
        -- Chạy lệnh: npm run build, pnpm run dev, ...
        run_term(pm .. " run " .. item.name)
      end
    end)
  end, { desc = "Select and run package.json script" })

  -- 3. Lệnh :NodeRun (Chạy file hiện tại bằng node/bun/ts-node)
  vim.api.nvim_buf_create_user_command(0, "NodeRun", function()
    local file = vim.api.nvim_buf_get_name(0)
    local ext = vim.fn.fnamemodify(file, ":e")
    local cmd = ""

    if ext == "ts" or ext == "tsx" then
      if pm == "bun" then
        cmd = "bun run " .. file
      else
        -- Fallback nếu không có bun
        cmd = "npx ts-node " .. file
      end
    else
      cmd = "node " .. file
    end

    run_term(cmd)
  end, { desc = "Run current file with node/bun" })

  -- 4. Lệnh :TypeCheck (Chỉ dành cho TS)
  if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
    vim.api.nvim_buf_create_user_command(0, "TypeCheck", function()
      run_term("npx tsc --noEmit --pretty")
    end, { desc = "Run TypeScript type checking" })
  end
end

return M

```

## File: `lua/core/keymaps.lua`
```lua
-- ════════════════════════════════════════════════════════════════════════════
-- Essential Operations
-- ════════════════════════════════════════════════════════════════════════════

-- Save
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save File" })
vim.keymap.set({ "i", "x" }, "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save File" })

-- Quit
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit All" })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Highlight", silent = true })

-- ════════════════════════════════════════════════════════════════════════════
-- Window Navigation (no prefix for speed)
-- ════════════════════════════════════════════════════════════════════════════

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go Left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go Up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go Right" })

-- Window resizing
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Width" })

-- ════════════════════════════════════════════════════════════════════════════
-- Line Movement (Visual Mode)
-- ════════════════════════════════════════════════════════════════════════════

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Lines Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Lines Up" })

-- ════════════════════════════════════════════════════════════════════════════
-- Better Navigation
-- ════════════════════════════════════════════════════════════════════════════

-- Wrapped line navigation
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up (wrapped)" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down (wrapped)" })

-- Start/End of line (easier than ^ and $)
vim.keymap.set({ "n", "x", "o" }, "H", "^", { desc = "Start of Line" })
vim.keymap.set({ "n", "x", "o" }, "L", "g_", { desc = "End of Line" })

-- Keep search results centered
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev Match (centered)" })
vim.keymap.set("n", "*", "*zzzv", { desc = "Search Word (centered)" })
vim.keymap.set("n", "#", "#zzzv", { desc = "Search Word Back (centered)" })

-- Buffer navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- ════════════════════════════════════════════════════════════════════════════
-- Better Editing
-- ════════════════════════════════════════════════════════════════════════════

-- Better indenting (stay in visual mode)
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

-- Paste over selection without yanking
vim.keymap.set("v", "p", '"_dP', { desc = "Paste (no yank)" })

-- Yank block
vim.keymap.set("n", "YY", "va{Vy", { desc = "Yank Block {}" })

-- Split line (opposite of J)
vim.keymap.set(
  "n",
  "X",
  ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>",
  { desc = "Split Line", silent = true }
)

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })

-- ════════════════════════════════════════════════════════════════════════════
-- Insert Mode Escapes
-- ════════════════════════════════════════════════════════════════════════════

vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit Insert" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert" })

-- ════════════════════════════════════════════════════════════════════════════
-- Terminal Mode
-- ════════════════════════════════════════════════════════════════════════════

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go Left" })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go Down" })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go Up" })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go Right" })

```

## File: `lua/core/options.lua`
```lua
-- ============================================================================
-- Leader Keys
-- ============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- Disable Built-in Plugins
-- ============================================================================
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ============================================================================
-- Disable Providers (silence health check warnings)
-- ============================================================================
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- ============================================================================
-- Editor Behavior
-- ============================================================================
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.updatetime = 100
vim.opt.timeoutlen = 1000
vim.opt.confirm = true
vim.opt.autoread = true

-- ============================================================================
-- UI/Display
-- ============================================================================
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes:1"
vim.opt.cursorline = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.ruler = true
vim.opt.showtabline = 0
vim.opt.cmdheight = 1
vim.opt.pumheight = 10
vim.opt.fillchars = { eob = " " }
vim.o.winborder = "rounded"

-- ============================================================================
-- Search
-- ============================================================================
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ============================================================================
-- Indentation
-- ============================================================================
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- ============================================================================
-- Splits
-- ============================================================================
vim.opt.splitbelow = true
vim.opt.splitright = true

-- ============================================================================
-- Files
-- ============================================================================
vim.opt.fileencoding = "utf-8"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- ============================================================================
-- Completion
-- ============================================================================
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.conceallevel = 0

-- ============================================================================
-- Other
-- ============================================================================
vim.opt.title = true
vim.opt.guifont = "monospace:h17"

-- ============================================================================
-- Filetype Detection
-- ============================================================================
vim.filetype.add({
    extension = {
        env = "dotenv",
    },
    filename = {
        [".env"] = "dotenv",
        ["env"] = "dotenv",
    },
    pattern = {
        ["[jt]sconfig.*.json"] = "jsonc",
        ["%.env%.[%w_.-]+"] = "dotenv",
    },
})

```

## File: `lua/core/utils.lua`
```lua
local M = {}

M.toggle_go_test = function()
    -- Get the current buffer's file name
    local current_file = vim.fn.expand("%:p")
    if string.match(current_file, "_test.go$") then
        -- If the current file ends with '_test.go', try to find the corresponding non-test file
        local non_test_file = string.gsub(current_file, "_test.go$", ".go")
        if vim.fn.filereadable(non_test_file) == 1 then
            -- Open the corresponding non-test file if it exists
            vim.cmd.edit(non_test_file)
        else
            print("No corresponding non-test file found")
        end
    else
        -- If the current file is a non-test file, try to find the corresponding test file
        local test_file = string.gsub(current_file, ".go$", "_test.go")
        if vim.fn.filereadable(test_file) == 1 then
            -- Open the corresponding test file if it exists
            vim.cmd.edit(test_file)
        else
            print("No corresponding test file found")
        end
    end
end

-- Get line numbers for highlighted lines in visual mode
M.get_highlighted_line_numbers = function()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    if start_line == 0 or end_line == 0 then
        print("No visual selection found")
        return
    end

    -- Ensure start_line is always less than or equal to end_line
    if start_line > end_line then
        start_line, end_line = end_line, start_line
    end

    local line_numbers = {}
    for i = start_line, end_line do
        table.insert(line_numbers, i)
    end

    local result
    if start_line == end_line then
        -- Single line: L80
        result = string.format("L%d", start_line)
    else
        -- Multiple lines: L80-85
        result = string.format("L%d-%d", start_line, end_line)
    end

    print("Line numbers: " .. result)

    -- Copy to clipboard
    vim.fn.setreg("+", result)

    return line_numbers
end

-- Copy the current file path and line number to the clipboard, use GitHub URL if in a Git repository
M.copyFilePathAndLineNumber = function()
    local current_file = vim.fn.expand("%:p")
    local current_line = vim.fn.line(".")
    local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree"):match("true")

    if is_git_repo then
        local current_repo = vim.fn.systemlist("git remote get-url origin")[1]
        local current_branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]

        -- Convert Git URL to GitHub web URL format
        current_repo = current_repo:gsub("git@github.com:", "https://github.com/")
        current_repo = current_repo:gsub("%.git$", "")

        -- Remove leading system path to repository root
        local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        if repo_root then
            current_file = current_file:sub(#repo_root + 2)
        end

        local url = string.format("%s/blob/%s/%s#L%s", current_repo, current_branch, current_file, current_line)
        vim.fn.setreg("+", url)
        print("Copied to clipboard: " .. url)
    else
        -- If not in a Git directory, copy the full file path
        vim.fn.setreg("+", current_file .. "#L" .. current_line)
        print("Copied full path to clipboard: " .. current_file .. "#L" .. current_line)
    end
end

return M

```

## File: `lua/core/lazy.lua`
```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Bootstrap tree-sitter-cli if cargo is available
if vim.fn.executable("tree-sitter") == 0 and vim.fn.executable("cargo") == 1 then
  vim.notify("Installing tree-sitter-cli via cargo...", vim.log.levels.INFO)
  vim.fn.jobstart({ "cargo", "install", "--locked", "tree-sitter-cli" }, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("tree-sitter-cli installed successfully!", vim.log.levels.INFO)
      else
        vim.notify("Failed to install tree-sitter-cli", vim.log.levels.WARN)
      end
    end,
  })
end

require("lazy").setup({ import = "plugins" }, {
  install = {
    missing = true,
    -- colorscheme = { "gruvbox_material" },
    -- colorscheme = { "habamax" }
  },
  rocks = {
    enabled = false,
    hererocks = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  ui = {
    -- border = "rounded"
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

```

## File: `lua/core/autocmds.lua`
```lua
local api = vim.api

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- wrap words "softly" (no carriage return) in mail buffer
api.nvim_create_autocmd("Filetype", {
    pattern = "mail",
    callback = function()
        vim.opt.textwidth = 0
        vim.opt.wrapmargin = 0
        vim.opt.wrap = true
        vim.opt.linebreak = true
        vim.opt.columns = 80
        vim.opt.colorcolumn = "80"
    end,
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
})

-- go to last loc when opening a buffer
-- this mean that when you open a file, you will be at the last position
api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    pattern = "*",
    command = "set cursorline",
    group = cursorGrp,
})
api.nvim_create_autocmd(
    { "InsertEnter", "WinLeave" },
    { pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- Enable spell checking for certain file types
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.txt", "*.md", "*.tex" },
    callback = function()
        vim.opt.spell = true
        vim.opt.spelllang = "en"
    end,
})

-- close some filetypes with <q>
api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("close_with_q", { clear = true }),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- Resize neovim split when terminal is resized
api.nvim_create_autocmd("VimResized", {
    callback = function()
        vim.cmd("wincmd =")
    end,
})

-- Fix terraform and hcl comment string
api.nvim_create_autocmd("FileType", {
    group = api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
    pattern = { "terraform", "hcl" },
    callback = function(ev)
        vim.bo[ev.buf].commentstring = "# %s"
    end,
})

-- Check for external file changes (works with Claude Code)
api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, { -- CursorHold
    callback = function()
        if vim.fn.mode() ~= "c" then
            vim.cmd("checktime")
        end
    end,
})

```

## File: `lua/core/init.lua`
```lua
-- Core configuration loader
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lazy")

```

## File: `lua/plugins/formatting.lua`
```lua
-- Formatting: Conform.nvim configuration
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true }, function(err, did_edit)
                    if not err and did_edit then
                        vim.notify("Formatted", vim.log.levels.INFO)
                    end
                end)
            end,
            mode = { "n", "v" },
            desc = "Format",
        },
    },
    opts = {
        formatters_by_ft = {
            -- Go
            go = { "goimports", "gofmt" },

            -- Lua
            lua = { "stylua" },

            -- Web technologies
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },

            -- Python
            python = { "isort", "black" },

            -- PHP/Laravel
            php = { "pint" },

            -- Shell
            sh = { "shfmt" },
            bash = { "shfmt" },

            -- Other
            rust = { "rustfmt" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}

```

## File: `lua/plugins/editor.lua`
```lua
-- Editor: Navigation, text objects, pairs, statusline, and utilities
return {
  -- ════════════════════════════════════════════════════════════════════════════
  -- Flash (quick navigation)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Mini.nvim (text objects, surround, pairs, statusline, icons)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      require("mini.pairs").setup()

      local statusline = require("mini.statusline")
      statusline.setup({
        use_icons = vim.g.have_nerd_font,
        set_vim_settings = false,
      })
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Persistence (session management)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- VSCode-style diff viewer
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "esmuellert/vscode-diff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("codediff").setup({
        highlights = {
          line_insert = "#2a3325",
          line_delete = "#362c2e",
          char_insert = "#3d4f35",
          char_delete = "#4d3538",
        },
        keymaps = {
          view = {
            next_hunk = "]c",
            prev_hunk = "[c",
            next_file = "]f",
            prev_file = "[f",
          },
          explorer = {
            select = "<CR>",
            hover = "K",
            refresh = "R",
          },
        },
      })
    end,
  },
}

```

## File: `lua/plugins/tools.lua`
```lua
-- Tools: Notes, file creation, and custom utilities
return {
  -- ════════════════════════════════════════════════════════════════════════════
  -- Notes management
  -- ════════════════════════════════════════════════════════════════════════════
  -- {
  --   "adibhanna/nvim-notes",
  --   dependencies = { "MunifTanjim/nui.nvim" },
  --   config = function()
  --     require("nvim-notes").setup({
  --       vault_path = "~/notes",
  --     })
  --   end,
  -- },

  -- -- ════════════════════════════════════════════════════════════════════════════
  -- -- Quick file creation
  -- -- ════════════════════════════════════════════════════════════════════════════
  -- {
  --   "adibhanna/nvim-newfile.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim" },
  --   config = function()
  --     require("nvim-newfile").setup({
  --       notifications = {
  --         enabled = false,
  --       },
  --     })
  --   end,
  -- },
}

```

## File: `lua/plugins/coding.lua`
```lua
-- Coding: Completion, treesitter, and dev tools
return {
  -- ════════════════════════════════════════════════════════════════════════════
  -- Completion (blink.cmp)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "saghen/blink.cmp",
    version = "*",
    config = function()
      require("blink.cmp").setup({
        snippets = { preset = "default" },
        signature = { enabled = true },
        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "normal",
        },
        sources = {
          default = { "lazydev", "lsp", "path", "buffer", "snippets" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
            cmdline = {
              min_keyword_length = 2,
            },
          },
        },
        keymap = {
          preset = "default", -- Giữ các phím tắt mặc định khác

          -- Phím Enter: Chấp nhận gợi ý (và Auto-Import)
          -- Nếu không có menu thì xuống dòng (fallback)
          ["<CR>"] = { "accept", "fallback" },

          -- (Tùy chọn) Phím Tab để chọn
          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },

          -- Tắt Ctrl-f như ý bạn
          ["<C-f>"] = {},
        },
        cmdline = {
          enabled = false,
          completion = { menu = { auto_show = true } },
          keymap = {
            ["<CR>"] = { "accept_and_enter", "fallback" },
          },
        },
        completion = {
          menu = {
            border = "rounded",
            scrolloff = 1,
            scrollbar = false,
            draw = {
              padding = 1,
              gap = 1,
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "kind" },
                { "source_name" },
              },
            },
          },
          documentation = {
            window = {
              border = "rounded",
              scrollbar = false,
              winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
            },
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },
      })
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Treesitter
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup({
        -- Trên NixOS, nếu cài parser qua Nix thì để false, 
        -- nhưng vì ta đã có GCC trong core.nix, để true vẫn chạy tốt.
        ensure_installed = {
          "bash", "c", "go", "lua", "markdown", "rust", "typescript", "tsx", "javascript", "zig", "nix"
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },


  -- ════════════════════════════════════════════════════════════════════════════
  -- Lua development
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Autotags for HTML/JSX
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Comments
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  },
  { "joosepalviste/nvim-ts-context-commentstring", lazy = true },
}

```

## File: `lua/plugins/linting.lua`
```lua
-- Linting: nvim-lint configuration
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local lint_progress = {}

    -- ══════════════════════════════════════════════════════════════════════════
    -- Custom Linter Configurations
    -- ══════════════════════════════════════════════════════════════════════════

    -- Customize golangci-lint
    local golangcilint = lint.linters.golangcilint
    golangcilint.ignore_exitcode = true
    golangcilint.args = {
      "run",
      "--out-format=json",
      "--issues-exit-code=0",
    }

    -- Configure luacheck
    local luacheck = lint.linters.luacheck
    luacheck.args = {
      "--formatter",
      "plain",
      "--codes",
      "--ranges",
      "--filename",
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
      "-",
    }
    luacheck.stdin = true

    -- Configure eslint_d
    if lint.linters.eslint_d then
      lint.linters.eslint_d.args = {
        "--format",
        "json",
        "--stdin",
        "--stdin-filename",
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      }
    end

    -- Configure Laravel Pint (custom linter)
    lint.linters.pint = {
      name = "pint",
      cmd = "pint",
      stdin = false,
      args = { "--test", "--json" },
      stream = "stdout",
      ignore_exitcode = true,
      parser = function(output, bufnr)
        local diagnostics = {}
        if not output or output == "" then
          return diagnostics
        end

        local ok, decoded = pcall(vim.json.decode, output)
        if ok and decoded and decoded.files then
          for file, issues in pairs(decoded.files) do
            if type(issues) == "table" and #issues > 0 then
              for _, issue in ipairs(issues) do
                table.insert(diagnostics, {
                  lnum = issue.line and (issue.line - 1) or 0,
                  col = issue.column or 0,
                  message = issue.message or "Style issue",
                  severity = vim.diagnostic.severity.WARN,
                  source = "pint",
                })
              end
            end
          end
        elseif string.find(output, "FAIL") or string.find(output, "differs") then
          table.insert(diagnostics, {
            lnum = 0,
            col = 0,
            message = "Code style issues found - run formatter to fix",
            severity = vim.diagnostic.severity.WARN,
            source = "pint",
          })
        end
        return diagnostics
      end,
    }

    -- ══════════════════════════════════════════════════════════════════════════
    -- Linters by Filetype
    -- ══════════════════════════════════════════════════════════════════════════
    lint.linters_by_ft = {
      go = { "golangcilint" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },
      svelte = { "eslint_d" },
      html = { "htmlhint" },
      css = { "stylelint" },
      scss = { "stylelint" },
      less = { "stylelint" },
      lua = { "luacheck" },
      python = { "ruff", "mypy" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
      fish = { "fish" },
      php = { "phpstan" },
      blade = { "phpstan" },
      ruby = { "rubocop" },
      eruby = { "erb_lint" },
      rust = { "clippy" },
      yaml = { "yamllint" },
      ["yaml.docker-compose"] = { "yamllint" },
      json = { "jsonlint" },
      jsonc = { "jsonlint" },
      markdown = { "markdownlint" },
      dockerfile = { "hadolint" },
      terraform = { "tflint", "tfsec" },
      tf = { "tflint", "tfsec" },
      sql = { "sqlfluff" },
      proto = { "buf_lint" },
      make = { "checkmake" },
      c = { "cppcheck", "cpplint" },
      cpp = { "cppcheck", "cpplint" },
    }

    -- ══════════════════════════════════════════════════════════════════════════
    -- Performance Optimizations
    -- ══════════════════════════════════════════════════════════════════════════

    local debounce_timer = nil
    local function debounce_lint(ms)
      if debounce_timer then
        vim.fn.timer_stop(debounce_timer)
      end
      debounce_timer = vim.fn.timer_start(ms or 250, function()
        vim.schedule(function()
          lint.try_lint()
        end)
      end)
    end

    local function is_file_too_large()
      local max_size = 1024 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
      return ok and stats and stats.size > max_size
    end

    local function should_lint(bufnr)
      bufnr = bufnr or 0
      local buftype = vim.bo[bufnr].buftype
      if buftype ~= "" and buftype ~= "acwrite" then
        return false
      end
      if is_file_too_large() then
        return false
      end
      local ft = vim.bo[bufnr].filetype
      local linters = lint.linters_by_ft[ft]
      return linters and #linters > 0
    end

    -- ══════════════════════════════════════════════════════════════════════════
    -- Auto-lint Configuration
    -- ══════════════════════════════════════════════════════════════════════════
    local lint_augroup = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = lint_augroup,
      callback = function(args)
        if should_lint(args.buf) then
          if args.event == "BufWritePost" then
            lint.try_lint()
          else
            debounce_lint(100)
          end
        end
      end,
    })

    vim.api.nvim_create_autocmd({ "TextChanged" }, {
      group = lint_augroup,
      callback = function(args)
        if should_lint(args.buf) and vim.bo.filetype ~= "TelescopePrompt" then
          debounce_lint(1000)
        end
      end,
    })

    -- ══════════════════════════════════════════════════════════════════════════
    -- Commands and Keybindings
    -- ══════════════════════════════════════════════════════════════════════════

    vim.api.nvim_create_user_command("LintInfo", function()
      local ft = vim.bo.filetype
      local linters = lint.linters_by_ft[ft] or {}
      local running = lint_progress[vim.api.nvim_get_current_buf()] or false

      print(string.format("Filetype: %s", ft))
      print(
        string.format(
          "Configured linters: %s",
          #linters > 0 and table.concat(linters, ", ") or "none"
        )
      )
      print(string.format("Status: %s", running and "running..." or "idle"))

      local installed, missing = {}, {}
      for _, linter in ipairs(linters) do
        local cmd = lint.linters[linter] and lint.linters[linter].cmd
        if cmd then
          if vim.fn.executable(cmd) == 1 then
            table.insert(installed, linter)
          else
            table.insert(missing, linter)
          end
        end
      end
      if #installed > 0 then
        print(string.format("Installed: %s", table.concat(installed, ", ")))
      end
      if #missing > 0 then
        print(string.format("Missing: %s", table.concat(missing, ", ")))
      end
    end, { desc = "Show linting information" })

    vim.api.nvim_create_user_command("LintToggle", function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.b[bufnr].lint_enabled = not vim.b[bufnr].lint_enabled
      vim.notify(
        string.format("Linting %s", vim.b[bufnr].lint_enabled and "enabled" or "disabled"),
        vim.log.levels.INFO
      )
    end, { desc = "Toggle linting" })

    vim.keymap.set("n", "<leader>ll", function()
      if should_lint() then
        lint.try_lint()
        vim.notify("Linting...", vim.log.levels.INFO)
      else
        vim.notify("No linters configured", vim.log.levels.WARN)
      end
    end, { desc = "Lint" })

    vim.keymap.set("n", "<leader>lI", "<cmd>LintInfo<cr>", { desc = "Lint Info" })
    vim.keymap.set("n", "<leader>lL", "<cmd>LintToggle<cr>", { desc = "Toggle Lint" })

    vim.keymap.set("n", "<leader>lC", function()
      local ns = require("lint").get_namespace(vim.bo.filetype)
      vim.diagnostic.reset(ns)
      vim.notify("Lint cleared", vim.log.levels.INFO)
    end, { desc = "Clear Lint" })
  end,
}

```

## File: `lua/plugins/colorschemes.lua`
```lua
-- Colorschemes: Theme configurations
return {
  -- XÓA HOẶC COMMENT ĐOẠN NÀY ĐI
  -- {
  --   "f-person/auto-dark-mode.nvim",
  --   opts = {
  --     update_interval = 1000,
  --     set_dark_mode = function()
  --       require("yukinord").setup({ style = "dark" })
  --       vim.cmd([[colorscheme yukinord]])
  --     end,
  --     set_light_mode = function()
  --       require("yukinord").setup({ style = "light" })
  --       vim.cmd([[colorscheme yukinord]])
  --     end,
  --   },
  -- },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Yukinord (default)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "adibhanna/yukinord.nvim",
    lazy = true,
    -- dir = "~/Developer/opensource/yukinord/neovim",
    config = function()
      require("yukinord").setup({
        transparent = true,
        transparent_sidebar = true,
      })
      -- vim.cmd("colorscheme yukinord")
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Gruvbox Material
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "sainnhe/gruvbox-material",
    lazy = true, -- Quan trọng: Đảm bảo theme load ngay khi mở Nvim
    priority = 1000, -- Quan trọng: Load theme trước các plugin khác
    config = function()
      -- 1. Cấu hình các biến tùy chọn (Phải đặt TRƯỚC khi gọi colorscheme)

      -- Bật nền trong suốt (bỏ comment dòng dưới nếu muốn)
      -- vim.g.gruvbox_material_transparent_background = 1

      -- Các tùy chọn hiển thị của bạn
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_background = "hard" -- soft, medium, hard
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_float_style = "bright"
      vim.g.gruvbox_material_statusline_style = "mix"
      vim.g.gruvbox_material_cursor = "auto"

      -- Bật in đậm/in nghiêng (khuyên dùng)
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1

      -- 2. Kích hoạt theme (Đây là dòng quan trọng nhất)
      -- vim.cmd.colorscheme("gruvbox-material")
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Forest Night
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "adibhanna/forest-night.nvim",
    priority = 1000,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Catppuccin (with custom gruvbox-inspired colors)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "catppuccin/nvim",
    priority = 150,
    lazy = false,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        background = {
          light = "latte",
          dark = "mocha",
        },
        color_overrides = {
          latte = {
            rosewater = "#c14a4a",
            flamingo = "#c14a4a",
            red = "#c14a4a",
            maroon = "#c14a4a",
            pink = "#945e80",
            mauve = "#945e80",
            peach = "#c35e0a",
            yellow = "#b47109",
            green = "#6c782e",
            teal = "#4c7a5d",
            sky = "#4c7a5d",
            sapphire = "#4c7a5d",
            blue = "#45707a",
            lavender = "#45707a",
            text = "#654735",
            subtext1 = "#73503c",
            subtext0 = "#805942",
            overlay2 = "#8c6249",
            overlay1 = "#8c856d",
            overlay0 = "#a69d81",
            surface2 = "#bfb695",
            surface1 = "#d1c7a3",
            surface0 = "#e3dec3",
            base = "#f9f5d7",
            mantle = "#f0ebce",
            crust = "#e8e3c8",
          },
          -- Yukinord-inspired mocha (Nord-based dark theme)
          mocha = {
            -- Accent colors from Yukinord
            rosewater = "#d08770", -- orange variant
            flamingo = "#d08770", -- orange
            red = "#bf616a", -- yukinord red
            maroon = "#bf616a", -- yukinord red
            pink = "#b48ead", -- yukinord purple
            mauve = "#b48ead", -- yukinord purple
            peach = "#d08770", -- yukinord orange (strings)
            yellow = "#ebcb8b", -- yukinord yellow (functions, numbers)
            green = "#a3be8c", -- yukinord green (types)
            teal = "#8fbcbb", -- yukinord teal
            sky = "#88c0d0", -- yukinord cyan (keywords)
            sapphire = "#5e81ac", -- yukinord blue_bright (selection)
            blue = "#81a1c1", -- yukinord blue (info)
            lavender = "#88c0d0", -- yukinord cyan
            -- Foreground colors
            text = "#eceff4", -- yukinord fg0 (bright)
            subtext1 = "#e5e9f0", -- yukinord fg1
            subtext0 = "#d8dee9", -- yukinord fg2 (editor foreground)
            -- Overlay colors (muted)
            overlay2 = "#8d929c", -- yukinord fg3 (comments)
            overlay1 = "#7b8394", -- between fg3 and fg4
            overlay0 = "#616e88", -- yukinord fg4 (line numbers)
            -- Surface colors (backgrounds)
            surface2 = "#4c566a", -- yukinord bg5 (button secondary)
            surface1 = "#434c5e", -- yukinord bg4 (line highlight)
            surface0 = "#3b4252", -- yukinord border
            -- Base backgrounds
            base = "#1B212B", -- yukinord bg0 (editor background)
            mantle = "#14171d", -- yukinord bg1 (panel background)
            crust = "#0f1115", -- darker than bg1
          },
        },
        transparent_background = false,
        show_end_of_buffer = false,
        integration_default = false,
        no_bold = true,
        no_italic = true,
        no_underline = true,
        integrations = {
          blink_cmp = { style = "bordered" },
          snacks = { enabled = true },
          gitsigns = true,
          native_lsp = { enabled = true, inlay_hints = { background = true } },
          semantic_tokens = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
          fidget = true,
          mason = true,
          neotest = true,
          dap_ui = true,
        },
        highlight_overrides = {
          all = function(colors)
            return {
              -- Completion menu styling
              Pmenu = { bg = colors.mantle, fg = colors.text },
              PmenuSel = { bg = colors.surface0, fg = colors.text },
              PmenuSbar = { bg = colors.surface0 },
              PmenuThumb = { bg = colors.surface2 },
              PmenuExtra = { bg = colors.mantle, fg = colors.subtext1 },

              -- Floating windows
              NormalFloat = { bg = colors.mantle },
              FloatBorder = { bg = colors.mantle, fg = colors.surface2 },
              FloatTitle = { bg = colors.mantle, fg = colors.text },

              -- Blink.cmp specific highlighting
              BlinkCmpMenu = { bg = colors.mantle, fg = colors.text },
              BlinkCmpMenuBorder = { bg = colors.mantle, fg = colors.surface2 },
              BlinkCmpMenuSelection = { bg = colors.surface0, fg = colors.text },
              BlinkCmpScrollBarThumb = { bg = colors.surface2 },
              BlinkCmpScrollBarGutter = { bg = colors.surface0 },
              BlinkCmpLabel = { bg = colors.mantle, fg = colors.text },
              BlinkCmpLabelDeprecated = {
                bg = colors.mantle,
                fg = colors.overlay0,
                strikethrough = true,
              },
              BlinkCmpLabelDetail = { bg = colors.mantle, fg = colors.subtext1 },
              BlinkCmpLabelDescription = { bg = colors.mantle, fg = colors.subtext1 },
              BlinkCmpKind = { bg = colors.mantle, fg = colors.peach },
              BlinkCmpSource = { bg = colors.mantle, fg = colors.overlay1 },
              BlinkCmpGhostText = { fg = colors.overlay0, italic = true },
              BlinkCmpDoc = { bg = colors.mantle, fg = colors.text },
              BlinkCmpDocBorder = { bg = colors.mantle, fg = colors.surface2 },
              BlinkCmpDocSeparator = { bg = colors.mantle, fg = colors.surface1 },
              BlinkCmpDocCursorLine = { bg = colors.surface0 },
              BlinkCmpSignatureHelp = { bg = colors.mantle, fg = colors.text },
              BlinkCmpSignatureHelpBorder = { bg = colors.mantle, fg = colors.surface2 },
              BlinkCmpSignatureHelpActiveParameter = {
                bg = colors.surface0,
                fg = colors.peach,
                bold = true,
              },

              -- Snacks.nvim picker NvChad style
              SnacksPicker = { bg = colors.base },
              SnacksPickerBorder = { fg = colors.surface0, bg = colors.base },
              SnacksPickerPreview = { bg = colors.base },
              SnacksPickerPreviewBorder = { fg = colors.base, bg = colors.base },
              SnacksPickerPreviewTitle = { fg = colors.base, bg = colors.green },
              SnacksPickerBoxBorder = { fg = colors.base, bg = colors.base },
              SnacksPickerInputBorder = { fg = colors.surface2, bg = colors.base },
              SnacksPickerInputSearch = { fg = colors.text, bg = colors.base },
              SnacksPickerList = { bg = colors.base },
              SnacksPickerListBorder = { fg = colors.base, bg = colors.base },
              SnacksPickerListTitle = { fg = colors.base, bg = colors.base },

              -- Additional picker elements
              SnacksPickerDir = { fg = colors.blue },
              SnacksPickerFile = { fg = colors.text },
              SnacksPickerMatch = { fg = colors.peach, bold = true },
              SnacksPickerCursor = { bg = colors.surface0, fg = colors.text },
              SnacksPickerSelected = { bg = colors.surface0, fg = colors.text },
              SnacksPickerIcon = { fg = colors.blue },
              SnacksPickerSource = { fg = colors.overlay1 },
              SnacksPickerCount = { fg = colors.overlay1 },
              SnacksPickerFooter = { fg = colors.overlay1 },
              SnacksPickerHeader = { fg = colors.text, bold = true },
              SnacksPickerSpecial = { fg = colors.peach },
              SnacksPickerIndent = { fg = colors.surface1 },
              SnacksPickerMulti = { fg = colors.peach },
              SnacksPickerTitle = { fg = colors.text, bold = true },
              SnacksPickerPrompt = { fg = colors.text },

              -- Snacks core components
              SnacksNotifierNormal = { bg = colors.mantle, fg = colors.text },
              SnacksNotifierBorder = { bg = colors.mantle, fg = colors.surface2 },
              SnacksNotifierTitle = { bg = colors.mantle, fg = colors.text, bold = true },
              SnacksNotifierIcon = { bg = colors.mantle, fg = colors.blue },
              SnacksNotifierIconInfo = { bg = colors.mantle, fg = colors.blue },
              SnacksNotifierIconWarn = { bg = colors.mantle, fg = colors.yellow },
              SnacksNotifierIconError = { bg = colors.mantle, fg = colors.red },

              -- Snacks Dashboard
              SnacksDashboardNormal = { bg = colors.base, fg = colors.text },
              SnacksDashboardDesc = { bg = colors.base, fg = colors.subtext1 },
              SnacksDashboardFile = { bg = colors.base, fg = colors.text },
              SnacksDashboardDir = { bg = colors.base, fg = colors.blue },
              SnacksDashboardFooter = { bg = colors.base, fg = colors.overlay1 },
              SnacksDashboardHeader = { bg = colors.base, fg = colors.text, bold = true },
              SnacksDashboardIcon = { bg = colors.base, fg = colors.blue },
              SnacksDashboardKey = { bg = colors.base, fg = colors.peach },
              SnacksDashboardTerminal = { bg = colors.base, fg = colors.text },
              SnacksDashboardSpecial = { bg = colors.base, fg = colors.peach },

              -- Snacks Terminal
              SnacksTerminalNormal = { bg = colors.mantle, fg = colors.text },
              SnacksTerminalBorder = { bg = colors.mantle, fg = colors.surface2 },
              SnacksTerminalTitle = { bg = colors.mantle, fg = colors.text, bold = true },

              CmpItemMenu = { fg = colors.surface2 },
              CursorLineNr = { fg = colors.text },
              GitSignsChange = { fg = colors.peach },
              LineNr = { fg = colors.overlay0 },
              LspInfoBorder = { link = "FloatBorder" },
              VertSplit = { bg = colors.base, fg = colors.surface0 },
              WhichKeyFloat = { bg = colors.mantle },
              YankHighlight = { bg = colors.surface2 },
              FidgetTask = { fg = colors.subtext1 },
              FidgetTitle = { fg = colors.peach },

              IblIndent = { fg = colors.surface0 },
              IblScope = { fg = colors.overlay0 },

              -- Statusline (yukinord color #2B3442)
              StatusLine = { fg = colors.subtext0, bg = "#2B3442" },
              StatusLineNC = { fg = colors.subtext0, bg = "#2B3442" },

              -- Mini.statusline (all sections same yukinord color)
              MiniStatuslineModeNormal = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineModeInsert = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineModeVisual = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineModeReplace = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineModeCommand = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineModeOther = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineDevinfo = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineFilename = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineFileinfo = { fg = colors.subtext0, bg = "#2B3442" },
              MiniStatuslineInactive = { fg = colors.overlay0, bg = "#2B3442" },

              -- Yukinord-style syntax highlighting
              Boolean = { fg = colors.sky }, -- cyan for booleans
              Number = { fg = colors.yellow }, -- yellow for numbers
              Float = { fg = colors.yellow }, -- yellow for floats

              PreProc = { fg = colors.sky }, -- cyan for preprocessor
              PreCondit = { fg = colors.sky },
              Include = { fg = colors.sky },
              Define = { fg = colors.sky },
              Conditional = { fg = colors.mauve }, -- purple for control flow
              Repeat = { fg = colors.mauve },
              Keyword = { fg = colors.sky }, -- cyan for keywords
              Typedef = { fg = colors.green }, -- green for types
              Exception = { fg = colors.mauve }, -- purple for exceptions
              Statement = { fg = colors.sky }, -- cyan for statements

              Error = { fg = colors.red },
              StorageClass = { fg = colors.sky }, -- cyan
              Tag = { fg = colors.sky },
              Label = { fg = colors.sky },
              Structure = { fg = colors.green }, -- green for structures
              Operator = { fg = colors.subtext0 }, -- muted operators like yukinord
              Title = { fg = colors.sky },
              Special = { fg = colors.peach }, -- orange for special
              SpecialChar = { fg = colors.yellow },
              Type = { fg = colors.green }, -- green for types (like yukinord)
              Function = { fg = colors.yellow }, -- yellow for functions (like yukinord)
              Delimiter = { fg = colors.subtext0 }, -- muted delimiters
              Ignore = { fg = colors.overlay0 },
              Macro = { fg = colors.sky }, -- cyan for macros

              -- Yukinord-style Treesitter highlights
              TSAnnotation = { fg = colors.sky },
              TSAttribute = { fg = colors.sky },
              TSBoolean = { fg = colors.sky }, -- cyan for booleans
              TSCharacter = { fg = colors.yellow },
              TSCharacterSpecial = { link = "SpecialChar" },
              TSComment = { link = "Comment" },
              TSConditional = { fg = colors.mauve }, -- purple for control
              TSConstBuiltin = { fg = colors.sky }, -- cyan for builtin constants
              TSConstMacro = { fg = colors.sky },
              TSConstant = { fg = colors.sky }, -- cyan for constants
              TSConstructor = { fg = colors.green }, -- green for constructors
              TSDebug = { link = "Debug" },
              TSDefine = { link = "Define" },
              TSEnvironment = { link = "Macro" },
              TSEnvironmentName = { link = "Type" },
              TSError = { link = "Error" },
              TSException = { fg = colors.mauve }, -- purple for exceptions
              TSField = { fg = colors.subtext0 }, -- muted for fields
              TSFloat = { fg = colors.yellow }, -- yellow for numbers
              TSFuncBuiltin = { fg = colors.yellow },
              TSFuncMacro = { fg = colors.yellow },
              TSFunction = { fg = colors.yellow }, -- yellow for functions
              TSFunctionCall = { fg = colors.yellow },
              TSInclude = { fg = colors.sky }, -- cyan for imports
              TSKeyword = { fg = colors.sky }, -- cyan for keywords
              TSKeywordFunction = { fg = colors.sky },
              TSKeywordOperator = { fg = colors.subtext0 },
              TSKeywordReturn = { fg = colors.mauve }, -- purple for return
              TSLabel = { fg = colors.sky },
              TSLiteral = { link = "String" },
              TSMath = { fg = colors.subtext0 },
              TSMethod = { fg = colors.yellow }, -- yellow for methods
              TSMethodCall = { fg = colors.yellow },
              TSNamespace = { fg = colors.green }, -- green for namespaces
              TSNone = { fg = colors.text },
              TSNumber = { fg = colors.yellow }, -- yellow for numbers
              TSOperator = { fg = colors.subtext0 }, -- muted operators
              TSParameter = { fg = colors.subtext0 }, -- muted parameters
              TSParameterReference = { fg = colors.subtext0 },
              TSPreProc = { link = "PreProc" },
              TSProperty = { fg = colors.subtext0 }, -- muted properties
              TSPunctBracket = { fg = colors.subtext0 },
              TSPunctDelimiter = { link = "Delimiter" },
              TSPunctSpecial = { fg = colors.subtext0 },
              TSRepeat = { fg = colors.mauve }, -- purple for loops
              TSStorageClass = { fg = colors.sky },
              TSStorageClassLifetime = { fg = colors.sky },
              TSStrike = { fg = colors.overlay1 },
              TSString = { fg = colors.peach }, -- orange for strings
              TSStringEscape = { fg = colors.yellow },
              TSStringRegex = { fg = colors.yellow },
              TSStringSpecial = { link = "SpecialChar" },
              TSSymbol = { fg = colors.subtext0 },
              TSTag = { fg = colors.sky }, -- cyan for tags
              TSTagAttribute = { fg = colors.subtext0 },
              TSTagDelimiter = { fg = colors.subtext0 },
              TSText = { fg = colors.subtext0 },
              TSTextReference = { link = "Constant" },
              TSTitle = { link = "Title" },
              TSTodo = { link = "Todo" },
              TSType = { fg = colors.green }, -- green for types
              TSTypeBuiltin = { fg = colors.green },
              TSTypeDefinition = { fg = colors.green },
              TSTypeQualifier = { fg = colors.sky },
              TSURI = { fg = colors.sky, underline = true },
              TSVariable = { fg = colors.subtext0 }, -- muted variables
              TSVariableBuiltin = { fg = colors.sky }, -- cyan for builtins

              ["@annotation"] = { link = "TSAnnotation" },
              ["@attribute"] = { link = "TSAttribute" },
              ["@boolean"] = { link = "TSBoolean" },
              ["@character"] = { link = "TSCharacter" },
              ["@character.special"] = { link = "TSCharacterSpecial" },
              ["@comment"] = { link = "TSComment" },
              ["@conceal"] = { link = "Grey" },
              ["@conditional"] = { link = "TSConditional" },
              ["@constant"] = { link = "TSConstant" },
              ["@constant.builtin"] = { link = "TSConstBuiltin" },
              ["@constant.macro"] = { link = "TSConstMacro" },
              ["@constructor"] = { link = "TSConstructor" },
              ["@debug"] = { link = "TSDebug" },
              ["@define"] = { link = "TSDefine" },
              ["@error"] = { link = "TSError" },
              ["@exception"] = { link = "TSException" },
              ["@field"] = { link = "TSField" },
              ["@float"] = { link = "TSFloat" },
              ["@function"] = { link = "TSFunction" },
              ["@function.builtin"] = { link = "TSFuncBuiltin" },
              ["@function.call"] = { link = "TSFunctionCall" },
              ["@function.macro"] = { link = "TSFuncMacro" },
              ["@include"] = { link = "TSInclude" },
              ["@keyword"] = { link = "TSKeyword" },
              ["@keyword.function"] = { link = "TSKeywordFunction" },
              ["@keyword.operator"] = { link = "TSKeywordOperator" },
              ["@keyword.return"] = { link = "TSKeywordReturn" },
              ["@label"] = { link = "TSLabel" },
              ["@math"] = { link = "TSMath" },
              ["@method"] = { link = "TSMethod" },
              ["@method.call"] = { link = "TSMethodCall" },
              ["@namespace"] = { link = "TSNamespace" },
              ["@none"] = { link = "TSNone" },
              ["@number"] = { link = "TSNumber" },
              ["@operator"] = { link = "TSOperator" },
              ["@parameter"] = { link = "TSParameter" },
              ["@parameter.reference"] = { link = "TSParameterReference" },
              ["@preproc"] = { link = "TSPreProc" },
              ["@property"] = { link = "TSProperty" },
              ["@punctuation.bracket"] = { link = "TSPunctBracket" },
              ["@punctuation.delimiter"] = { link = "TSPunctDelimiter" },
              ["@punctuation.special"] = { link = "TSPunctSpecial" },
              ["@repeat"] = { link = "TSRepeat" },
              ["@storageclass"] = { link = "TSStorageClass" },
              ["@storageclass.lifetime"] = { link = "TSStorageClassLifetime" },
              ["@strike"] = { link = "TSStrike" },
              ["@string"] = { link = "TSString" },
              ["@string.escape"] = { link = "TSStringEscape" },
              ["@string.regex"] = { link = "TSStringRegex" },
              ["@string.special"] = { link = "TSStringSpecial" },
              ["@symbol"] = { link = "TSSymbol" },
              ["@tag"] = { link = "TSTag" },
              ["@tag.attribute"] = { link = "TSTagAttribute" },
              ["@tag.delimiter"] = { link = "TSTagDelimiter" },
              ["@text"] = { link = "TSText" },
              ["@text.danger"] = { link = "TSDanger" },
              ["@text.diff.add"] = { link = "diffAdded" },
              ["@text.diff.delete"] = { link = "diffRemoved" },
              ["@text.emphasis"] = { link = "TSEmphasis" },
              ["@text.environment"] = { link = "TSEnvironment" },
              ["@text.environment.name"] = { link = "TSEnvironmentName" },
              ["@text.literal"] = { link = "TSLiteral" },
              ["@text.math"] = { link = "TSMath" },
              ["@text.note"] = { link = "TSNote" },
              ["@text.reference"] = { link = "TSTextReference" },
              ["@text.strike"] = { link = "TSStrike" },
              ["@text.strong"] = { link = "TSStrong" },
              ["@text.title"] = { link = "TSTitle" },
              ["@text.todo"] = { link = "TSTodo" },
              ["@text.todo.checked"] = { link = "Green" },
              ["@text.todo.unchecked"] = { link = "Ignore" },
              ["@text.underline"] = { link = "TSUnderline" },
              ["@text.uri"] = { link = "TSURI" },
              ["@text.warning"] = { link = "TSWarning" },
              ["@todo"] = { link = "TSTodo" },
              ["@type"] = { link = "TSType" },
              ["@type.builtin"] = { link = "TSTypeBuiltin" },
              ["@type.definition"] = { link = "TSTypeDefinition" },
              ["@type.qualifier"] = { link = "TSTypeQualifier" },
              ["@uri"] = { link = "TSURI" },
              ["@variable"] = { link = "TSVariable" },
              ["@variable.builtin"] = { link = "TSVariableBuiltin" },

              ["@lsp.type.class"] = { link = "TSType" },
              ["@lsp.type.comment"] = { link = "TSComment" },
              ["@lsp.type.decorator"] = { link = "TSFunction" },
              ["@lsp.type.enum"] = { link = "TSType" },
              ["@lsp.type.enumMember"] = { link = "TSProperty" },
              ["@lsp.type.events"] = { link = "TSLabel" },
              ["@lsp.type.function"] = { link = "TSFunction" },
              ["@lsp.type.interface"] = { link = "TSType" },
              ["@lsp.type.keyword"] = { link = "TSKeyword" },
              ["@lsp.type.macro"] = { link = "TSConstMacro" },
              ["@lsp.type.method"] = { link = "TSMethod" },
              ["@lsp.type.modifier"] = { link = "TSTypeQualifier" },
              ["@lsp.type.namespace"] = { link = "TSNamespace" },
              ["@lsp.type.number"] = { link = "TSNumber" },
              ["@lsp.type.operator"] = { link = "TSOperator" },
              ["@lsp.type.parameter"] = { link = "TSParameter" },
              ["@lsp.type.property"] = { link = "TSProperty" },
              ["@lsp.type.regexp"] = { link = "TSStringRegex" },
              ["@lsp.type.string"] = { link = "TSString" },
              ["@lsp.type.struct"] = { link = "TSType" },
              ["@lsp.type.type"] = { link = "TSType" },
              ["@lsp.type.typeParameter"] = { link = "TSTypeDefinition" },
              ["@lsp.type.variable"] = { link = "TSVariable" },
            }
          end,
          latte = function(colors)
            return {
              IblIndent = { fg = colors.mantle },
              IblScope = { fg = colors.surface1 },
              LineNr = { fg = colors.surface1 },
            }
          end,
        },
      })

      vim.cmd("colorscheme catppuccin-mocha")
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Nordic
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").setup({
        bold_keywords = false,
        italic_comments = false,
        transparent = { bg = false, float = false },
        bright_border = false,
        reduced_blue = true,
        swap_backgrounds = false,
        cursorline = {
          bold = false,
          bold_number = true,
          theme = "dark",
          blend = 0.85,
        },
        noice = { style = "flat" },
        telescope = { style = "flat" },
        leap = { dim_backdrop = false },
        ts_context = { dark_background = true },
      })

      -- vim.cmd("colorscheme nordic")
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- GitHub Theme
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          compile_path = vim.fn.stdpath("cache") .. "/github-theme",
          compile_file_suffix = "_compiled",
          hide_end_of_buffer = true,
          hide_nc_statusline = true,
          transparent = false,
          terminal_colors = true,
          dim_inactive = false,
          module_default = true,
          styles = {
            comments = "NONE",
            functions = "NONE",
            keywords = "NONE",
            variables = "NONE",
            conditionals = "NONE",
            constants = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
          },
          inverse = { match_paren = false, visual = false, search = false },
          darken = { floats = true, sidebars = { enable = true, list = {} } },
        },
      })
    end,
  },
}

```

## File: `lua/plugins/lsp.lua`
```lua
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Hàm setup keymaps giữ nguyên logic cũ của bạn
      local function setup_keymaps(bufnr)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
        end
        map("n", "K", function()
          vim.lsp.buf.hover({ border = "rounded" })
        end, "Hover")
        map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
      end

      -- Attach handler
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          setup_keymaps(args.buf)
        end,
      })

      -- ════════════════════════════════════════════════════════════════════
      -- Setup các LSP trực tiếp (Vì chúng đã có sẵn trong PATH nhờ Nix)
      -- ════════════════════════════════════════════════════════════════════

      -- Servers chạy cấu hình mặc định
      local servers = {
        "gopls",
        "zls",
        "rust_analyzer",
        "pyright",
        "html",
        "cssls",
        "jsonls",
        "bashls",
        "nil_ls",
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({ capabilities = capabilities })
      end

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })

      -- TypeScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        settings = {
          completions = { completeFunctionCalls = false },
        },
      })
    end,
  },
}

```

## File: `lua/plugins/snacks.lua`
```lua
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = true,
        float = true,
        max_width = 80,
        max_height = 40,
      },
    },
    indent = { enabled = false },
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    picker = {
      enabled = true,
      sources = {
        files = { hidden = true },
        gh_issue = {},
        gh_pr = {},
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = { notification = {} },
    gh = {},
  },
  keys = {
    -- ════════════════════════════════════════════════════════════════════
    -- Top-level (most used - quick access)
    -- ════════════════════════════════════════════════════════════════════
    {
      "<leader><space>",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Scratch Buffer",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer",
    },
    {
      "<leader>,",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },

    -- Terminal
    {
      "<C-/>",
      function()
        Snacks.terminal()
      end,
      desc = "Terminal",
      mode = { "n", "t" },
    },
    {
      "<C-_>",
      function()
        Snacks.terminal()
      end,
      desc = "which_key_ignore",
      mode = { "n", "t" },
    },

    -- Word navigation (LSP references)
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>b = Buffers
    -- ════════════════════════════════════════════════════════════════════
    {
      "<leader>bb",
      function()
        Snacks.picker.buffers({
          win = {
            input = {
              keys = { ["dd"] = "bufdelete", ["<C-d>"] = { "bufdelete", mode = { "n", "i" } } },
            },
            list = { keys = { ["dd"] = "bufdelete" } },
          },
        })
      end,
      desc = "Switch Buffer",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>bo",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Delete Other Buffers",
    },
    {
      "Q",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>c = Code
    -- ════════════════════════════════════════════════════════════════════
    -- ca (code action) - defined in lsp.lua
    -- cf (format) - defined in formatting.lua
    -- cr (rename symbol) - defined in lsp.lua
    -- cd (line diagnostic) - defined in lsp.lua

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>d = Diagnostics
    -- ════════════════════════════════════════════════════════════════════
    {
      "<leader>dd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Workspace Diagnostics",
    },
    {
      "<leader>db",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>dq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Quickfix List",
    },
    {
      "<leader>dl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "Location List",
    },

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>f = Files
    -- ════════════════════════════════════════════════════════════════════
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent Files",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Config Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Git Files",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Projects",
    },
    {
      "<leader>fR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>g = Git
    -- ════════════════════════════════════════════════════════════════════
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Log",
    },
    {
      "<leader>gL",
      function()
        Snacks.picker.git_log_line()
      end,
      desc = "Log (line)",
    },
    {
      "<leader>gf",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = "Log (file)",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Status",
    },
    {
      "<leader>gS",
      function()
        Snacks.picker.git_stash()
      end,
      desc = "Stash",
    },
    {
      "<leader>gd",
      function()
        Snacks.picker.git_diff()
      end,
      desc = "Diff (picker)",
    },
    {
      "<leader>gc",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Checkout Branch",
    },
    {
      "<leader>go",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Open in Browser",
      mode = { "n", "v" },
    },
    -- GitHub
    {
      "<leader>gi",
      function()
        Snacks.picker.gh_issue()
      end,
      desc = "Issues",
    },
    {
      "<leader>gI",
      function()
        Snacks.picker.gh_issue({ state = "all" })
      end,
      desc = "Issues (all)",
    },
    {
      "<leader>gp",
      function()
        Snacks.picker.gh_pr()
      end,
      desc = "Pull Requests",
    },
    {
      "<leader>gP",
      function()
        Snacks.picker.gh_pr({ state = "all" })
      end,
      desc = "Pull Requests (all)",
    },
    -- Hunk operations defined in git.lua: gh, ga, gu, gr, gR, gB, gD

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>l = LSP
    -- ════════════════════════════════════════════════════════════════════
    {
      "<leader>ls",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "Document Symbols",
    },
    {
      "<leader>lS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "Workspace Symbols",
    },
    -- li (info), lr (restart), lh (hints) - defined in lsp.lua

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>n = Notifications
    -- ════════════════════════════════════════════════════════════════════
    {
      "<leader>nn",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>nd",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All",
    },

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>s = Search
    -- ════════════════════════════════════════════════════════════════════
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Word",
      mode = { "n", "x" },
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Buffers",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Jumps",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>s:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>s/",
      function()
        Snacks.picker.search_history()
      end,
      desc = "Search History",
    },
    {
      "<leader>sr",
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume Last",
    },
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>si",
      function()
        Snacks.picker.icons()
      end,
      desc = "Icons",
    },

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>u = UI / Toggles
    -- ════════════════════════════════════════════════════════════════════
    {
      "<leader>uC",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Colorschemes",
    },
    {
      "<leader>uz",
      function()
        Snacks.zen()
      end,
      desc = "Zen Mode",
    },
    {
      "<leader>uZ",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Zoom",
    },
    {
      "<leader>uN",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
      desc = "Neovim News",
    },
    -- Other toggles defined in init function below

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>w = Windows (verbose, but useful for discoverability)
    -- ════════════════════════════════════════════════════════════════════
    { "<leader>wd", "<C-w>c", desc = "Close Window" },
    { "<leader>ws", "<C-w>s", desc = "Split Horizontal" },
    { "<leader>wv", "<C-w>v", desc = "Split Vertical" },
    { "<leader>ww", "<C-w>w", desc = "Other Window" },
    { "<leader>w=", "<C-w>=", desc = "Equal Size" },
    {
      "<leader>wm",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Maximize",
    },

    -- ════════════════════════════════════════════════════════════════════
    -- g = Goto (LSP navigation via Snacks picker)
    -- ════════════════════════════════════════════════════════════════════
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Definition",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Declaration",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gi",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Implementation",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Type Definition",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Debug globals
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd

        -- Toggle mappings under <leader>u
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>ur")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.diagnostics():map("<leader>uD")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle
          .option("background", { off = "light", on = "dark", name = "Dark Background" })
          :map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ui")
        Snacks.toggle.dim():map("<leader>ud")
      end,
    })
  end,
}

```

## File: `lua/plugins/ui.lua`
```lua
-- UI: Which-key, diagnostics display, notifications, and visual enhancements
return {
  -- ════════════════════════════════════════════════════════════════════════════
  -- Which-key (keybinding help)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      delay = 250,
      sort = { "alphanum", "local", "order", "group", "mod" },
      icons = {
        mappings = false,
        rules = false,
        breadcrumb = "»",
        separator = "→",
        group = "+",
      },
      plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = false },
      },
      win = {
        border = "rounded",
        padding = { 1, 2 },
      },
      spec = {
        mode = { "n", "v" },
        -- Top-level quick access
        { "<leader><space>", desc = "Find Files" },
        { "<leader>/", desc = "Grep" },
        { "<leader>,", desc = "Buffers" },
        { "<leader>.", desc = "Scratch" },
        { "<leader>e", desc = "Explorer" },
        { "<leader>q", desc = "Quit" },
        { "<leader>Q", desc = "Quit All" },
        -- Main groups
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Diagnostics" },
        { "<leader>f", group = "Files" },
        { "<leader>g", group = "Git" },
        { "<leader>gh", group = "Hunks" },
        { "<leader>l", group = "LSP" },
        { "<leader>m", group = "Markdown" },
        { "<leader>n", group = "Notifications" },
        { "<leader>s", group = "Search" },
        { "<leader>u", group = "UI/Toggle" },
        { "<leader>w", group = "Windows" },
        -- Navigation groups
        { "[", group = "Prev" },
        { "]", group = "Next" },
        { "g", group = "Goto" },
        -- Surround (mini.surround)
        { "gs", group = "Surround" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps",
      },
      {
        "<leader>K",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "All Keymaps",
      },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Inline diagnostics (prettier diagnostic display)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "classic",
        transparent_bg = false,
        transparent_cursorline = false,
        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
          arrow = "NonText",
          background = "CursorLine",
          mixing_color = "None",
        },
        options = {
          show_source = { enabled = false, if_many = false },
          use_icons_from_diagnostic = false,
          set_arrow_to_diag_color = false,
          add_messages = true,
          throttle = 20,
          softwrap = 30,
          multilines = { enabled = false, always_show = false },
          show_all_diags_on_cursorline = false,
          enable_on_insert = false,
          enable_on_select = false,
          overflow = { mode = "wrap", padding = 0 },
          break_line = { enabled = false, after = 30 },
          format = nil,
          virt_texts = { priority = 2048 },
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },
          overwrite_events = nil,
        },
        disabled_ft = {},
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Fidget (LSP progress notifications)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Markdown Preview (browser-based with mermaid support)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    --build = "cd app && npm install",
    build = "cd app && npm install && git checkout yarn.lock",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_theme = "dark"
      -- Enable mermaid, katex, and other features
      vim.g.mkdp_preview_options = {
        mermaid = { theme = "dark" },
        katex = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
      }
    end,
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
        ft = "markdown",
      },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Render Markdown (in-buffer rendering)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    opts = {
      heading = {
        enabled = true,
        sign = false,
        icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
      },
      code = {
        enabled = true,
        sign = false,
        style = "full",
        left_pad = 1,
        right_pad = 1,
        border = "thin",
        language_pad = 1,
      },
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "☐ " },
        checked = { icon = "☑ " },
      },
      quote = { enabled = true, icon = "▎" },
      pipe_table = { enabled = true, style = "full" },
      callout = {
        note = { raw = "[!NOTE]", rendered = " Note", highlight = "RenderMarkdownInfo" },
        tip = { raw = "[!TIP]", rendered = " Tip", highlight = "RenderMarkdownSuccess" },
        important = {
          raw = "[!IMPORTANT]",
          rendered = " Important",
          highlight = "RenderMarkdownHint",
        },
        warning = { raw = "[!WARNING]", rendered = " Warning", highlight = "RenderMarkdownWarn" },
        caution = { raw = "[!CAUTION]", rendered = " Caution", highlight = "RenderMarkdownError" },
      },
    },
    keys = {
      {
        "<leader>mr",
        "<cmd>RenderMarkdown toggle<cr>",
        desc = "Render Markdown Toggle",
        ft = "markdown",
      },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Trouble (better diagnostics list)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    lazy = true,
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = require("trouble.sources.snacks").actions,
            win = {
              input = {
                keys = {
                  ["<c-t>"] = { "trouble_open", mode = { "n", "i" } },
                },
              },
            },
          },
        })
      end,
    },
    keys = {
      { "<leader>dt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble (workspace)" },
      {
        "<leader>dT",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Trouble (buffer)",
      },
      { "<leader>dL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>dQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
      {
        "<leader>lt",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP References (Trouble)",
      },
      { "<leader>lT", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    },
    config = function()
      require("trouble").setup({
        mode = "workspace_diagnostics",
        position = "bottom",
        height = 15,
        padding = false,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = { "<cr>", "<tab>" },
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = { "o" },
          toggle_mode = "m",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          close_folds = { "zM" },
          open_folds = { "zR" },
          toggle_fold = { "za" },
        },
        auto_jump = {},
        use_diagnostic_signs = true,
      })
    end,
  },
}

```

## File: `ftplugin/rust.lua`
```lua
-- ════════════════════════════════════════════════════════════════════════════
-- Rust Tools - Custom commands for Rust development
-- ════════════════════════════════════════════════════════════════════════════

local function notify(msg, level)
    vim.notify(msg, level or vim.log.levels.INFO)
end

local function run_cmd(cmd, opts)
    opts = opts or {}
    local on_exit = opts.on_exit or function() end
    local cwd = opts.cwd or vim.fn.getcwd()

    vim.system(cmd, { text = true, cwd = cwd }, function(result)
        vim.schedule(function()
            on_exit(result)
        end)
    end)
end

local function get_crate_root()
    local filepath = vim.api.nvim_buf_get_name(0)
    local dir = vim.fn.fnamemodify(filepath, ":h")
    while dir ~= "/" do
        if vim.fn.filereadable(dir .. "/Cargo.toml") == 1 then
            return dir
        end
        dir = vim.fn.fnamemodify(dir, ":h")
    end
    return vim.fn.getcwd()
end

-- ════════════════════════════════════════════════════════════════════════════
-- Build & Run
-- ════════════════════════════════════════════════════════════════════════════

-- CargoBuild: cargo build
vim.api.nvim_buf_create_user_command(0, "CargoBuild", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "cargo build " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo build" })

-- CargoBuildRelease: cargo build --release
vim.api.nvim_buf_create_user_command(0, "CargoBuildRelease", function()
    vim.cmd("split | terminal cargo build --release")
end, { desc = "cargo build --release" })

-- CargoRun: cargo run
vim.api.nvim_buf_create_user_command(0, "CargoRun", function(opts)
    local args = opts.args ~= "" and " -- " .. opts.args or ""
    local cmd_str = "cargo run" .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo run" })

-- CargoRunRelease: cargo run --release
vim.api.nvim_buf_create_user_command(0, "CargoRunRelease", function(opts)
    local args = opts.args ~= "" and " -- " .. opts.args or ""
    local cmd_str = "cargo run --release" .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo run --release" })

-- ════════════════════════════════════════════════════════════════════════════
-- Testing
-- ════════════════════════════════════════════════════════════════════════════

-- CargoTest: cargo test
vim.api.nvim_buf_create_user_command(0, "CargoTest", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "cargo test " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo test" })

-- CargoTestFunc: test function under cursor
vim.api.nvim_buf_create_user_command(0, "CargoTestFunc", function()
    local func_name = nil
    local node = vim.treesitter.get_node()
    while node do
        if node:type() == "function_item" then
            local name_node = node:field("name")[1]
            if name_node then
                func_name = vim.treesitter.get_node_text(name_node, 0)
                break
            end
        end
        node = node:parent()
    end

    if not func_name then
        notify("Cursor not in a function", vim.log.levels.WARN)
        return
    end

    local cmd_str = string.format("cargo test %s -- --exact --nocapture", func_name)
    vim.cmd("split | terminal " .. cmd_str)
end, { desc = "Test function under cursor" })

-- ════════════════════════════════════════════════════════════════════════════
-- Code Quality
-- ════════════════════════════════════════════════════════════════════════════

-- CargoCheck: cargo check
vim.api.nvim_buf_create_user_command(0, "CargoCheck", function()
    notify("Running: cargo check")
    run_cmd({ "cargo", "check", "--message-format=short" }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo check: OK")
            else
                notify("cargo check failed:\n" .. (result.stderr or result.stdout), vim.log.levels.WARN)
            end
        end,
    })
end, { desc = "cargo check" })

-- CargoClippy: cargo clippy
vim.api.nvim_buf_create_user_command(0, "CargoClippy", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "cargo clippy " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo clippy" })

-- CargoFmt: cargo fmt
vim.api.nvim_buf_create_user_command(0, "CargoFmt", function()
    notify("Running: cargo fmt")
    run_cmd({ "cargo", "fmt" }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                vim.cmd("checktime")
                notify("cargo fmt: completed")
            else
                notify("cargo fmt failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "cargo fmt" })

-- CargoFmtCheck: cargo fmt --check
vim.api.nvim_buf_create_user_command(0, "CargoFmtCheck", function()
    notify("Running: cargo fmt --check")
    run_cmd({ "cargo", "fmt", "--check" }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo fmt --check: OK")
            else
                notify("cargo fmt --check: formatting needed\n" .. (result.stdout or ""), vim.log.levels.WARN)
            end
        end,
    })
end, { desc = "cargo fmt --check" })

-- ════════════════════════════════════════════════════════════════════════════
-- Dependencies
-- ════════════════════════════════════════════════════════════════════════════

-- CargoAdd: cargo add
vim.api.nvim_buf_create_user_command(0, "CargoAdd", function(opts)
    if opts.args == "" then
        notify("Usage: CargoAdd <crate>", vim.log.levels.WARN)
        return
    end
    notify("Running: cargo add " .. opts.args)
    run_cmd({ "cargo", "add", opts.args }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("Added: " .. opts.args)
                vim.cmd("checktime")
            else
                notify("cargo add failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { nargs = "+", desc = "cargo add <crate>" })

-- CargoRemove: cargo remove
vim.api.nvim_buf_create_user_command(0, "CargoRemove", function(opts)
    if opts.args == "" then
        notify("Usage: CargoRemove <crate>", vim.log.levels.WARN)
        return
    end
    notify("Running: cargo remove " .. opts.args)
    run_cmd({ "cargo", "remove", opts.args }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("Removed: " .. opts.args)
                vim.cmd("checktime")
            else
                notify("cargo remove failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { nargs = 1, desc = "cargo remove <crate>" })

-- CargoUpdate: cargo update
vim.api.nvim_buf_create_user_command(0, "CargoUpdate", function()
    notify("Running: cargo update")
    run_cmd({ "cargo", "update" }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo update: completed")
                vim.cmd("checktime")
            else
                notify("cargo update failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "cargo update" })

-- CargoTree: cargo tree
vim.api.nvim_buf_create_user_command(0, "CargoTree", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "cargo tree " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo tree" })

-- ════════════════════════════════════════════════════════════════════════════
-- Documentation
-- ════════════════════════════════════════════════════════════════════════════

-- CargoDoc: cargo doc
vim.api.nvim_buf_create_user_command(0, "CargoDoc", function(opts)
    local open = opts.bang and " --open" or ""
    notify("Running: cargo doc" .. open)
    run_cmd({ "cargo", "doc", open ~= "" and "--open" or nil }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo doc: completed")
            else
                notify("cargo doc failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { bang = true, desc = "cargo doc (! to open)" })

-- RustDoc: open docs.rs for word under cursor
vim.api.nvim_buf_create_user_command(0, "RustDoc", function(opts)
    local crate = opts.args ~= "" and opts.args or vim.fn.expand("<cword>")
    local url = "https://docs.rs/" .. crate
    local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
    vim.fn.system({ open_cmd, url })
    notify("Opening: " .. url)
end, { nargs = "?", desc = "Open docs.rs for crate" })

-- ════════════════════════════════════════════════════════════════════════════
-- Project Management
-- ════════════════════════════════════════════════════════════════════════════

-- CargoNew: cargo new
vim.api.nvim_buf_create_user_command(0, "CargoNew", function(opts)
    if opts.args == "" then
        notify("Usage: CargoNew <name> [--lib]", vim.log.levels.WARN)
        return
    end
    notify("Running: cargo new " .. opts.args)
    run_cmd({ "cargo", "new", unpack(vim.split(opts.args, " ")) }, {
        on_exit = function(result)
            if result.code == 0 then
                notify("Created: " .. opts.args)
            else
                notify("cargo new failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { nargs = "+", desc = "cargo new <name>" })

-- CargoInit: cargo init
vim.api.nvim_buf_create_user_command(0, "CargoInit", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    notify("Running: cargo init " .. args)
    run_cmd({ "cargo", "init", unpack(vim.split(args, " ")) }, {
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo init: completed")
                vim.cmd("checktime")
            else
                notify("cargo init failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { nargs = "?", desc = "cargo init" })

-- CargoClean: cargo clean
vim.api.nvim_buf_create_user_command(0, "CargoClean", function()
    notify("Running: cargo clean")
    run_cmd({ "cargo", "clean" }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo clean: completed")
            else
                notify("cargo clean failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "cargo clean" })

-- ════════════════════════════════════════════════════════════════════════════
-- Utilities
-- ════════════════════════════════════════════════════════════════════════════

-- CargoExpand: cargo expand (requires cargo-expand)
vim.api.nvim_buf_create_user_command(0, "CargoExpand", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "cargo expand " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo expand (macro expansion)" })

-- CargoAudit: cargo audit (requires cargo-audit)
vim.api.nvim_buf_create_user_command(0, "CargoAudit", function()
    vim.cmd("split | terminal cargo audit")
end, { desc = "cargo audit (security vulnerabilities)" })

-- CargoOutdated: cargo outdated (requires cargo-outdated)
vim.api.nvim_buf_create_user_command(0, "CargoOutdated", function()
    vim.cmd("split | terminal cargo outdated")
end, { desc = "cargo outdated" })

-- CargoBench: cargo bench
vim.api.nvim_buf_create_user_command(0, "CargoBench", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "cargo bench " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo bench" })

-- ════════════════════════════════════════════════════════════════════════════
-- Navigation
-- ════════════════════════════════════════════════════════════════════════════

-- RustAlt: switch between source and test
vim.api.nvim_buf_create_user_command(0, "RustAlt", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local filename = vim.fn.fnamemodify(filepath, ":t")
    local dir = vim.fn.fnamemodify(filepath, ":h")

    -- Check if we're in a tests module or main source
    if filename == "mod.rs" and dir:match("/tests$") then
        -- In tests/mod.rs, go to lib.rs or main.rs
        local parent = vim.fn.fnamemodify(dir, ":h")
        local lib = parent .. "/lib.rs"
        local main = parent .. "/main.rs"
        if vim.fn.filereadable(lib) == 1 then
            vim.cmd("edit " .. lib)
        elseif vim.fn.filereadable(main) == 1 then
            vim.cmd("edit " .. main)
        else
            notify("No lib.rs or main.rs found", vim.log.levels.WARN)
        end
    elseif filename == "lib.rs" or filename == "main.rs" then
        -- Go to tests/mod.rs or create inline test module
        local tests_dir = dir .. "/tests"
        local tests_mod = tests_dir .. "/mod.rs"
        if vim.fn.filereadable(tests_mod) == 1 then
            vim.cmd("edit " .. tests_mod)
        else
            notify("No tests/mod.rs found. Consider inline #[cfg(test)] module.", vim.log.levels.INFO)
        end
    else
        notify("RustAlt works best from lib.rs/main.rs", vim.log.levels.INFO)
    end
end, { desc = "Switch between source and tests" })

-- ════════════════════════════════════════════════════════════════════════════
-- Cargo Subcommand Installation
-- ════════════════════════════════════════════════════════════════════════════

local cargo_tools = {
    { name = "cargo-expand", desc = "Macro expansion" },
    { name = "cargo-audit", desc = "Security audit" },
    { name = "cargo-outdated", desc = "Check outdated deps" },
    { name = "cargo-edit", desc = "Add/remove/upgrade deps" },
    { name = "cargo-watch", desc = "Watch for changes" },
    { name = "cargo-nextest", desc = "Better test runner" },
    { name = "cargo-flamegraph", desc = "Flamegraph profiling" },
}

local function install_cargo_tools_async(tools, index, on_complete)
    index = index or 1
    if index > #tools then
        on_complete()
        return
    end

    local tool = tools[index]
    notify(string.format("[%d/%d] Installing: %s", index, #tools, tool.name))

    vim.system({ "cargo", "install", tool.name }, { text = true }, function(result)
        vim.schedule(function()
            if result.code ~= 0 then
                notify(string.format("Failed to install %s: %s", tool.name, result.stderr or ""), vim.log.levels.ERROR)
            end
            install_cargo_tools_async(tools, index + 1, on_complete)
        end)
    end)
end

-- CargoInstallTools: install useful cargo subcommands
vim.api.nvim_buf_create_user_command(0, "CargoInstallTools", function()
    notify("Installing Cargo tools (this may take a few minutes)...")
    install_cargo_tools_async(cargo_tools, 1, function()
        notify("All Cargo tools installed!", vim.log.levels.INFO)
    end)
end, { desc = "Install useful cargo subcommands" })

-- CargoInstallTool: install a specific cargo tool
vim.api.nvim_buf_create_user_command(0, "CargoInstallTool", function(opts)
    if opts.args == "" then
        local tool_list = {}
        for _, t in ipairs(cargo_tools) do
            table.insert(tool_list, string.format("  %s - %s", t.name, t.desc))
        end
        notify("Available tools:\n" .. table.concat(tool_list, "\n"), vim.log.levels.INFO)
        return
    end
    notify("Installing: " .. opts.args .. "...")
    vim.system({ "cargo", "install", opts.args }, { text = true }, function(result)
        vim.schedule(function()
            if result.code == 0 then
                notify("Installed: " .. opts.args, vim.log.levels.INFO)
            else
                notify("Failed to install " .. opts.args .. ": " .. (result.stderr or ""), vim.log.levels.ERROR)
            end
        end)
    end)
end, {
    nargs = "?",
    complete = function()
        return vim.tbl_map(function(t) return t.name end, cargo_tools)
    end,
    desc = "Install a specific cargo tool"
})

```

## File: `ftplugin/typescript.lua`
```lua
require("utils.web_dev").setup_commands()

```

## File: `ftplugin/typescriptreact.lua`
```lua
require("utils.web_dev").setup_commands()

```

## File: `ftplugin/go.lua`
```lua
-- .config/nvim/ftplugin/go.lua
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- ════════════════════════════════════════════════════════════════════════════
-- Helpers & Utilities
-- ════════════════════════════════════════════════════════════════════════════

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "Go Tools" })
end

local function get_module_root()
  local filepath = vim.api.nvim_buf_get_name(0)
  local dir = vim.fn.fnamemodify(filepath, ":h")
  while dir ~= "/" do
    if vim.fn.filereadable(dir .. "/go.mod") == 1 then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return vim.fn.getcwd() -- Fallback
end

local function get_package_path()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath == "" then
    return "."
  end
  return vim.fn.fnamemodify(filepath, ":h")
end

-- Chạy lệnh trong Snacks Terminal (Cho các lệnh cần output dài hoặc tương tác)
local function run_in_terminal(cmd, opts)
  opts = opts or {}
  Snacks.terminal(cmd, {
    cwd = opts.cwd or get_module_root(),
    win = {
      position = "bottom",
      height = 0.4,
      border = "rounded",
      title = " Go Output ",
      title_pos = "center",
    },
    interactive = true, -- Giữ terminal mở sau khi chạy xong để xem log
    start_insert = false, -- Không tự động vào chế độ insert
  })
end

-- Chạy lệnh ngầm (Cho các lệnh automation: fmt, tags, mod tidy...)
local function run_async(cmd, opts)
  opts = opts or {}
  local on_exit = opts.on_exit or function() end
  local cwd = opts.cwd or get_module_root()

  vim.system(cmd, { text = true, cwd = cwd }, function(result)
    vim.schedule(function()
      on_exit(result)
    end)
  end)
end

-- ════════════════════════════════════════════════════════════════════════════
-- Build & Run
-- ════════════════════════════════════════════════════════════════════════════

-- GoBuild: go build (Dùng terminal để xem lỗi nếu có)
vim.api.nvim_buf_create_user_command(0, "GoBuild", function(opts)
  local args = opts.args ~= "" and opts.args or "./..."
  run_in_terminal("go build -v " .. args)
end, { nargs = "?", desc = "go build" })

-- GoRun: go run
vim.api.nvim_buf_create_user_command(0, "GoRun", function(opts)
  local args = opts.args ~= "" and opts.args or "."
  run_in_terminal("go run " .. args)
end, { nargs = "?", desc = "go run" })

-- GoGenerate: go generate
vim.api.nvim_buf_create_user_command(0, "GoGenerate", function(opts)
  local args = opts.args ~= "" and opts.args or "./..."
  notify("Running: go generate " .. args)
  run_async({ "go", "generate", args }, {
    on_exit = function(result)
      if result.code == 0 then
        notify("Generate completed")
        vim.cmd("checktime")
      else
        -- Nếu lỗi, hiện thông báo lỗi chi tiết
        notify("Generate failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
      end
    end,
  })
end, { nargs = "?", desc = "go generate" })

-- ════════════════════════════════════════════════════════════════════════════
-- Testing
-- ════════════════════════════════════════════════════════════════════════════

-- GoTest: go test
vim.api.nvim_buf_create_user_command(0, "GoTest", function(opts)
  local args = opts.args ~= "" and opts.args or "./..."
  run_in_terminal("go test -v " .. args)
end, { nargs = "?", desc = "go test" })

-- GoTestFunc: test function under cursor
vim.api.nvim_buf_create_user_command(0, "GoTestFunc", function()
  local func_name = nil
  local node = vim.treesitter.get_node()
  while node do
    if node:type() == "function_declaration" then
      local name_node = node:field("name")[1]
      if name_node then
        func_name = vim.treesitter.get_node_text(name_node, 0)
        break
      end
    end
    node = node:parent()
  end

  if not func_name or not func_name:match("^Test") then
    notify("Cursor not inside a Test function", vim.log.levels.WARN)
    return
  end

  -- Sử dụng regex ^Name$ để chạy chính xác test đó
  local pkg = get_package_path()
  run_in_terminal(string.format("go test -v -run ^%s$ %s", func_name, pkg))
end, { desc = "Test function under cursor" })

-- GoTestFile: test current package/file location
vim.api.nvim_buf_create_user_command(0, "GoTestFile", function()
  local pkg = get_package_path()
  run_in_terminal("go test -v " .. pkg)
end, { desc = "Test current package" })

-- GoCoverage: test with coverage and open HTML
vim.api.nvim_buf_create_user_command(0, "GoCoverage", function(opts)
  local args = opts.args ~= "" and opts.args or "./..."
  -- Chain commands: chạy test -> tạo profile -> mở html
  local cmd = "go test -coverprofile=coverage.out "
    .. args
    .. " && go tool cover -html=coverage.out"
  run_in_terminal(cmd)
end, { nargs = "?", desc = "go test with coverage" })

-- ════════════════════════════════════════════════════════════════════════════
-- Module Management
-- ════════════════════════════════════════════════════════════════════════════

-- GoModTidy
vim.api.nvim_buf_create_user_command(0, "GoModTidy", function()
  notify("Running: go mod tidy")
  run_async({ "go", "mod", "tidy" }, {
    on_exit = function(result)
      if result.code == 0 then
        notify("go mod tidy completed")
        vim.cmd("checktime") -- Reload buffer nếu file go.mod thay đổi
      else
        notify("go mod tidy failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
      end
    end,
  })
end, { desc = "go mod tidy" })

-- GoModInit
vim.api.nvim_buf_create_user_command(0, "GoModInit", function(opts)
  if opts.args == "" then
    notify("Usage: GoModInit <module-name>", vim.log.levels.WARN)
    return
  end
  notify("Running: go mod init " .. opts.args)
  run_async({ "go", "mod", "init", opts.args }, {
    cwd = vim.fn.getcwd(), -- Init thường chạy ở root folder hiện tại
    on_exit = function(result)
      if result.code == 0 then
        notify("go mod init completed")
        vim.cmd("checktime")
      else
        notify("go mod init failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
      end
    end,
  })
end, { nargs = 1, desc = "go mod init <module>" })

-- GoGet
vim.api.nvim_buf_create_user_command(0, "GoGet", function(opts)
  if opts.args == "" then
    notify("Usage: GoGet <package>", vim.log.levels.WARN)
    return
  end
  notify("Running: go get " .. opts.args)
  run_async({ "go", "get", opts.args }, {
    on_exit = function(result)
      if result.code == 0 then
        notify("Installed: " .. opts.args)
        vim.cmd("checktime")
      else
        notify("go get failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
      end
    end,
  })
end, { nargs = 1, desc = "go get <package>" })

-- ════════════════════════════════════════════════════════════════════════════
-- Code Tools
-- ════════════════════════════════════════════════════════════════════════════

-- GoVet
vim.api.nvim_buf_create_user_command(0, "GoVet", function(opts)
  local args = opts.args ~= "" and opts.args or "./..."
  -- Dùng terminal để dễ đọc danh sách lỗi nếu nhiều
  run_in_terminal("go vet " .. args)
end, { nargs = "?", desc = "go vet" })

-- GoLint (golangci-lint)
vim.api.nvim_buf_create_user_command(0, "GoLint", function(opts)
  local args = opts.args ~= "" and opts.args or "./..."
  run_in_terminal("golangci-lint run " .. args)
end, { nargs = "?", desc = "golangci-lint run" })

-- GoDoc
vim.api.nvim_buf_create_user_command(0, "GoDoc", function(opts)
  local target = opts.args
  if target == "" then
    target = vim.fn.expand("<cword>")
  end
  if target == "" then
    notify("Usage: GoDoc <symbol> or cursor on symbol", vim.log.levels.WARN)
    return
  end
  run_in_terminal("go doc " .. target)
end, { nargs = "?", desc = "go doc <symbol>" })

-- GoImpl
vim.api.nvim_buf_create_user_command(0, "GoImpl", function(opts)
  if opts.args == "" then
    notify(
      "Usage: GoImpl <recv> <interface> (e.g., GoImpl 's *Service' io.Reader)",
      vim.log.levels.WARN
    )
    return
  end
  if vim.fn.executable("impl") == 0 then
    notify("Tool 'impl' not found. Run :GoInstallBinaries", vim.log.levels.ERROR)
    return
  end

  local output = vim.fn.system("impl " .. opts.args)
  if vim.v.shell_error == 0 then
    local lines = vim.split(output, "\n")
    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, row, row, false, lines)
    -- Format lại code vừa chèn
    vim.cmd("silent! normal! ==")
    notify("Implementation inserted")
  else
    notify("impl failed: " .. output, vim.log.levels.ERROR)
  end
end, { nargs = "+", desc = "Generate interface implementation" })

-- GoIfErr
vim.api.nvim_buf_create_user_command(0, "GoIfErr", function()
  -- Check iferr tool
  if vim.fn.executable("iferr") == 1 then
    local pos = vim.fn.getcurpos()
    local byte_offset = vim.fn.line2byte(pos[2]) + pos[3] - 1
    local output = vim.fn.system(string.format("iferr -pos %d", byte_offset))

    if vim.v.shell_error == 0 and output ~= "" then
      local lines = vim.split(output, "\n")
      -- Remove empty last line from split
      if lines[#lines] == "" then
        table.remove(lines)
      end

      vim.api.nvim_buf_set_lines(0, pos[2], pos[2], false, lines)
      vim.cmd("silent! normal! ==")
      return
    end
  end

  -- Fallback simple template
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local lines = { "if err != nil {", "\treturn err", "}" }
  vim.api.nvim_buf_set_lines(0, row, row, false, lines)
  vim.cmd("silent! normal! ==")
end, { desc = "Insert if err != nil block" })

-- GoModernize
vim.api.nvim_buf_create_user_command(0, "GoModernize", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  vim.cmd("silent write")
  notify("GoModernize: running...")
  run_async({
    "go",
    "run",
    "golang.org/x/tools/gopls/internal/analysis/modernize/cmd/modernize@latest",
    "-fix",
    filepath,
  }, {
    on_exit = function(result)
      if result.code == 0 then
        vim.cmd("checktime")
        notify("GoModernize: completed")
      else
        notify("GoModernize failed: " .. (result.stderr or result.stdout), vim.log.levels.ERROR)
      end
    end,
  })
end, { desc = "Run gopls modernize -fix" })

-- GoFillStruct (Helper cho Code Action)
vim.api.nvim_buf_create_user_command(0, "GoFillStruct", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.title:match("Fill") ~= nil
    end,
    apply = true,
  })
end, { desc = "Fill struct fields" })

-- GoAddTags / GoRemoveTags
local function modify_tags(args, mode)
  local tags = args ~= "" and args or "json"
  if vim.fn.executable("gomodifytags") == 0 then
    notify("Tool 'gomodifytags' not found. Run :GoInstallBinaries", vim.log.levels.ERROR)
    return
  end

  local filepath = vim.api.nvim_buf_get_name(0)
  local line = vim.fn.line(".")
  vim.cmd("silent write")

  local flag = mode == "add" and "-add-tags" or "-remove-tags"
  local cmd = string.format("gomodifytags -file %s -line %d %s %s", filepath, line, flag, tags)

  local output = vim.fn.system(cmd)
  if vim.v.shell_error == 0 then
    vim.cmd("edit!")
    notify("Tags " .. (mode == "add" and "added: " or "removed: ") .. tags)
  else
    notify("gomodifytags failed: " .. output, vim.log.levels.ERROR)
  end
end

vim.api.nvim_buf_create_user_command(0, "GoAddTags", function(opts)
  modify_tags(opts.args, "add")
end, { nargs = "?", desc = "Add struct tags" })
vim.api.nvim_buf_create_user_command(0, "GoRemoveTags", function(opts)
  modify_tags(opts.args, "remove")
end, { nargs = "?", desc = "Remove struct tags" })

-- ════════════════════════════════════════════════════════════════════════════
-- Navigation
-- ════════════════════════════════════════════════════════════════════════════

local function alt_file(cmd)
  local filepath = vim.api.nvim_buf_get_name(0)
  local alt
  if filepath:match("_test%.go$") then
    alt = filepath:gsub("_test%.go$", ".go")
  else
    alt = filepath:gsub("%.go$", "_test.go")
  end
  if vim.fn.filereadable(alt) == 1 then
    vim.cmd(cmd .. " " .. alt)
  else
    notify("Alt file not found: " .. vim.fn.fnamemodify(alt, ":t"), vim.log.levels.WARN)
  end
end

vim.api.nvim_buf_create_user_command(0, "GoAlt", function()
  alt_file("edit")
end, { desc = "Switch test/source" })
vim.api.nvim_buf_create_user_command(0, "GoAltV", function()
  alt_file("vsplit")
end, { desc = "Switch test/source (vsplit)" })

-- ════════════════════════════════════════════════════════════════════════════
-- Tool Installation
-- ════════════════════════════════════════════════════════════════════════════

local go_tools = {
  { name = "goimports", url = "golang.org/x/tools/cmd/goimports@latest" },
  { name = "gomodifytags", url = "github.com/fatih/gomodifytags@latest" },
  { name = "impl", url = "github.com/josharian/impl@latest" },
  { name = "iferr", url = "github.com/koron/iferr@latest" },
  { name = "gotests", url = "github.com/cweill/gotests/gotests@latest" },
  { name = "golangci-lint", url = "github.com/golangci/golangci-lint/cmd/golangci-lint@latest" },
  { name = "dlv", url = "github.com/go-delve/delve/cmd/dlv@latest" },
  { name = "staticcheck", url = "honnef.co/go/tools/cmd/staticcheck@latest" },
  { name = "govulncheck", url = "golang.org/x/vuln/cmd/govulncheck@latest" },
}

local function install_tools_async(tools, index, action, on_complete)
  index = index or 1
  if index > #tools then
    on_complete()
    return
  end

  local tool = tools[index]
  notify(string.format("[%d/%d] %s: %s", index, #tools, action, tool.name))

  run_async({ "go", "install", tool.url }, {
    on_exit = function(result)
      if result.code ~= 0 then
        notify(
          string.format("Failed to install %s: %s", tool.name, result.stderr or ""),
          vim.log.levels.ERROR
        )
      end
      install_tools_async(tools, index + 1, action, on_complete)
    end,
  })
end

vim.api.nvim_buf_create_user_command(0, "GoInstallBinaries", function()
  notify("Installing Go binaries...")
  install_tools_async(go_tools, 1, "Installing", function()
    notify("All Go binaries installed!", vim.log.levels.INFO)
  end)
end, { desc = "Install all Go tools" })

vim.api.nvim_buf_create_user_command(0, "GoUpdateBinaries", function()
  notify("Updating Go binaries...")
  install_tools_async(go_tools, 1, "Updating", function()
    notify("All Go binaries updated!", vim.log.levels.INFO)
  end)
end, { desc = "Update all Go tools" })

```

## File: `ftplugin/javascript.lua`
```lua
require("utils.web_dev").setup_commands()

```

## File: `ftplugin/javascriptreact.lua`
```lua
require("utils.web_dev").setup_commands()

```

## File: `ftplugin/zig.lua`
```lua
-- ════════════════════════════════════════════════════════════════════════════
-- Zig Tools - Custom commands for Zig development
-- ════════════════════════════════════════════════════════════════════════════

local function notify(msg, level)
    vim.notify(msg, level or vim.log.levels.INFO)
end

local function run_cmd(cmd, opts)
    opts = opts or {}
    local on_exit = opts.on_exit or function() end
    local cwd = opts.cwd or vim.fn.getcwd()

    vim.system(cmd, { text = true, cwd = cwd }, function(result)
        vim.schedule(function()
            on_exit(result)
        end)
    end)
end

local function get_project_root()
    local filepath = vim.api.nvim_buf_get_name(0)
    local dir = vim.fn.fnamemodify(filepath, ":h")
    while dir ~= "/" do
        if vim.fn.filereadable(dir .. "/build.zig") == 1 then
            return dir
        end
        dir = vim.fn.fnamemodify(dir, ":h")
    end
    return vim.fn.getcwd()
end

-- ════════════════════════════════════════════════════════════════════════════
-- Build & Run
-- ════════════════════════════════════════════════════════════════════════════

-- ZigBuild: zig build
vim.api.nvim_buf_create_user_command(0, "ZigBuild", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "zig build " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "zig build" })

-- ZigBuildRelease: zig build -Doptimize=ReleaseFast
vim.api.nvim_buf_create_user_command(0, "ZigBuildRelease", function()
    vim.cmd("split | terminal zig build -Doptimize=ReleaseFast")
end, { desc = "zig build -Doptimize=ReleaseFast" })

-- ZigBuildSafe: zig build -Doptimize=ReleaseSafe
vim.api.nvim_buf_create_user_command(0, "ZigBuildSafe", function()
    vim.cmd("split | terminal zig build -Doptimize=ReleaseSafe")
end, { desc = "zig build -Doptimize=ReleaseSafe" })

-- ZigRun: zig build run
vim.api.nvim_buf_create_user_command(0, "ZigRun", function(opts)
    local args = opts.args ~= "" and " -- " .. opts.args or ""
    local cmd_str = "zig build run" .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "zig build run" })

-- ZigRunFile: zig run <current file>
vim.api.nvim_buf_create_user_command(0, "ZigRunFile", function(opts)
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
        notify("Buffer has no file path", vim.log.levels.ERROR)
        return
    end
    local args = opts.args ~= "" and " -- " .. opts.args or ""
    local cmd_str = "zig run " .. filepath .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "zig run <current file>" })

-- ════════════════════════════════════════════════════════════════════════════
-- Testing
-- ════════════════════════════════════════════════════════════════════════════

-- ZigTest: zig build test
vim.api.nvim_buf_create_user_command(0, "ZigTest", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "zig build test " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "zig build test" })

-- ZigTestFile: zig test <current file>
vim.api.nvim_buf_create_user_command(0, "ZigTestFile", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
        notify("Buffer has no file path", vim.log.levels.ERROR)
        return
    end
    local cmd_str = "zig test " .. filepath
    vim.cmd("split | terminal " .. cmd_str)
end, { desc = "zig test <current file>" })

-- ZigTestFilter: zig build test with filter
vim.api.nvim_buf_create_user_command(0, "ZigTestFilter", function(opts)
    if opts.args == "" then
        notify("Usage: ZigTestFilter <test_name>", vim.log.levels.WARN)
        return
    end
    local cmd_str = "zig build test -- --test-filter " .. opts.args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = 1, desc = "zig build test with filter" })

-- ════════════════════════════════════════════════════════════════════════════
-- Code Quality
-- ════════════════════════════════════════════════════════════════════════════

-- ZigFmt: zig fmt
vim.api.nvim_buf_create_user_command(0, "ZigFmt", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
        notify("Buffer has no file path", vim.log.levels.ERROR)
        return
    end
    notify("Running: zig fmt")
    run_cmd({ "zig", "fmt", filepath }, {
        on_exit = function(result)
            if result.code == 0 then
                vim.cmd("checktime")
                notify("zig fmt: completed")
            else
                notify("zig fmt failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "zig fmt <current file>" })

-- ZigFmtAll: zig fmt on all .zig files
vim.api.nvim_buf_create_user_command(0, "ZigFmtAll", function()
    notify("Running: zig fmt on project")
    run_cmd({ "zig", "fmt", "." }, {
        cwd = get_project_root(),
        on_exit = function(result)
            if result.code == 0 then
                vim.cmd("checktime")
                notify("zig fmt: completed")
            else
                notify("zig fmt failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "zig fmt on project" })

-- ZigFmtCheck: zig fmt --check
vim.api.nvim_buf_create_user_command(0, "ZigFmtCheck", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
        notify("Buffer has no file path", vim.log.levels.ERROR)
        return
    end
    notify("Running: zig fmt --check")
    run_cmd({ "zig", "fmt", "--check", filepath }, {
        on_exit = function(result)
            if result.code == 0 then
                notify("zig fmt --check: OK")
            else
                notify("zig fmt --check: formatting needed", vim.log.levels.WARN)
            end
        end,
    })
end, { desc = "zig fmt --check" })

-- ════════════════════════════════════════════════════════════════════════════
-- Project Management
-- ════════════════════════════════════════════════════════════════════════════

-- ZigInit: zig init
vim.api.nvim_buf_create_user_command(0, "ZigInit", function()
    notify("Running: zig init")
    run_cmd({ "zig", "init" }, {
        on_exit = function(result)
            if result.code == 0 then
                notify("zig init: completed")
                vim.cmd("checktime")
            else
                notify("zig init failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "zig init" })

-- ZigFetch: zig fetch (for build.zig.zon dependencies)
vim.api.nvim_buf_create_user_command(0, "ZigFetch", function(opts)
    if opts.args == "" then
        notify("Usage: ZigFetch <url>", vim.log.levels.WARN)
        return
    end
    notify("Running: zig fetch " .. opts.args)
    run_cmd({ "zig", "fetch", opts.args }, {
        cwd = get_project_root(),
        on_exit = function(result)
            if result.code == 0 then
                local hash = result.stdout:gsub("%s+", "")
                notify("Hash: " .. hash)
                -- Copy to clipboard
                vim.fn.setreg("+", hash)
                notify("Hash copied to clipboard")
            else
                notify("zig fetch failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { nargs = 1, desc = "zig fetch <url>" })

-- ════════════════════════════════════════════════════════════════════════════
-- Documentation & Help
-- ════════════════════════════════════════════════════════════════════════════

-- ZigDoc: open Zig documentation
vim.api.nvim_buf_create_user_command(0, "ZigDoc", function(opts)
    local query = opts.args ~= "" and opts.args or ""
    local url = "https://ziglang.org/documentation/master/"
    if query ~= "" then
        url = "https://ziglang.org/documentation/master/#" .. query
    end
    local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
    vim.fn.system({ open_cmd, url })
    notify("Opening: " .. url)
end, { nargs = "?", desc = "Open Zig documentation" })

-- ZigStdDoc: open Zig std lib documentation
vim.api.nvim_buf_create_user_command(0, "ZigStdDoc", function(opts)
    local query = opts.args ~= "" and opts.args or ""
    local url = "https://ziglang.org/documentation/master/std/"
    if query ~= "" then
        url = url .. "#" .. query
    end
    local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
    vim.fn.system({ open_cmd, url })
    notify("Opening: " .. url)
end, { nargs = "?", desc = "Open Zig std lib documentation" })

-- ZigHelp: zig help
vim.api.nvim_buf_create_user_command(0, "ZigHelp", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "zig help " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "zig help" })

-- ZigVersion: zig version
vim.api.nvim_buf_create_user_command(0, "ZigVersion", function()
    run_cmd({ "zig", "version" }, {
        on_exit = function(result)
            if result.code == 0 then
                notify("Zig version: " .. result.stdout:gsub("%s+", ""))
            else
                notify("Failed to get version", vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "zig version" })

-- ════════════════════════════════════════════════════════════════════════════
-- Compilation & Analysis
-- ════════════════════════════════════════════════════════════════════════════

-- ZigAst: show AST of current file
vim.api.nvim_buf_create_user_command(0, "ZigAst", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
        notify("Buffer has no file path", vim.log.levels.ERROR)
        return
    end
    local cmd_str = "zig ast-check " .. filepath
    vim.cmd("split | terminal " .. cmd_str)
end, { desc = "zig ast-check <current file>" })

-- ZigTranslateC: translate C header to Zig
vim.api.nvim_buf_create_user_command(0, "ZigTranslateC", function(opts)
    if opts.args == "" then
        notify("Usage: ZigTranslateC <header.h>", vim.log.levels.WARN)
        return
    end
    local cmd_str = "zig translate-c " .. opts.args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = 1, desc = "zig translate-c <header>" })

-- ════════════════════════════════════════════════════════════════════════════
-- Build Steps
-- ════════════════════════════════════════════════════════════════════════════

-- ZigBuildSteps: show available build steps
vim.api.nvim_buf_create_user_command(0, "ZigBuildSteps", function()
    vim.cmd("split | terminal zig build --help")
end, { desc = "Show available build steps" })

-- ZigBuildStep: run specific build step
vim.api.nvim_buf_create_user_command(0, "ZigBuildStep", function(opts)
    if opts.args == "" then
        notify("Usage: ZigBuildStep <step>", vim.log.levels.WARN)
        return
    end
    local cmd_str = "zig build " .. opts.args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = 1, desc = "zig build <step>" })

-- ════════════════════════════════════════════════════════════════════════════
-- Navigation
-- ════════════════════════════════════════════════════════════════════════════

-- ZigAlt: switch to/from test file
vim.api.nvim_buf_create_user_command(0, "ZigAlt", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local filename = vim.fn.fnamemodify(filepath, ":t:r")
    local dir = vim.fn.fnamemodify(filepath, ":h")

    -- Check if we're in a test file
    if filename:match("_test$") or filename == "test" then
        -- Try to find the source file
        local source = filepath:gsub("_test%.zig$", ".zig")
        if source == filepath then
            source = dir .. "/main.zig"
        end
        if vim.fn.filereadable(source) == 1 then
            vim.cmd("edit " .. source)
        else
            notify("Source file not found", vim.log.levels.WARN)
        end
    else
        -- Try to find the test file
        local test_file = filepath:gsub("%.zig$", "_test.zig")
        local test_dir = dir .. "/test.zig"
        if vim.fn.filereadable(test_file) == 1 then
            vim.cmd("edit " .. test_file)
        elseif vim.fn.filereadable(test_dir) == 1 then
            vim.cmd("edit " .. test_dir)
        else
            notify("Test file not found: " .. test_file, vim.log.levels.WARN)
        end
    end
end, { desc = "Switch between source and test file" })

-- ZigAltV: switch in vertical split
vim.api.nvim_buf_create_user_command(0, "ZigAltV", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local filename = vim.fn.fnamemodify(filepath, ":t:r")
    local dir = vim.fn.fnamemodify(filepath, ":h")

    if filename:match("_test$") or filename == "test" then
        local source = filepath:gsub("_test%.zig$", ".zig")
        if source == filepath then
            source = dir .. "/main.zig"
        end
        if vim.fn.filereadable(source) == 1 then
            vim.cmd("vsplit " .. source)
        else
            notify("Source file not found", vim.log.levels.WARN)
        end
    else
        local test_file = filepath:gsub("%.zig$", "_test.zig")
        if vim.fn.filereadable(test_file) == 1 then
            vim.cmd("vsplit " .. test_file)
        else
            notify("Test file not found: " .. test_file, vim.log.levels.WARN)
        end
    end
end, { desc = "Switch to alt file in vsplit" })

```

## File: `plugin/ft.lua`
```lua
-- if a file is a .env or .envrc file, set the filetype to sh
vim.filetype.add({
  filename = {
    [".env"] = "sh",
    [".envrc"] = "sh",
    ["*.env"] = "sh",
    ["*.envrc"] = "sh"
  }
})

```

## File: `init.lua`
```lua
require("core")

```

## File: `lazy-lock.json`
```json
{
  "Comment.nvim": { "branch": "master", "commit": "e30b7f2008e52442154b66f7c519bfd2f1e32acb" },
  "blink.cmp": { "branch": "main", "commit": "b19413d214068f316c78978b08264ed1c41830ec" },
  "catppuccin": { "branch": "main", "commit": "beaf41a30c26fd7d6c386d383155cbd65dd554cd" },
  "conform.nvim": { "branch": "master", "commit": "c2526f1cde528a66e086ab1668e996d162c75f4f" },
  "diffview.nvim": { "branch": "main", "commit": "4516612fe98ff56ae0415a259ff6361a89419b0a" },
  "fidget.nvim": { "branch": "main", "commit": "7fa433a83118a70fe24c1ce88d5f0bd3453c0970" },
  "flash.nvim": { "branch": "main", "commit": "fcea7ff883235d9024dc41e638f164a450c14ca2" },
  "forest-night.nvim": { "branch": "main", "commit": "d4cbe768d5044c06fbb9c0987d0518bac2699aae" },
  "github-theme": { "branch": "main", "commit": "c106c9472154d6b2c74b74565616b877ae8ed31d" },
  "gitsigns.nvim": { "branch": "main", "commit": "abf82a65f185bd54adc0679f74b7d6e1ada690c9" },
  "gruvbox-material": { "branch": "master", "commit": "790afe9dd085aa04eccd1da3626c5fa05c620e53" },
  "lazy.nvim": { "branch": "main", "commit": "306a05526ada86a7b30af95c5cc81ffba93fef97" },
  "lazydev.nvim": { "branch": "main", "commit": "5231c62aa83c2f8dc8e7ba957aa77098cda1257d" },
  "markdown-preview.nvim": { "branch": "master", "commit": "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee" },
  "mini.icons": { "branch": "main", "commit": "efc85e42262cd0c9e1fdbf806c25cb0be6de115c" },
  "mini.nvim": { "branch": "main", "commit": "c163117900c17d4abf30bc09452a261c8536060c" },
  "nordic.nvim": { "branch": "main", "commit": "962c717820a9d7201ef7622cf1e78bd57806bb7c" },
  "nui.nvim": { "branch": "main", "commit": "de740991c12411b663994b2860f1a4fd0937c130" },
  "nvim-lint": { "branch": "master", "commit": "ca6ea12daf0a4d92dc24c5c9ae22a1f0418ade37" },
  "nvim-lspconfig": { "branch": "master", "commit": "dec357ee48ff7e2e5b76898fd7c67b61a627d3ac" },
  "nvim-treesitter": { "branch": "main", "commit": "ec034813775d7e2974c7551c8c34499a828963f8" },
  "nvim-ts-autotag": { "branch": "main", "commit": "db15f2e0df2f5db916e511e3fffb682ef2f6354f" },
  "nvim-ts-context-commentstring": { "branch": "main", "commit": "1b212c2eee76d787bbea6aa5e92a2b534e7b4f8f" },
  "persistence.nvim": { "branch": "main", "commit": "b20b2a7887bd39c1a356980b45e03250f3dce49c" },
  "render-markdown.nvim": { "branch": "main", "commit": "c54380dd4d8d1738b9691a7c349ecad7967ac12e" },
  "snacks.nvim": { "branch": "main", "commit": "fe7cfe9800a182274d0f868a74b7263b8c0c020b" },
  "tiny-inline-diagnostic.nvim": { "branch": "main", "commit": "ecce93ff7db4461e942c03e0fcc64bd785df4057" },
  "trouble.nvim": { "branch": "main", "commit": "bd67efe408d4816e25e8491cc5ad4088e708a69a" },
  "vim-fugitive": { "branch": "master", "commit": "61b51c09b7c9ce04e821f6cf76ea4f6f903e3cf4" },
  "vim-rhubarb": { "branch": "master", "commit": "5496d7c94581c4c9ad7430357449bb57fc59f501" },
  "vscode-diff.nvim": { "branch": "main", "commit": "33562f6cddb4bd595938e24095348d9f67a027e5" },
  "which-key.nvim": { "branch": "main", "commit": "3aab2147e74890957785941f0c1ad87d0a44c15a" },
  "yukinord.nvim": { "branch": "main", "commit": "baa6d12e2b5d5be5618c67fb5835b35f0ab205ec" }
}

```

## File: `lazy-lock.bak.json`
```json
{
  "Comment.nvim": { "branch": "master", "commit": "e30b7f2008e52442154b66f7c519bfd2f1e32acb" },
  "blink.cmp": { "branch": "main", "commit": "b19413d214068f316c78978b08264ed1c41830ec" },
  "catppuccin": { "branch": "main", "commit": "beaf41a30c26fd7d6c386d383155cbd65dd554cd" },
  "conform.nvim": { "branch": "master", "commit": "c2526f1cde528a66e086ab1668e996d162c75f4f" },
  "diffview.nvim": { "branch": "main", "commit": "4516612fe98ff56ae0415a259ff6361a89419b0a" },
  "fidget.nvim": { "branch": "main", "commit": "7fa433a83118a70fe24c1ce88d5f0bd3453c0970" },
  "flash.nvim": { "branch": "main", "commit": "fcea7ff883235d9024dc41e638f164a450c14ca2" },
  "forest-night.nvim": { "branch": "main", "commit": "d4cbe768d5044c06fbb9c0987d0518bac2699aae" },
  "github-theme": { "branch": "main", "commit": "c106c9472154d6b2c74b74565616b877ae8ed31d" },
  "gitsigns.nvim": { "branch": "main", "commit": "abf82a65f185bd54adc0679f74b7d6e1ada690c9" },
  "gruvbox-material": { "branch": "master", "commit": "e4359a2f80ef7275b080be180841c62ca8322757" },
  "lazy.nvim": { "branch": "main", "commit": "306a05526ada86a7b30af95c5cc81ffba93fef97" },
  "lazydev.nvim": { "branch": "main", "commit": "5231c62aa83c2f8dc8e7ba957aa77098cda1257d" },
  "markdown-preview.nvim": { "branch": "master", "commit": "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee" },
  "mini.icons": { "branch": "main", "commit": "efc85e42262cd0c9e1fdbf806c25cb0be6de115c" },
  "mini.nvim": { "branch": "main", "commit": "c163117900c17d4abf30bc09452a261c8536060c" },
  "nordic.nvim": { "branch": "main", "commit": "962c717820a9d7201ef7622cf1e78bd57806bb7c" },
  "nui.nvim": { "branch": "main", "commit": "de740991c12411b663994b2860f1a4fd0937c130" },
  "nvim-lint": { "branch": "master", "commit": "ca6ea12daf0a4d92dc24c5c9ae22a1f0418ade37" },
  "nvim-lspconfig": { "branch": "master", "commit": "dec357ee48ff7e2e5b76898fd7c67b61a627d3ac" },
  "nvim-treesitter": { "branch": "main", "commit": "ec034813775d7e2974c7551c8c34499a828963f8" },
  "nvim-ts-autotag": { "branch": "main", "commit": "db15f2e0df2f5db916e511e3fffb682ef2f6354f" },
  "nvim-ts-context-commentstring": { "branch": "main", "commit": "1b212c2eee76d787bbea6aa5e92a2b534e7b4f8f" },
  "persistence.nvim": { "branch": "main", "commit": "b20b2a7887bd39c1a356980b45e03250f3dce49c" },
  "render-markdown.nvim": { "branch": "main", "commit": "c54380dd4d8d1738b9691a7c349ecad7967ac12e" },
  "snacks.nvim": { "branch": "main", "commit": "fe7cfe9800a182274d0f868a74b7263b8c0c020b" },
  "tiny-inline-diagnostic.nvim": { "branch": "main", "commit": "ecce93ff7db4461e942c03e0fcc64bd785df4057" },
  "trouble.nvim": { "branch": "main", "commit": "bd67efe408d4816e25e8491cc5ad4088e708a69a" },
  "vim-fugitive": { "branch": "master", "commit": "61b51c09b7c9ce04e821f6cf76ea4f6f903e3cf4" },
  "vim-rhubarb": { "branch": "master", "commit": "5496d7c94581c4c9ad7430357449bb57fc59f501" },
  "vscode-diff.nvim": { "branch": "main", "commit": "33562f6cddb4bd595938e24095348d9f67a027e5" },
  "which-key.nvim": { "branch": "main", "commit": "3aab2147e74890957785941f0c1ad87d0a44c15a" },
  "yukinord.nvim": { "branch": "main", "commit": "baa6d12e2b5d5be5618c67fb5835b35f0ab205ec" }
}

```

## File: `README.md`
```markdown
# Neovim Configuration

A minimal, fast Neovim configuration for Neovim 0.11+ with lazy-loading, LSP support, and intuitive keybindings.

---

## Installation

### 1. System Dependencies (Required)

```bash
# Core requirements
brew install neovim    # v0.11+ required
brew install git
brew install ripgrep   # Fast grep (used by picker)
brew install fd        # Fast find (used by picker)
brew install lazygit   # Git TUI
brew install node      # Required for some LSPs and tools
brew install npm       # Required for markdown-preview
```

### 2. Fonts (Required)

Install a [Nerd Font](https://www.nerdfonts.com/) for icons:

```bash
brew install --cask font-jetbrains-mono-nerd-font
# or
brew install --cask font-fira-code-nerd-font
```

Then set your terminal to use the installed font.

### 3. Language Toolchains (Install what you need)

```bash
# Go
brew install go
# After install, run :GoInstallBinaries in nvim

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# After install, run :CargoInstallTools in nvim

# Zig
brew install zig

# Python
brew install python
pip install pynvim  # Optional: for some plugins

# PHP
brew install php composer

# Lua (for luarocks, optional)
brew install lua luarocks
```

### 4. Optional Dependencies

```bash
# Markdown preview (browser-based)
# markdown-preview.nvim will auto-install, but needs npm

# Image rendering (optional)
brew install imagemagick ghostscript

# Mermaid diagrams (optional)
npm install -g @mermaid-js/mermaid-cli

# LaTeX rendering (optional)
brew install tectonic
```

### 5. Clone and Start

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

# Clone this config
git clone <your-repo> ~/.config/nvim

# Start Neovim - plugins will auto-install on first launch
nvim
```

### 6. Post-Install Steps

Run these commands in Neovim after first launch:

```vim
" Wait for lazy.nvim to finish installing plugins, then:

" Generate help tags
:helptags ALL

" Install treesitter parsers (auto-installs, but can force)
:TSUpdate

" Check health
:checkhealth

" For Go development
:GoInstallBinaries

" For Rust development
:CargoInstallTools

" Build markdown-preview (if not auto-built)
:Lazy build markdown-preview.nvim
```

### Verify Installation

```vim
:checkhealth
```

All checks should pass. Common fixes:

- Missing CLI tools: `brew install <tool>`
- Treesitter errors: `:TSUpdate`
- LSP not working: `:LspInfo` and `:Mason`

---

## What Gets Auto-Installed

### Via Mason (LSP/Linters/Formatters)

| Category        | Tools                                                                                                                     |
| --------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **LSP Servers** | lua_ls, gopls, zls, ts_ls, rust-analyzer, intelephense, bashls, pyright, cssls, html, jsonls, yamlls                      |
| **Linters**     | eslint_d, luacheck, golangci-lint, shellcheck, markdownlint, yamllint, jsonlint, htmlhint, stylelint, phpstan, ruff, mypy |
| **Formatters**  | stylua, goimports, prettier, black, isort, shfmt, pint                                                                    |

### Via Treesitter

Parsers for: bash, c, css, go, html, javascript, json, latex, lua, markdown, php, python, rust, scss, svelte, terraform, tsx, typescript, vim, vue, yaml, zig

---

## Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── core/
│   │   ├── init.lua         # Loads all core modules
│   │   ├── options.lua      # Neovim options
│   │   ├── keymaps.lua      # Core keybindings
│   │   ├── autocmds.lua     # Auto commands
│   │   ├── lazy.lua         # Plugin manager bootstrap
│   │   └── utils.lua        # Utility functions
│   └── plugins/
│       ├── coding.lua       # Completion, treesitter
│       ├── colorschemes.lua # Themes
│       ├── editor.lua       # Flash, mini.nvim, persistence
│       ├── formatting.lua   # Conform.nvim (format on save)
│       ├── git.lua          # Gitsigns, fugitive, diffview
│       ├── linting.lua      # nvim-lint
│       ├── lsp.lua          # LSP + Mason
│       ├── snacks.lua       # Picker, explorer, notifications
│       ├── tools.lua        # Notes, file creation
│       └── ui.lua           # Which-key, trouble, markdown
├── ftplugin/
│   ├── go.lua               # Go commands (:GoTest, :GoBuild, etc.)
│   ├── rust.lua             # Rust commands (:CargoRun, :CargoTest, etc.)
│   └── zig.lua              # Zig commands (:ZigBuild, :ZigTest, etc.)
└── doc/
    ├── go.txt               # :help go.txt
    ├── rust.txt             # :help rust.txt
    └── zig.txt              # :help zig.txt
```

---

## Keybindings

**Leader key:** `<Space>`

### Essential (No Prefix)

| Key                      | Action                 |
| ------------------------ | ---------------------- |
| `<C-s>`                  | Save file              |
| `<C-h/j/k/l>`            | Navigate windows       |
| `<C-Up/Down/Left/Right>` | Resize windows         |
| `<Esc>`                  | Clear search highlight |
| `jj` / `jk`              | Exit insert mode       |
| `H` / `L`                | Start/End of line      |
| `<S-h>` / `<S-l>`        | Prev/Next buffer       |
| `Q`                      | Delete buffer          |
| `K`                      | Hover documentation    |
| `s`                      | Flash jump             |
| `S`                      | Flash treesitter       |

### Quick Access (Leader)

| Key               | Action         |
| ----------------- | -------------- |
| `<leader><space>` | Find files     |
| `<leader>/`       | Grep           |
| `<leader>,`       | Switch buffer  |
| `<leader>.`       | Scratch buffer |
| `<leader>e`       | File explorer  |
| `<leader>q`       | Quit           |
| `<leader>Q`       | Quit all       |
| `<leader>?`       | Buffer keymaps |
| `<leader>K`       | All keymaps    |
| `<C-/>`           | Terminal       |

### Buffers (`<leader>b`)

| Key          | Action               |
| ------------ | -------------------- |
| `<leader>bb` | Switch buffer        |
| `<leader>bd` | Delete buffer        |
| `<leader>bo` | Delete other buffers |

### Code (`<leader>c`)

| Key          | Action               |
| ------------ | -------------------- |
| `<leader>ca` | Code action          |
| `<leader>cr` | Rename symbol        |
| `<leader>cd` | Line diagnostic      |
| `<leader>cf` | Format               |
| `<leader>cv` | Definition in vsplit |

### Diagnostics (`<leader>d`)

| Key          | Action                |
| ------------ | --------------------- |
| `<leader>dd` | Workspace diagnostics |
| `<leader>db` | Buffer diagnostics    |
| `<leader>dt` | Trouble (workspace)   |
| `<leader>dT` | Trouble (buffer)      |
| `<leader>dq` | Quickfix list         |
| `<leader>dl` | Location list         |

### Files (`<leader>f`)

| Key          | Action       |
| ------------ | ------------ |
| `<leader>ff` | Find files   |
| `<leader>fr` | Recent files |
| `<leader>fc` | Config files |
| `<leader>fg` | Git files    |
| `<leader>fp` | Projects     |
| `<leader>fR` | Rename file  |

### Git (`<leader>g`)

| Key          | Action          |
| ------------ | --------------- |
| `<leader>gg` | Lazygit         |
| `<leader>gs` | Status          |
| `<leader>gl` | Log             |
| `<leader>gL` | Log (line)      |
| `<leader>gf` | Log (file)      |
| `<leader>gd` | Diff (picker)   |
| `<leader>gD` | Diff HEAD       |
| `<leader>gc` | Checkout branch |
| `<leader>go` | Open in browser |
| `<leader>gb` | Blame line      |
| `<leader>gB` | Blame buffer    |
| `<leader>gR` | Reset buffer    |
| `<leader>gS` | Stage buffer    |
| `<leader>gi` | GitHub issues   |
| `<leader>gp` | GitHub PRs      |

### Git Hunks (`<leader>gh`)

| Key           | Action              |
| ------------- | ------------------- |
| `<leader>ghp` | Preview hunk        |
| `<leader>ghP` | Preview hunk inline |
| `<leader>ghs` | Stage hunk          |
| `<leader>ghu` | Undo stage hunk     |
| `<leader>ghr` | Reset hunk          |
| `]h` / `[h`   | Next/Prev hunk      |

### LSP (`<leader>l`)

| Key          | Action               |
| ------------ | -------------------- |
| `<leader>ls` | Document symbols     |
| `<leader>lS` | Workspace symbols    |
| `<leader>li` | LSP info             |
| `<leader>lr` | LSP restart          |
| `<leader>lh` | Toggle inlay hints   |
| `<leader>lt` | References (Trouble) |
| `<leader>lT` | Symbols (Trouble)    |

### Markdown (`<leader>m`)

| Key          | Action                  |
| ------------ | ----------------------- |
| `<leader>mp` | Preview in browser      |
| `<leader>mr` | Toggle render in buffer |

### Notifications (`<leader>n`)

| Key          | Action               |
| ------------ | -------------------- |
| `<leader>nn` | Notification history |
| `<leader>nd` | Dismiss all          |

### Search (`<leader>s`)

| Key          | Action            |
| ------------ | ----------------- |
| `<leader>sg` | Grep              |
| `<leader>sw` | Word under cursor |
| `<leader>sb` | Buffer lines      |
| `<leader>sB` | Grep buffers      |
| `<leader>sh` | Help              |
| `<leader>sm` | Marks             |
| `<leader>sj` | Jumps             |
| `<leader>sk` | Keymaps           |
| `<leader>sc` | Commands          |
| `<leader>s:` | Command history   |
| `<leader>s/` | Search history    |
| `<leader>sr` | Registers         |
| `<leader>sR` | Resume last       |
| `<leader>su` | Undo history      |

### UI/Toggles (`<leader>u`)

| Key          | Action                  |
| ------------ | ----------------------- |
| `<leader>us` | Toggle spelling         |
| `<leader>uw` | Toggle wrap             |
| `<leader>ur` | Toggle relative numbers |
| `<leader>ul` | Toggle line numbers     |
| `<leader>uD` | Toggle diagnostics      |
| `<leader>uc` | Toggle conceal          |
| `<leader>uT` | Toggle treesitter       |
| `<leader>ub` | Toggle background       |
| `<leader>uh` | Toggle inlay hints      |
| `<leader>ui` | Toggle indent guides    |
| `<leader>ud` | Toggle dim              |
| `<leader>uC` | Colorschemes            |
| `<leader>uz` | Zen mode                |
| `<leader>uZ` | Zoom                    |

### Windows (`<leader>w`)

| Key          | Action           |
| ------------ | ---------------- |
| `<leader>wd` | Close window     |
| `<leader>ws` | Split horizontal |
| `<leader>wv` | Split vertical   |
| `<leader>ww` | Other window     |
| `<leader>w=` | Equal size       |
| `<leader>wm` | Maximize         |

### Goto (`g`)

| Key  | Action          |
| ---- | --------------- |
| `gd` | Definition      |
| `gD` | Declaration     |
| `gr` | References      |
| `gi` | Implementation  |
| `gy` | Type definition |

### Navigation (`[` / `]`)

| Key         | Action               |
| ----------- | -------------------- |
| `[d` / `]d` | Prev/Next diagnostic |
| `[h` / `]h` | Prev/Next hunk       |
| `[b` / `]b` | Prev/Next buffer     |
| `[[` / `]]` | Prev/Next reference  |

### Editing

| Key       | Mode   | Action                     |
| --------- | ------ | -------------------------- |
| `J` / `K` | Visual | Move lines down/up         |
| `<` / `>` | Visual | Indent (stay selected)     |
| `p`       | Visual | Paste (no yank)            |
| `X`       | Normal | Split line                 |
| `YY`      | Normal | Yank block {}              |
| `n` / `N` | Normal | Next/Prev match (centered) |

### Surround (mini.surround)

| Key   | Action                   |
| ----- | ------------------------ |
| `gsa` | Add surrounding          |
| `gsd` | Delete surrounding       |
| `gsr` | Replace surrounding      |
| `gsf` | Find surrounding (right) |
| `gsF` | Find surrounding (left)  |

---

## Language-Specific Commands

### Go (`:help go.txt`)

| Command              | Action                     |
| -------------------- | -------------------------- |
| `:GoBuild`           | go build                   |
| `:GoRun`             | go run                     |
| `:GoTest`            | go test                    |
| `:GoTestFunc`        | Test function under cursor |
| `:GoTestFile`        | Test current package       |
| `:GoCoverage`        | Test with coverage         |
| `:GoModTidy`         | go mod tidy                |
| `:GoGet <pkg>`       | go get                     |
| `:GoVet`             | go vet                     |
| `:GoLint`            | golangci-lint              |
| `:GoDoc <sym>`       | go doc                     |
| `:GoImpl`            | Generate interface stubs   |
| `:GoIfErr`           | Insert if err != nil       |
| `:GoAddTags`         | Add struct tags            |
| `:GoAlt`             | Switch test/source         |
| `:GoInstallBinaries` | Install all Go tools       |

### Rust (`:help rust.txt`)

| Command              | Action                     |
| -------------------- | -------------------------- |
| `:CargoBuild`        | cargo build                |
| `:CargoBuildRelease` | cargo build --release      |
| `:CargoRun`          | cargo run                  |
| `:CargoTest`         | cargo test                 |
| `:CargoTestFunc`     | Test function under cursor |
| `:CargoCheck`        | cargo check                |
| `:CargoClippy`       | cargo clippy               |
| `:CargoFmt`          | cargo fmt                  |
| `:CargoAdd <crate>`  | cargo add                  |
| `:CargoDoc`          | cargo doc                  |
| `:RustDoc <crate>`   | Open docs.rs               |
| `:CargoInstallTools` | Install cargo subcommands  |

### Zig (`:help zig.txt`)

| Command            | Action                           |
| ------------------ | -------------------------------- |
| `:ZigBuild`        | zig build                        |
| `:ZigBuildRelease` | zig build -Doptimize=ReleaseFast |
| `:ZigRun`          | zig build run                    |
| `:ZigRunFile`      | zig run <current file>           |
| `:ZigTest`         | zig build test                   |
| `:ZigTestFile`     | zig test <current file>          |
| `:ZigFmt`          | zig fmt                          |
| `:ZigDoc`          | Open Zig docs                    |
| `:ZigAlt`          | Switch test/source               |

---

## Language Servers (Mason)

Auto-installed:

- **Go:** gopls
- **Rust:** rust-analyzer
- **Zig:** zls
- **Lua:** lua_ls
- **TypeScript:** ts_ls
- **Python:** pyright
- **PHP:** intelephense
- **Bash:** bashls
- **CSS/HTML/JSON/YAML:** vscode servers

## Formatters (Conform)

| Language                 | Formatter        |
| ------------------------ | ---------------- |
| Go                       | goimports, gofmt |
| Rust                     | rustfmt          |
| Zig                      | zigfmt           |
| Lua                      | stylua           |
| JS/TS/JSON/YAML/HTML/CSS | prettier         |
| Python                   | isort, black     |
| PHP                      | pint             |
| Shell                    | shfmt            |

Format on save is **enabled by default**.

## Linters (nvim-lint)

| Language | Linter        |
| -------- | ------------- |
| Go       | golangci-lint |
| JS/TS    | eslint_d      |
| Lua      | luacheck      |
| Python   | ruff, mypy    |
| PHP      | phpstan       |
| Shell    | shellcheck    |

---

## Health Check

```vim
:checkhealth
```

Common fixes:

- Missing tools: `brew install <tool>`
- Treesitter errors: `:TSUpdate`
- Go tools: `:GoInstallBinaries`
- Rust tools: `:CargoInstallTools`

## Colorscheme

Default: `yukinord`

Switch with `<leader>uC`

---

Always a WIP.

```


---

## Statistics
- **Total files found:** 0
- **Files processed:** 0
- **Files ignored:** 0

**Generation completed:** 2026-01-22 09:41:52
