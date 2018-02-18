#!/usr/bin/env fish

function plib_bg_count
  set jobc (jobs -l | wc -l)
  if [ $jobc -gt 0 ]
    echo -ne "["$jobc"] "
  end
end