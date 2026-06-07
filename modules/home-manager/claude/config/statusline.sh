#!/usr/bin/env bash
# Claude Code status line — Catppuccin Mocha powerline
# Distinct per-segment backgrounds (dark accent tints) + bright accent text.
# NOTE: Claude Code forces light text, so light backgrounds with dark text are
# unreadable — we use DARK tints of each accent as bg + the bright accent as fg.
# Responsive: drops low-priority segments as terminal width shrinks.

input=$(cat)

ESC=$'\e'
RESET=$'\e[0m'

CAP_L=$''    # left rounded cap
CAP_R=$''    # right rounded cap
BRANCH=$'\uf418'   # VCS branch (starship git_branch symbol)
CHIP=$''     # microchip (model)
ROBOT=$'\U000f1719'   # robot-happy (agent) — nf-md-robot-happy
FOLDER=$'\uf07c'   # folder-open (directory)
COIN=$'\uf155'     # dollar (cost) — fa-dollar
CLOCK=$'\uf017'    # clock (duration)
BOLT=$'\uf0e7'     # bolt (cache hit)

BOLD=$'\e[1m'

# Bright accent backgrounds (B_*) with dark text (FG_DARK) on top
B_BLUE="137;180;250"
B_PEACH="250;179;135"
B_GREEN="166;227;161"
B_YELLOW="249;226;175"
B_MAUVE="203;166;247"
B_TEAL="148;226;213"
B_RED="243;139;168"
B_LAV="180;190;254"
FG_DARK="30;30;46"      # #1e1e2e — text on bright pills
FG_DIM="108;112;134"    # #6c7086 — empty bar / dim detail on bright bg

# Terminal width — env first, then tty, fallback 120
WIDTH=${COLUMNS:-0}
[ "$WIDTH" -le 0 ] && WIDTH=$(tput cols 2>/dev/null </dev/tty || echo 0)
[ "$WIDTH" -le 0 ] && WIDTH=200

# Extract all fields in one jq call
IFS=$'\x1f' read -r MODEL DIR PCT USED_TOK TOTAL_TOK COST INPUT_TOK CACHE_READ CACHE_WRITE VIM_MODE DURATION_MS STYLE AGENT < <(
  printf '%s' "$input" | jq -r '[
    (.model.display_name // "claude"),
    (.workspace.current_dir // ""),
    ((.context_window.used_percentage // 0) | floor | tostring),
    ((.context_window.used_tokens // 0) | tostring),
    ((.context_window.total_tokens // 0) | tostring),
    (.cost.total_cost_usd // 0 | tostring),
    ((.cost.input_tokens // 0) | tostring),
    ((.cost.cache_read_tokens // 0) | tostring),
    ((.cost.cache_write_tokens // 0) | tostring),
    (.vim.mode // ""),
    (.cost.total_duration_ms // 0 | tostring),
    (.output_style.name // "default"),
    (.agent.name // "")
  ] | join("")'
)

# Shorten model: drop "Claude " prefix and "(…)" suffix
MODEL=$(printf '%s' "$MODEL" | sed -E 's/^Claude //; s/ *\([^)]*\)//')

# Git status — cached to avoid lag on large repos
CACHE_DIR_KEY=$(printf '%s' "$DIR" | md5 2>/dev/null || printf '%s' "$DIR" | md5sum 2>/dev/null | cut -d' ' -f1)
CACHE_FILE="/tmp/statusline-git-cache-${CACHE_DIR_KEY}"
CACHE_MAX_AGE=5

cache_is_stale() {
    [ ! -f "$CACHE_FILE" ] && return 0
    local age=$(( $(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0) ))
    [ "$age" -gt "$CACHE_MAX_AGE" ]
}

if cache_is_stale; then
    if [ -n "$DIR" ] && git -C "$DIR" rev-parse --git-dir > /dev/null 2>&1; then
        BRANCH_NAME=$(git -C "$DIR" branch --show-current 2>/dev/null)
        STAGED=$(git -C "$DIR" diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
        MODIFIED=$(git -C "$DIR" diff --numstat 2>/dev/null | wc -l | tr -d ' ')
        UNTRACKED=$(git -C "$DIR" ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
        printf '1|%s|%s|%s|%s\n' "$BRANCH_NAME" "$STAGED" "$MODIFIED" "$UNTRACKED" > "$CACHE_FILE"
    else
        printf '0||||\n' > "$CACHE_FILE"
    fi
fi

IFS='|' read -r IS_GIT BRANCH_NAME STAGED MODIFIED UNTRACKED < "$CACHE_FILE"

# CWD — last 2 components, ~ for home
CWD=""
if [ -n "$DIR" ]; then
    SHORT=$(printf '%s' "$DIR" | sed "s|^${HOME}|~|")
    CWD=$(printf '%s' "$SHORT" | awk -F/ '{
        n=NF
        if ($1=="~" && n==1) { print "~"; next }
        if (n<=2) { print $0; next }
        if ($1=="~") print "~/" $(NF-1) "/" $NF
        else         print "…/" $(NF-1) "/" $NF
    }')
    [ ${#CWD} -gt 24 ] && CWD="…${CWD: -21}"
fi

# Responsive breakpoints
show_bar=0;      [ "$WIDTH" -ge 45 ] && show_bar=1
show_dir=0;      [ "$WIDTH" -ge 50 ] && show_dir=1
show_duration=0; [ "$WIDTH" -ge 55 ] && show_duration=1
show_cost=0;     [ "$WIDTH" -ge 62 ] && show_cost=1
show_cache=0;    [ "$WIDTH" -ge 72 ] && show_cache=1
git_full=0;      [ "$WIDTH" -ge 58 ] && git_full=1

# Context background color (bright): mauve < 75, yellow 75-90, red > 90
CTX_BG="$B_MAUVE"
[ "${PCT:-0}" -ge 75 ] && CTX_BG="$B_YELLOW"
[ "${PCT:-0}" -ge 90 ] && CTX_BG="$B_RED"

# Context bar (filled dark, empty dim) on the bright context pill
BAR=""
if [ "$show_bar" = "1" ]; then
    FILLED=$((PCT * 10 / 100))
    EMPTY=$((10 - FILLED))
    [ "$FILLED" -gt 0 ] && BAR="$(printf "%${FILLED}s" | tr ' ' '━')"
    [ "$EMPTY"  -gt 0 ] && BAR="${BAR}${ESC}[38;2;${FG_DIM}m$(printf "%${EMPTY}s" | tr ' ' '─')${ESC}[38;2;${FG_DARK}m"
    BAR="${BAR} "
fi

# Cost — skip if zero or too narrow
COST_FMT=""
[ "$show_cost" = "1" ] && [ "$(awk -v c="$COST" 'BEGIN{print (c+0>0)}')" = "1" ] && \
    COST_FMT=$(awk -v c="$COST" 'BEGIN{printf "%.2f", c+0}')

# Duration — skip if under 1 min or too narrow
DURATION_FMT=""
[ "$show_duration" = "1" ] && [ "${DURATION_MS:-0}" -gt 60000 ] && \
    DURATION_FMT=$(awk -v ms="$DURATION_MS" 'BEGIN{
        s=int(ms/1000); m=int(s/60); h=int(m/60)
        if (h>0) printf "%dh%dm", h, m%60
        else     printf "%dm", m
    }')

# Cache hit ratio
CACHE_FMT=""
if [ "$show_cache" = "1" ] && [ "${CACHE_READ:-0}" -gt 0 ]; then
    TOTAL_IN=$((INPUT_TOK + CACHE_READ + CACHE_WRITE))
    [ "$TOTAL_IN" -gt 0 ] && \
        CACHE_FMT=$(awk -v r="$CACHE_READ" -v t="$TOTAL_IN" 'BEGIN{printf "%d%%", r*100/t}')
fi

# Git color — always green (like starship); +N ~N ?N counts show dirty state
GIT_BG="$B_GREEN"

# --- Build line via powerline segments (bright bg + dark text) ---
LINE=""
LAST_BG=""

# emit a segment in a connected bar: bg_rgb, text. Segments delimited only by the
# background color change; rounded caps only at the very ends.
emit_seg() {
    local bg="$1" text="$2"
    [ -z "$LAST_BG" ] && LINE="${LINE}${ESC}[38;2;${bg}m${CAP_L}"
    LINE="${LINE}${ESC}[48;2;${bg}m${ESC}[38;2;${FG_DARK}m${BOLD} ${text} "
    LAST_BG="$bg"
}

# Model — blue pill
emit_seg "$B_BLUE" "${CHIP} ${MODEL}"

# CWD — peach
[ "$show_dir" = "1" ] && [ -n "$CWD" ] && emit_seg "$B_PEACH" "${FOLDER} ${CWD}"

# Git — green/yellow
if [ "${IS_GIT:-0}" = "1" ]; then
    GIT_TEXT="${BRANCH} ${BRANCH_NAME}"
    if [ "$git_full" = "1" ]; then
        [ "${STAGED:-0}"    -gt 0 ] && GIT_TEXT="${GIT_TEXT} +${STAGED}"
        [ "${MODIFIED:-0}"  -gt 0 ] && GIT_TEXT="${GIT_TEXT} ~${MODIFIED}"
        [ "${UNTRACKED:-0}" -gt 0 ] && GIT_TEXT="${GIT_TEXT} ?${UNTRACKED}"
    fi
    emit_seg "$GIT_BG" "$GIT_TEXT"
fi

# Context — bar + % + cost/duration/cache, all dark text on bright pill
CTX_TEXT="${BAR}${PCT}%"
[ -n "$COST_FMT"     ] && CTX_TEXT="${CTX_TEXT}  ${COIN} ${COST_FMT}"
[ -n "$DURATION_FMT" ] && CTX_TEXT="${CTX_TEXT}  ${CLOCK} ${DURATION_FMT}"
[ -n "$CACHE_FMT"    ] && CTX_TEXT="${CTX_TEXT}  ${BOLT} ${CACHE_FMT}"
emit_seg "$CTX_BG" "$CTX_TEXT"

# Style — teal
[ -n "$STYLE" ] && [ "$STYLE" != "default" ] && emit_seg "$B_TEAL" "$STYLE"

# Agent — lavender
[ -n "$AGENT" ] && emit_seg "$B_LAV" "${ROBOT} ${AGENT}"

# Vim — green/yellow
if [ -n "$VIM_MODE" ]; then
    VIM_BG="$B_GREEN"; [ "$VIM_MODE" = "NORMAL" ] && VIM_BG="$B_YELLOW"
    emit_seg "$VIM_BG" "$VIM_MODE"
fi

# Right cap
LINE="${LINE}${RESET}${ESC}[38;2;${LAST_BG}m${CAP_R}${RESET}"

printf '%s\n' "$LINE"
