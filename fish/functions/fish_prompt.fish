set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_color_branch 00ccff --bold
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate FF9999
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green

function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end


    if set -q VIRTUAL_ENV
        echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
    end

    # PWD
    set_color FF3333
    echo -n (hostname|cut -d . -f 1)"@"
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal

    printf '%s ' (__fish_git_prompt)

    if not test $last_status -eq 0
    set_color $fish_color_error
    end

    echo -n '$ '

    set_color normal
end

#function fish_prompt --description 'Write out the prompt'
#    # Just calculate this once, to save a few cycles when displaying the prompt
#    if not set -q __fish_prompt_hostname
#        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
#    end
#
#    set -l color_cwd
#    set -l suffix
#    switch $USER
#        case root toor
#            if set -q fish_color_cwd_root
#                set color_cwd $fish_color_cwd_root
#            else
#                set color_cwd $fish_color_cwd
#            end
#            set suffix '#'
#        case '*'
#            set color_cwd $fish_color_cwd
#            set suffix '>'
#    end
#
#    if set -q VIRTUAL_ENV
#        echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
#    end
#
#    echo -n -s "$USER" @ "$__fish_prompt_hostname" ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal) "$suffix "
#end
