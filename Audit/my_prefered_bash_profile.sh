# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi
if [ $USER = "oracle" ]; then
  if [ $SHELL = "/bin/ksh" ]; then
    ulimit -p 16384
    ulimit -n 65536
  else
    ulimit -u 16384 -n 65536
  fi
fi
# User specific environment and startup programs
PATH=$PATH:$HOME/bin
export PATH

# Oracle Settings
TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR
ORACLE_HOSTNAME=yourServerName; export ORACLE_HOSTNAME
ORACLE_BASE=/u01/app/oracle;
export ORACLE_BASE
ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1; export ORACLE_HOME
ORACLE_SID=ergon; export ORACLE_SID
ORACLE_TERM=xterm; export ORACLE_TERM
PATH=/usr/sbin:$PATH; export PATH
PATH=$ORACLE_HOME/bin:$PATH; export PATH
LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH

alias alert='vi /u01/app/oracle/diag/rdbms/$ORACLE_SID/$ORACLE_SID/trace/alert_$ORACLE_SID.log'
alias archive='ll /u01/app/oracle/fast_recovery_area/$ORACLE_DBNAME/archivelog'
alias bp='vi /home/$USER/.bash_profile'
alias df='df -h'
alias dpdump='cd $ORACLE_BASE/admin/$ORACLE_SID/dpdump'
alias erro='tail -100 /u01/app/oracle/diag/rdbms/$ORACLE_SID/$ORACLE_SID/trace/alert_$ORACLE_SID.log|grep ORA-'
alias ll='ls -lha --color=auto'
alias ls='ls --color=tty'
alias ls='ls -lha'
alias od='cd /u01/app/oracle/diag/rdbms/$ORACLE_SID/$ORACLE_SID'
alias oh='echo ORACLE_HOME: $ORACLE_HOME'
alias os='echo ORACLE_SID:$ORACLE_SID'
alias rman='rman target /'
alias scripts='cd /u01/scripts/'
alias sss='sqlplus '\''/as sysdba'\'' '
alias tns='cat $ORACLE_HOME/network/admin/tnsnames.ora'
alias vi='vim'
#
alias yourMainDB='. ~/.yourMainDB'

#v_data=`date '+%Y%m%d_%H%M%S'`
export LANG=en.UTF-8
clear
echo 'Oracle_SID:' $ORACLE_SID
#DISPLAY=you_IP:0.0; export DISPLAY;  echo $DISPLAY
