# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
        fi

# User specific aliases and functions
export JAVA_HOME=/usr/lib/jvm/java
export ANT_HOME=/usr/local/ant
export PATH=$ANT_HOME/bin:$JAVA_HOME/bin:$PATH
export LANG=en_US.utf8
