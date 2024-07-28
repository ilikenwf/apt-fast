set completion_cmd apt-get
if [ -f /etc/apt-fast.conf ]
    set completion_cmd (bash -c 'source /etc/apt-fast.conf && echo "$_APTMGR"')
end
set completion_cmd (echo "$completion_cmd" | string split ' ' | head -n 1)
if not type -q "$completion_cmd"
    set completion_cmd apt-get
end

complete -c apt-fast -w "$completion_cmd"
