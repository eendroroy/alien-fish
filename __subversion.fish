#!/usr/bin/env fish

function plib_is_svn
   != ""; and echo -n 1; or echo -n 0;
end

function plib_is_svn
  set -l is_svn (\svn info 2>/dev/null)
  if [ "$is_svn" != "" ]
     echo -ne 1;
  else
     echo -ne 0;
  end
end

function plib_svn_rev
  set -l __rev (svn info 2>/dev/null | grep Revision | awk '{print $2}'); or return;
  echo -ne $__rev;
end
