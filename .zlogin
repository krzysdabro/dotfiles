SSH_AGENT_FILE=~/.ssh/.agent
SSH_AGENT_TIME=30m

start_ssh_agent() {
  echo "Starting SSH agent..."
  (umask 066; /usr/bin/ssh-agent -t "$SSH_AGENT_TIME" > "${SSH_AGENT_FILE}")
  . "${SSH_AGENT_FILE}" > /dev/null
}

if [[ -f "${SSH_AGENT_FILE}" ]]; then
  . "${SSH_AGENT_FILE}" > /dev/null
  ps -p ${SSH_AGENT_PID} > /dev/null || start_ssh_agent
else
  start_ssh_agent
fi
