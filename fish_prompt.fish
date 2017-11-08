#!/usr/bin/env fish

function pi_load_styles
  set -g pi_vcs_style 7F8C8D
  set -g pi_ssh_style -o D4AC0D
  set -g pi_normal_style FFFFFF
  set -g pi_error_style -u FF0000
  set -g pi_rebasing_style FF0000
  set -g pi_rev_style -i DAEC77
  set -g pi_branch_style -o 5EEE3F
  set -g pi_dirty_style 11FFA1
  set -g pi_left_right_style FCFF21
  set -g pi_commit_since_style 8AAFC8
  set -g pi_fade_style 8F8F8F
  set -g pi_venv_style -i 8F8F8F
end

function pi_git_prompt
  set -l is_git (plib_is_git)
  if [ $is_git = "1" ]
    set_color $pi_vcs_style
    echo -ne "G "

    set_color $pi_branch_style
    plib_git_branch
    set_color normal

    set_color $pi_normal_style
    echo -ne " "
    set_color $pi_rev_style
    plib_git_rev
    set_color normal

    set_color $pi_commit_since_style
    echo -ne " ["(plib_git_commit_since)"]"
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

function pi_prompt_left
  set -l last_st $status

  echo -ne " "
  if not test $last_st -eq 0
    set_color $pi_error_style
  end

  echo -ne (pwd | awk -F '/' '{print $NF}')

  if not test $last_st -eq 0
    set_color normal
    set_color $pi_fade_style
    echo -ne " ("$last_st")"
  end
  set_color normal
  echo -ne " "
end

function pi_prompt_right
  pi_git_prompt
end

function fish_prompt
  pi_load_styles
  pi_prompt_left
end

function fish_right_prompt
  pi_load_styles
  pi_prompt_right
end
