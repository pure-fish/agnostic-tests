# Remove terminal escape sequences so outputs compare as plain text.

# Also drops carriage returns and shift-in/out bytes that Fish's set_color emits.
strip_ansi() {
    sed -E $'s/\x1b\\[[0-9;?]*[A-Za-z]//g; s/\x1b\\([A-Z0-9]//g; s/\x1b\\][^\x07]*\x07//g; s/[\r\x0e\x0f]//g'
}

# Replace basic SGR colour codes with names, then strip anything left.
tokenize_ansi() {
    sed -E \
        -e $'s/\x1b\\[(0|39)?m/{normal}/g; s/\x1b\\(B//g' \
        -e $'s/\x1b\\[30m/{black}/g;  s/\x1b\\[31m/{red}/g;     s/\x1b\\[32m/{green}/g' \
        -e $'s/\x1b\\[33m/{yellow}/g; s/\x1b\\[34m/{blue}/g;    s/\x1b\\[35m/{magenta}/g' \
        -e $'s/\x1b\\[36m/{cyan}/g;   s/\x1b\\[37m/{white}/g;   s/\x1b\\[90m/{brblack}/g' \
        | strip_ansi
}
