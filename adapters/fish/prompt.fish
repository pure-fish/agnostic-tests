# Loads pure from $FISH_PURE_DIR, then prints one prompt.
set --prepend fish_function_path $FISH_PURE_DIR/functions

# Map the shared PURE_* env vars to Fish's pure_* globals.
# Globals win over the universal defaults set by conf.d/pure.fish.
for name in (set --names | string match --regex '^PURE_[A-Z0-9_]+$')
    set --global (string lower $name) $$name
end

source $FISH_PURE_DIR/conf.d/_pure_init.fish
source $FISH_PURE_DIR/conf.d/pure.fish

set --global CMD_DURATION $ADAPTER_COMMAND_DURATION
set --global _pure_fresh_session false # contract: prompt starts with a blank line

function _adapter_return --argument-names code
    return $code
end

_pure_prompt_new_line # normally triggered by the fish_prompt event
_adapter_return $ADAPTER_LAST_COMMAND_STATUS
fish_prompt
