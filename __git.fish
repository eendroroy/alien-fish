#!/usr/bin/env fish

function plib_is_git
  set -l is_git (\git branch 2>/dev/null)
  if [ "$is_git" != "" ]
     echo -ne 1;
  else
     echo -ne 0;
  end
end

function plib_git_branch
  set -l __ref (\git symbolic-ref HEAD 2> /dev/null | awk -F '/' '{print $NF}'); 
  if test -z $__ref
    set -l __ref "detached"
  end
  echo -n $__ref;
end

function plib_git_rev
  set -l __rev (\git rev-parse HEAD | cut -c 1-7);
  echo -ne $__rev;
end

function plib_git_remote_defined
  set -l remote (\git remote -v | head -1 | awk '{print $1}' | tr -d ' \n')
  [ $remote != '' ]; and echo -ne 1; or echo -ne 0;
end

function plib_git_remote_name
  if \git remote -v | grep origin > /dev/null
    echo -ne "origin"
  else
    echo -ne "`\git remote -v | head -1 | awk '{print $1}' | tr -d " \n"`"
  end
end

function plib_git_dirty
  set -l __mod (\git status --porcelain 2>/dev/null | grep '^M \|^ M\|^R \|^ R' | wc -l | tr -d ' ');
  set -l __add (\git status --porcelain 2>/dev/null | grep '^A \|^ A' | wc -l | tr -d ' ');
  set -l __del (\git status --porcelain 2>/dev/null | grep '^D \|^ D' | wc -l | tr -d ' ');
  set -l __new (\git status --porcelain 2>/dev/null | grep '^?? ' | wc -l | tr -d ' ');
  if [ $__mod -gt 0 ] ; echo -n " ⭑"; end;
  if [ $__add -gt 0 ] ; echo -n " +"; end;
  if [ $__del -gt 0 ] ; echo -n " -"; end;
  if [ $__new -gt 0 ] ; echo -n " ?"; end;
end

function plib_git_left_right
  if test (plib_git_remote_defined) -eq 1
    if [ (plib_git_branch) != "detached" ]
      set -l __pull (\git rev-list --left-right --count (plib_git_branch)...(plib_git_remote_name)/(plib_git_branch) 2>/dev/null | awk '{print $2}' | tr -d ' \n');
      set -l __push (\git rev-list --left-right --count (plib_git_branch)...(plib_git_remote_name)/(plib_git_branch) 2>/dev/null | awk '{print $1}' | tr -d ' \n');
      [ "$__pull" != "0" ]; and [ "$__pull" != "" ]; and echo -n " ▼";
      [ "$__push" != "0" ]; and [ "$__push" != "" ]; and echo -n " ▲";
    end
  end
end

function plib_git_commit_since
  set -l __sedstr 's| year\(s\)\{0,1\}|Y|g;s| month\(s\)\{0,1\}|M|g;s| week\(s\)\{0,1\}|W|g;s| day\(s\)\{0,1\}|D|g;s| hour\(s\)\{0,1\}|H|g;s| minute\(s\)\{0,1\}|Mi|g;s| second\(s\)\{0,1\}|S|g'
  set -l __commit_since (git log -1 --format='%cr' | sed $__sedstr | tr -d " ago\n")

  echo -ne $__commit_since
end

function plib_is_git_rebasing
  ls (git rev-parse --git-dir) | grep rebase; and echo -ne 1; or echo -ne 0;
end
