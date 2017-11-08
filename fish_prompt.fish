# name: Agnoster
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for FISH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).

## Set this options in your config.fish (if you want to :])
# set -g theme_display_user yes
# set -g theme_hide_hostname yes
# set -g theme_hide_hostname no
# set -g default_user your_normal_user

set THEME_ROOT (pushd (dirname (status --current-filename)); and pwd; and popd)

set -g MODULES git

source "$THEME_ROOT/libs/promptlib/activate"

source "$THEME_ROOT/modules/colors.fish"

function git_prompt
  set -l is_git (plib_is_git)
  if [ $is_git = "1" ]
    set_color $pi_branch_style
    plib_git_branch
    set_color normal

    set_color $pi_normal_style
    echo -ne "@"
    set_color $pi_rev_style
    plib_git_rev
    set_color normal

    set_color $pi_commit_since_style
    echo -ne "["(plib_git_commit_since)"]"
    set_color normal

    set_color $pi_dirty_style
    plib_git_dirty
    set_color normal

    set_color $pi_left_right_style
    plib_git_left_right
    echo -ne " "
    set_color normal

    set -l rebasing (plib_is_git_rebasing)
    if [ $rebasing = "1" ]
	    set_color $pi_rebasing_style
	    echo -ne "(rebasing)"
	    set_color normal
	end
  end
end

function fish_prompt
  pi_load_styles
  git_prompt
end
