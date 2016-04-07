export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src/projects
source /usr/local/bin/virtualenvwrapper.sh

source $HOME/ubuntu_utils/git_utils/contrib/git-completion.sh

source $HOME/ubuntu_utils/git_utils/contrib/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWSTASHSTATE=1
# PS1='\u@\h \w$(__git_ps1 " (%s)")\$: '

# source $HOME/ubuntu_utils/git_utils/bash-git-prompt/gitprompt.sh
# GIT_PROMPT_ONLY_IN_REPO=1
# GIT_PROMPT_START='\u@\h \w'
# GIT_PROMPT_END='$ '
# GIT_PROMPT_START_USER="${Yellow}${PathShort}${ResetColor}"

source $HOME/ubuntu_utils/git_utils/git-virtual-env-promt.sh

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
