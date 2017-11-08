#!/usr/bin/env fish


function pi_load_styles
  set -g pi_vcs_style -i 62A
  set -g pi_ssh_style -o 62A
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
  set -g pi_python_style -i 62A
  set -g pi_ruby_style -i 62A
  set -g pi_java_style -i 62A
  set -g pi_timer_style -i 62A
end