#!/usr/bin/env fish

function plib_venv
  if not test -z $VIRTUAL_ENV
    set -l __venv (basename \"$VIRTUAL_ENV\")
    echo -n $__venv
  end
end

function plib_python_version
  which python > /dev/null; and echo -ne (python --version 2>&1 | awk '{print $2}' | tr -d ' \n');
end

function plib_python_major_version
  which python > /dev/null; and echo -ne (python --version 2>&1 | awk -F '[. ]' '{print $2}' | tr -d '\n');
end

function plib_python_major_minor_version
  which python > /dev/null; and echo -ne (python --version 2>&1 | awk -F '[. ]' '{printf("%s.%s",$2,$3)}' | tr -d '\n');
end

function plib_pyenv_version
  which pyenv > /dev/null; and echo -ne (pyenv version | awk '{print $1}' | tr -d ' \n');
end

function plib_pyenv_major_version
  which pyenv > /dev/null; and echo -ne (pyenv version 2>&1 | awk -F '[. ]' '/version/ {print $1}');
end
