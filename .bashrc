# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Sets foreground (text) colors
FDEFAULT="\[\033[0;39m\]"
FBLACK="\[\033[0;30m\]"
FRED="\[\033[0;31m\]"
FGREEN="\[\033[0;32m\]"
FYELLOW="\[\033[0;33m\]"
FBLUE="\[\033[0;34m\]"
FMAGENTA="\[\033[0;35m\]"
FCYAN="\[\033[0;36m\]"
FLIGHTGRAY="\[\033[0;37m\]"
FDARKGRAY="\[\033[0;90m\]"
FLIGHTRED="\[\033[0;91m\]"
FLIGHTGREEN="\[\033[0;92m\]"
FLIGHTYELLOW="\[\033[0;93m\]"
FLIGHTBLUE="\[\033[0;94m\]"
FLIGHTMAGENTA="\[\033[0;95m\]"
FLIGHTCYAN="\[\033[0;96m\]"
FWHITE="\[\033[0;97m\]"
NO_COLOR="\[\033[0;0m\]"

# Cursor-style variables
cursor_style_default=0 # hardware cursor (blinking)
cursor_style_invisible=1 # hardware cursor (blinking)
cursor_style_underscore=2 # hardware cursor (blinking)
cursor_style_lower_third=3 # hardware cursor (blinking)
cursor_style_lower_half=4 # hardware cursor (blinking)
cursor_style_two_thirds=5 # hardware cursor (blinking)
cursor_style_full_block_blinking=6 # hardware cursor (blinking)
cursor_style_full_block=16 # software cursor (non-blinking)

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=
HISTFILESIZE=

# Adds the terminal history to my Dropbox folder. The file in which the history is saved is the name of the current month.
DIRECTORY="/home/$USER/Dropbox/ubuntu/terminal_history/$(date +"%Y")"

if [ ! -d "$DIRECTORY" ]; then
    mkdir "$DIRECTORY"
fi

HISTTIMEFORMAT="%d.%m.%y (%T)>"

HISTFILE="$DIRECTORY/$(date +"%B")" 

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# My personal customized prompt appearance.
function __setprompt {
	local SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
	local SSH2_IP=`echo $SSH2_CLIENT | awk '{ print $1 }'`
	if [ $SSH2_IP ] || [ $SSH_IP ] ; then
		local SSH_FLAG="@\h"
	fi

	PS1="$FLIGHTYELLOW[$FLIGHTMAGENTA\u$FLIGHTBLUE@$FLIGHTMAGENTA\h:\w$FLIGHTYELLOW]$FYELLOW\\$ $FLIGHTCYAN"
	PS2="$FLIGHTMAGENTA>$NO_COLOUR "
	PS4='$FLIGHTMAGENTA+$NO_COLOUR '
	echo -ne '\e]12;#FF00FF\a'
	
}
__setprompt
cursor_style_lower_third=3

# This function runs a script that launches a bash version of the game 2048.
tf8() {
	/home/mrwest3r/Dropbox/ubuntu/scripts/games/bash2048.sh
}

# This function runs a script that launches a bash version of the game tetris.
tetris() {
	/home/mrwest3r/Dropbox/ubuntu/scripts/games/tetris/sedtris.sh
}

# This function runs a script that launches a bash version of the game arkanoid.
arkanoid() {
	/home/mrwest3r/Dropbox/ubuntu/scripts/games/arcanoid.sh
}

# This function runs a script that launches a bash version of the game sudoku.
nsudoku() {
	/home/mrwest3r/Dropbox/ubuntu/scripts/games/nsudoku/./nsudoku
}

# This function is an universal command for extracting different compressed files
# The function is borrowed from http://tldp.org/LDP/abs/html/sample-bashrc.html
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1        ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       rar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xf $1        ;;
            *.tbz2)      tar xjf $1      ;;
            *.tgz)       tar xzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# This function runs a script that cleans the memory, apt cache and more.
clean() {
	sh /home/mrwest3r/Dropbox/ubuntu/scripts/clean.sh
}

# Prints a random string of uppercase, lowercase and numbers.
# The command is working well with different parameters, but is not bug-proof.
# Not upgraded with optimal argument handling.
mkpassword() {
    ucase='A-Z'					#All uppercase letters from A-Z
    lcase='a-z'					#All lowercase letters from a-z
    integers='0-9'				#All integers from 0-9
    symbols='_\-!@#$-%^&*()"+\\/{}|:<>?='	#Contains most extra symbols on a keyboard

    upperc=false
    lowerc=false
    intege=false
    symbol=false
    length=8
    temp=""
    passoutput=""
    shouldprint=true
    outputs=1
    counter=1
    outputfile=""
    outputtofile=false

    # The help text.
    helptext="program to create a random string using /dev/urandom
    where:
        -h, -help               Show help options.
        -u                  Include uppercase characters $ucase.
        -l                  Include lowercase characters $lcase.
        -i                  Include integers $integers.
        -s                  Include symbols $symbols.
        -len [integer]              Specifies the length of the output. Default = 8.
        -t [integer]                Specifies how many times to run the output.
        -o [filename]               Writes the output to the specified file"

    # If no arguments are passed, a string of random uppercase, lowercase and integers will be printed
    if [ -z "$1" ] ; then
        temp="$ucase$lcase$integers"
        shouldprint=true
    fi

    # Checks if the "help"-flag is placed as input and prints the "help"-text
    if [ "$1" = '-h' ] || [ "$1" = '-help' ] ; then
        echo -e "$helptext"
        shouldprint=false
        return
    fi

    # Checks which flags have been placed as input
    if [ "$1" = '-u' ] || [ "$2" = '-u' ] || [ "$3" = '-u' ] || [ "$4" = '-u' ] || [ "$5" = '-u' ] || [ "$6" = '-u' ] || [ "$7" = '-u' ] ; then
        upperc=true
    fi
    if [ "$1" = '-l' ] || [ "$2" = '-l' ] || [ "$3" = '-l' ] || [ "$4" = '-l' ] || [ "$5" = '-l' ] || [ "$6" = '-l' ] || [ "$7" = '-l' ] ; then
        lowerc=true
    fi
    if [ "$1" = '-i' ] || [ "$2" = '-i' ] || [ "$3" = '-i' ] || [ "$4" = '-i' ] || [ "$5" = '-i' ] || [ "$6" = '-i' ] || [ "$7" = '-i' ] ; then
        intege=true
    fi
    if [ "$1" = '-s' ] || [ "$2" = '-s' ] || [ "$3" = '-s' ] || [ "$4" = '-s' ] || [ "$5" = '-s' ] || [ "$6" = '-s' ] || [ "$7" = '-s' ] ; then
        symbol=true
    fi

    #Collects number for the "-len" option
    if [ "$1" = '-len' ] ; then
        length="$2"
    fi
    if [ "$2" = '-len' ] ; then
        length="$3"
    fi
    if [ "$3" = '-len' ] ; then
        length="$4"
    fi
    if [ "$4" = '-len' ] ; then
        length="$5"
    fi
    if [ "$5" = '-len' ] ; then
        length="$6"
    fi
    if [ "$6" = '-len' ] ; then
        length="$7"
    fi
    if [ "$7" = '-len' ] ; then
        length="$8"
    fi
    if [ "$8" = '-len' ] ; then
        length="$9"
    fi
    if [ "$9" = '-len' ] ; then
        length="$10"
    fi
    if [ "$10" = '-len' ] ; then
        length="$11"
    fi

    # Collects number for how many times to perform the print.
    if [ "$1" = '-t' ] ; then
        outputs="$2"
    fi
    if [ "$2" = '-t' ] ; then
        outputs="$3"
    fi
    if [ "$3" = '-t' ] ; then
        outputs="$4"
    fi
    if [ "$4" = '-t' ] ; then
        outputs="$5"
    fi
    if [ "$5" = '-t' ] ; then
        outputs="$6"
    fi
    if [ "$6" = '-t' ] ; then
        outputs="$7"
    fi
    if [ "$7" = '-t' ] ; then
        outputs="$8"
    fi
    if [ "$8" = '-t' ] ; then
        outputs="$9"
    fi
    if [ "$9" = '-t' ] ; then
        outputs="$10"
    fi
    if [ "$10" = '-t' ] ; then
        outputs="$11"
    fi

    # Collects the filename to write to.
    if [ "$1" = '-o' ] ; then
        outputfile="$2"
        outputtofile=true
    fi
    if [ "$2" = '-o' ] ; then
        outputfile="$3"
        outputtofile=true
    fi
    if [ "$3" = '-o' ] ; then
        outputfile="$4"
        outputtofile=true
    fi
    if [ "$4" = '-o' ] ; then
        outputfile="$5"
        outputtofile=true
    fi
    if [ "$5" = '-o' ] ; then
        outputfile="$6"
        outputtofile=true
    fi
    if [ "$6" = '-o' ] ; then
        outputfile="$7"
        outputtofile=true
    fi
    if [ "$7" = '-o' ] ; then
        outputfile="$8"
        outputtofile=true
    fi
    if [ "$8" = '-o' ] ; then
        outputfile="$9"
        outputtofile=true
    fi
    if [ "$9" = '-o' ] ; then
        outputfile="$10"
        outputtofile=true
    fi
    if [ "$10" = '-o' ] ; then
        outputfile="$11"
        outputtofile=true
    fi

    # This is experimantal, do not use.
    #if [ $length -ne $length 2>/dev/null ]
    #then
    #   echo "Invalid input for option -len: $length"
    #   return
    #fi

    #Checks if the length variable only contains integers
    if [[ "$length" =~ [^0-9]+ ]] ; then
        echo "Invalid input for option -len: $length"
        return
    fi

    # Checks the validity of input for how many times to print.
    if [[ "$outputs" =~ [^0-9]+ ]] ; then
        echo "Invalid input for option -t: $outputs"
        return
    fi

    #Takes care of the different combinations flags can be placed as input
    if [ $upperc == true ] && [ $lowerc == false ] && [ $intege == false ] && [ $symbol == false ] ; then
        #< /dev/urandom tr -dc "$ucase" | head -c "$length"
        temp="$ucase"
    fi
    if [ $upperc == false ] && [ $lowerc == true ] && [ $intege == false ] && [ $symbol == false ] ; then
        #< /dev/urandom tr -dc "$lcase" | head -c "$length"
        temp="$lcase"
    fi
    if [ $upperc == false ] && [ $lowerc == false ] && [ $intege == true ] && [ $symbol == false ] ; then
        #< /dev/urandom tr -dc "$integers" | head -c "$length"
        temp="$integers"
    fi
    if [ $upperc == false ] && [ $lowerc == false ] && [ $intege == false ] && [ $symbol == true ] ; then
        #< /dev/urandom tr -dc "$symbols" | head -c "$length"
        temp="$symbols"
    fi
    if [ $upperc == true ] && [ $lowerc == true ] && [ $intege == false ] && [ $symbol == false ] ; then
        #< /dev/urandom tr -dc "$lcase$ucase" | head -c "$length"
        temp="$ucase$lcase"
    fi
    if [ $upperc == true ] && [ $lowerc == false ] && [ $intege == true ] && [ $symbol == false ] ; then
        #< /dev/urandom tr -dc "$ucase$integers" | head -c "$length"
        temp="$ucase$integers"
    fi
    if [ $upperc == true ] && [ $lowerc == false ] && [ $intege == false ] && [ $symbol == true ] ; then
        #< /dev/urandom tr -dc "$ucase$symbols" | head -c "$length"
        temp="$ucase$symbols"
    fi
    if [ $upperc == false ] && [ $lowerc == true ] && [ $intege == true ] && [ $symbol == false ] ; then
        #< /dev/urandom tr -dc "$lcase$integers" | head -c "$length"
        temp="$lcase$integers"
    fi
    if [ $upperc == false ] && [ $lowerc == true ] && [ $intege == false ] && [ $symbol == true ] ; then
        #< /dev/urandom tr -dc "$lcase$symbols" | head -c "$length"
        temp="$lcase$symbols"
    fi
    if [ $upperc == false ] && [ $lowerc == false ] && [ $intege == true ] && [ $symbol == true ] ; then
        #< /dev/urandom tr -dc "$integers$symbols" | head -c "$length"
        temp="$integers$symbols"
    fi
    if [ $upperc == true ] && [ $lowerc == true ] && [ $intege == true ] && [ $symbol == false ] ; then
        #< /dev/urandom tr -dc "$ucase$lcase$integers" | head -c "$length"
        temp="$ucase$lcase$integers"
    fi
    if [ $upperc == true ] && [ $lowerc == true ] && [ $intege == false ] && [ $symbol == true ] ; then
        #< /dev/urandom tr -dc "$ucase$lcase$symbols" | head -c "$length"
        temp="$ucase$lcase$symbols"
    fi
    if [ $upperc == true ] && [ $lowerc == false ] && [ $intege == true ] && [ $symbol == true ] ; then
        #< /dev/urandom tr -dc "$ucase$integers$symbols" | head -c "$length"
        temp="$ucase$integers$symbols"
    fi
    if [ $upperc == false ] && [ $lowerc == true ] && [ $intege == true ] && [ $symbol == true ] ; then
        #< /dev/urandom tr -dc "$lcase$integers$symbols" | head -c "$length"
        temp="$lcase$integers$symbols"
    fi
    if [ $upperc == true ] && [ $lowerc == true ] && [ $intege == true ] && [ $symbol == true ] ; then
        #< /dev/urandom tr -dc "$ucase$lcase$integers$symbols" | head -c "$length"
        temp="$ucase$lcase$integers$symbols"
    fi

    # This is experimental, do not use.
    #Prints the random string
    #if [ "$shouldprint" ] ; then
        #< /dev/urandom tr -dc "$temp" | head -c "$length"
    #   passoutput="$(< /dev/urandom tr -dc $temp | head -c $length)"
    #   echo "$passoutput"
    #fi

    # Performs the printing IF only print to console.
    if [ "$shouldprint" ] && [ "$outputtofile" == false ] ; then
        until [ $counter -gt $outputs ]
        do
            passoutput="$(< /dev/urandom tr -dc $temp | head -c $length)"
            echo "$passoutput"

            if [ $counter -gt $outputs ]
            then
                return
            else
                ((counter++))
            fi
        done
    fi

    # Performs printing/output to file.
    if [ "$outputtofile" ] ; then
        until [ $counter -gt $outputs ]
        do
            passoutput="$(< /dev/urandom tr -dc $temp | head -c $length)"
            echo "$passoutput" >> $outputfile

            if [ $counter -gt $outputs ]
            then
                return
            else
                ((counter++))
            fi
        done
    fi
}

# Clears PageCache, dentries and inodes through an external script.
clearam() {
    read -n1 -p "Clear cache? [y/n]" userinput
    if [[ "$userinput" == "y" || "$userinput" == "Y" ]]; then
        echo -e "\n"
        echo "Usage before cleaning:"
        free -m
        sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
        echo "Usage after cleaning:"
        free -m
    elif [[ "$userinput" == "n" || "$userinput" == "N" ]]; then
        echo -e "\n"
        return
    else
        echo " = Invalid input!"
        clearam
    fi
}

#myip - finds your current IP address if there is an internet connection.
myip ()
{
# This commented section is experimental and not used.
#   while getopts lp opt
#   do
#       case $opt in
#           l)
#               echo "-l used";;
#           p)
#               echo "-p used";;
#
#           *)
#               echo "Invalid option: -$OPTARG";;
#       esac
#   done

    printPublic=false
    printLocal=false
    pFirst=false
    lFirst=false

#   if [ "$1" == '-l' || "$2" == '-l' ]; then
#       ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
#   fi
#
#   if [ "$1" == '-p' || "$2" == '-p' ]; then
#       wget -qO- icanhazip.com
#   fi

    # Checks if the "-l"-flag is present as first argument.
    if [ "$1" == '-l' ] ; then
        printLocal=true
        lFirst=true
    fi

    # Checks if the "-l"-flag is present as second parameter.
    if [ "$2" == '-l' ] ; then
        printLocal=true
    fi

    # Checks if the "-p"-flag is present as first argument.
    if [ "$1" == '-p' ] ; then
        printPublic=true;
        pFirst=true
    fi

    # Checks if the "-p"-flag is present as second argument.
    if [ "$2" == '-p' ] ; then
        printPublic=true;
    fi

    # Prints ip-adress(es) if flag -p is first. Will print public ip-address first.
    if [ "$pFirst" = true ] ; then
        if [ "$printPublic" = true ] ; then
                    echo -e "Public: \c"
                    wget -qO- icanhazip.com
            fi

        if [ "$printLocal" = true ] ; then
            echo -e "Local: \c"
            ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo ' ([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
        fi
    fi

    # Prints ip-adress(es) if flag -l is first. Will print local ip-address first.
    if [ "$lFirst" = true ] ; then
        if [ "$printLocal" = true ] ; then
                    echo -e "Local: \c"
                    ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
            fi

        if [ "$printPublic" = true ] ; then
            echo -e "Public: \c"
            wget -qO- icanhazip.com
        fi
    fi
}

