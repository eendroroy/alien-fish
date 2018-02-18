#!/usr/bin/env fish

function plib_ssh_st
  if not test -z $SSH_CLIENT
  	echo -n "[S]"
  end
end

function plib_ssh_client_ip
  if not test -z $SSH_CLIENT
  	echo -n (echo $SSH_CLIENT | awk '{print $1}')
  end
end

function plib_ssh_client_port
  if not test -z $SSH_CLIENT
  	echo -n (echo $SSH_CLIENT | awk '{print $3}')
  end
end
