# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF '
alias la='ls -A '
alias l='ls -CF '

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/bratin/anaconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "/home/bratin/anaconda3/etc/profile.d/conda.sh" ]; then
		. "/home/bratin/anaconda3/etc/profile.d/conda.sh"
	else
		export PATH="/home/bratin/anaconda3/bin:$PATH"
	fi
fi
unset __conda_setup
# <<< conda initialize <<<
export LD_LIBRARY_PATH=/usr/local/lib

alias q=exit
alias c=clear
alias g=git

make_clean_and_build() {
	make clean
	make
}

#figlet "Bratin"

echo "
█████████████████████████████████████
█▄─▄─▀█▄─▄▄▀██▀▄─██─▄─▄─█▄─▄█▄─▀█▄─▄█
██─▄─▀██─▄─▄██─▀─████─████─███─█▄▀─██
▀▄▄▄▄▀▀▄▄▀▄▄▀▄▄▀▄▄▀▀▄▄▄▀▀▄▄▄▀▄▄▄▀▀▄▄▀" | lolcat

neofetch

fortune

cool_commands() {
	cowsay "BM" | lolcat
	fortune | cowsay -f tux | lolcat
	figlet "BM" | lolcat
}

# *_SECURED is the format of wifi name
lnet() {
	echo "Available campus wifi: "
	nmcli device wifi list | grep _SECURED | lolcat
}

cnct() {
	networks_sorted_by_signal=$(lnet | awk 'NR>1 {print $1, $2, $3, $4, $5, $6}' | sort -rn)
	while read -r bssid freq signal_strength ssid mode security; do
		nmcli device wifi connect "$bssid" || continue
		break
	done <<<"$networks_sorted_by_signal"
	echo "Connected to: $(nmcli connection show --active | grep 'wifi' | head -n 1 | awk '{print $1}')" | lolcat
}

cse_server() {
	ssh 21CS10016@10.5.18.69
}

bash_prompt_command() {

	local pwdmaxlen=25

	local trunc_symbol=".."

	local dir=${PWD##*/}

	pwdmaxlen=$(((pwdmaxlen < ${#dir}) ? ${#dir} : pwdmaxlen))

	NEW_PWD=${PWD/#$HOME/\~}

	local pwdoffset=$((${#NEW_PWD} - pwdmaxlen))

	if [ ${pwdoffset} -gt "0" ]; then
		NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
		NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
	fi
}

format_font() {

	local output=$1

	case $# in
	2)
		eval $output="'\[\033[0;${2}m\]'"
		;;
	3)
		eval $output="'\[\033[0;${2};${3}m\]'"
		;;
	4)
		eval $output="'\[\033[0;${2};${3};${4}m\]'"
		;;
	*)
		eval $output="'\[\033[0m\]'"
		;;
	esac
}

bash_prompt() {

	local NONE='0'
	local BOLD='1'
	local DIM='2'
	local UNDERLINE='4'
	local BLINK='5'
	local INVERT='7'
	local HIDDEN='8'

	local DEFAULT='9'
	local BLACK='0'
	local RED='1'
	local GREEN='2'
	local YELLOW='3'
	local BLUE='4'
	local MAGENTA='5'
	local CYAN='6'
	local L_GRAY='7'
	local D_GRAY='60'
	local L_RED='61'
	local L_GREEN='62'
	local L_YELLOW='63'
	local L_BLUE='64'
	local L_MAGENTA='65'
	local L_CYAN='66'
	local WHITE='67'

	local RESET='0'
	local EFFECT='0'
	local COLOR='30'
	local BG='40'

	local NO_FORMAT="\[\033[0m\]"
	local ORANGE_BOLD="\[\033[1;38;5;208m\]"
	local TOXIC_GREEN_BOLD="\[\033[1;38;5;118m\]"
	local RED_BOLD="\[\033[1;38;5;1m\]"
	local CYAN_BOLD="\[\033[1;38;5;87m\]"
	local BLACK_BOLD="\[\033[1;38;5;0m\]"
	local WHITE_BOLD="\[\033[1;38;5;15m\]"
	local GRAY_BOLD="\[\033[1;90m\]"
	local BLUE_BOLD="\[\033[1;38;5;74m\]"

	local FONT_COLOR_1=$WHITE
	local BACKGROUND_1=$CYAN
	local TEXTEFFECT_1=$BOLD

	local FONT_COLOR_2=$WHITE
	local BACKGROUND_2=$GREEN
	local TEXTEFFECT_2=$BOLD

	local FONT_COLOR_3=$D_GRAY
	local BACKGROUND_3=$WHITE
	local TEXTEFFECT_3=$BOLD

	local PROMT_FORMAT=$BLUE_BOLD

	if [ "$HOSTNAME" = dell ]; then
		FONT_COLOR_1=$WHITE
		BACKGROUND_1=$BLUE
		TEXTEFFECT_1=$BOLD
		FONT_COLOR_2=$WHITE
		BACKGROUND_2=$L_BLUE
		TEXTEFFECT_2=$BOLD
		FONT_COLOR_3=$D_GRAY
		BACKGROUND_3=$WHITE
		TEXTEFFECT_3=$BOLD
		PROMT_FORMAT=$CYAN_BOLD
	fi

	if [ "$HOSTNAME" = giraff6 ]; then
		FONT_COLOR_1=$WHITE
		BACKGROUND_1=$BLACK
		TEXTEFFECT_1=$BOLD
		FONT_COLOR_2=$WHITE
		BACKGROUND_2=$D_GRAY
		TEXTEFFECT_2=$BOLD
		FONT_COLOR_3=$WHITE
		BACKGROUND_3=$RED
		TEXTEFFECT_3=$BOLD
		PROMT_FORMAT=$RED_BOLD
	fi

	if [ "$HOSTNAME" = sharkoon ]; then
		FONT_COLOR_1=$BLACK
		BACKGROUND_1=$L_CYAN
		TEXTEFFECT_1=$BOLD
		FONT_COLOR_2=$WHITE
		BACKGROUND_2=$L_BLUE
		TEXTEFFECT_2=$BOLD
		FONT_COLOR_3=$WHITE
		BACKGROUND_3=$BLUE
		TEXTEFFECT_3=$BOLD
		PROMT_FORMAT=$CYAN_BOLD
	fi

	if [ "$HOSTNAME" = giraff ]; then
		FONT_COLOR_1=$WHITE
		BACKGROUND_1=$BLACK
		TEXTEFFECT_1=$BOLD
		FONT_COLOR_2=$WHITE
		BACKGROUND_2=$D_GRAY
		TEXTEFFECT_2=$BOLD
		FONT_COLOR_3=$WHITE
		BACKGROUND_3=$L_GRAY
		TEXTEFFECT_3=$BOLD
		PROMT_FORMAT=$BLACK_BOLD
	fi

	if [ "$HOSTNAME" = light ]; then
		FONT_COLOR_1=$WHITE
		BACKGROUND_1=$BLACK
		TEXTEFFECT_1=$BOLD
		FONT_COLOR_2=$WHITE
		BACKGROUND_2=$D_GRAY
		TEXTEFFECT_2=$BOLD
		FONT_COLOR_3=$BLACK
		BACKGROUND_3=$L_CYAN
		TEXTEFFECT_3=$BOLD
		PROMT_FORMAT=$CYAN_BOLD
	fi

	FC1=$(($FONT_COLOR_1 + $COLOR))
	BG1=$(($BACKGROUND_1 + $BG))
	FE1=$(($TEXTEFFECT_1 + $EFFECT))

	FC2=$(($FONT_COLOR_2 + $COLOR))
	BG2=$(($BACKGROUND_2 + $BG))
	FE2=$(($TEXTEFFECT_2 + $EFFECT))

	FC3=$(($FONT_COLOR_3 + $COLOR))
	BG3=$(($BACKGROUND_3 + $BG))
	FE3=$(($TEXTEFFECT_3 + $EFFECT))

	FC4=$(($FONT_COLOR_4 + $COLOR))
	BG4=$(($BACKGROUND_4 + $BG))
	FE4=$(($TEXTEFFECT_4 + $EFFECT))

	local TEXT_FORMAT_1
	local TEXT_FORMAT_2
	local TEXT_FORMAT_3
	local TEXT_FORMAT_4
	format_font TEXT_FORMAT_1 $FE1 $FC1 $BG1
	format_font TEXT_FORMAT_2 $FE2 $FC2 $BG2
	format_font TEXT_FORMAT_3 $FC3 $FE3 $BG3
	format_font TEXT_FORMAT_4 $FC4 $FE4 $BG4

	local PROMT_USER=$"$TEXT_FORMAT_1 \u "
	local PROMT_HOST=$"$TEXT_FORMAT_2 \h "
	local PROMT_PWD=$"$TEXT_FORMAT_3 \${NEW_PWD} "
	local PROMT_INPUT=$"$PROMT_FORMAT "

	TSFC1=$(($BACKGROUND_1 + $COLOR))
	TSBG1=$(($BACKGROUND_2 + $BG))

	TSFC2=$(($BACKGROUND_2 + $COLOR))
	TSBG2=$(($BACKGROUND_3 + $BG))

	TSFC3=$(($BACKGROUND_3 + $COLOR))
	TSBG3=$(($DEFAULT + $BG))

	local SEPARATOR_FORMAT_1
	local SEPARATOR_FORMAT_2
	local SEPARATOR_FORMAT_3
	format_font SEPARATOR_FORMAT_1 $TSFC1 $TSBG1
	format_font SEPARATOR_FORMAT_2 $TSFC2 $TSBG2
	format_font SEPARATOR_FORMAT_3 $TSFC3 $TSBG3

	local TRIANGLE=$'\uE0B0'
	local SEPARATOR_1=$SEPARATOR_FORMAT_1$TRIANGLE
	local SEPARATOR_2=$SEPARATOR_FORMAT_2$TRIANGLE
	local SEPARATOR_3=$SEPARATOR_FORMAT_3$TRIANGLE

	case $TERM in
	xterm* | rxvt*)
		local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
		;;
	*)
		local TITLEBAR=""
		;;
	esac

	PS1="$TITLEBAR\n${PROMT_USER}${SEPARATOR_1}${PROMT_HOST}${SEPARATOR_2}${PROMT_PWD}${SEPARATOR_3}${PROMT_INPUT}"

	none="$(tput sgr0)"
	trap 'echo -ne "${none}"' DEBUG
}

PROMPT_COMMAND=bash_prompt_command

bash_prompt
unset bash_prompt

distribution() {
	local dtype

	dtype="unknown"

	if [ -r /etc/rc.d/init.d/functions ]; then
		source /etc/rc.d/init.d/functions
		[ zz$(type -t passed 2>/dev/null) == "zzfunction" ] && dtype="redhat"

	elif [ -r /etc/rc.status ]; then
		source /etc/rc.status
		[ zz$(type -t rc_reset 2>/dev/null) == "zzfunction" ] && dtype="suse"

	elif [ -r /lib/lsb/init-functions ]; then
		source /lib/lsb/init-functions
		[ zz$(type -t log_begin_msg 2>/dev/null) == "zzfunction" ] && dtype="debian"

	elif [ -r /etc/init.d/functions.sh ]; then
		source /etc/init.d/functions.sh
		[ zz$(type -t ebegin 2>/dev/null) == "zzfunction" ] && dtype="gentoo"

	elif [ -s /etc/mandriva-release ]; then
		dtype="mandriva"

	elif [ -s /etc/slackware-version ]; then
		dtype="slackware"

	fi
	echo $dtype
}

ver() {
	local dtype
	dtype=$(distribution)

	if [ $dtype == "redhat" ]; then
		if [ -s /etc/redhat-release ]; then
			cat /etc/redhat-release && uname -a
		else
			cat /etc/issue && uname -a
		fi
	elif [ $dtype == "suse" ]; then
		cat /etc/SuSE-release
	elif [ $dtype == "debian" ]; then
		lsb_release -a

	elif [ $dtype == "gentoo" ]; then
		cat /etc/gentoo-release
	elif [ $dtype == "mandriva" ]; then
		cat /etc/mandriva-release
	elif [ $dtype == "slackware" ]; then
		cat /etc/slackware-version
	else
		if [ -s /etc/issue ]; then
			cat /etc/issue
		else
			echo "Error: Unknown distribution"
			exit 1
		fi
	fi
}

up() {
	local d=""
	limit=$1
	for ((i = 1; i <= limit; i++)); do
		d=$d/..
	done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}

mkdirg() {
	mkdir -p "$1"
	cd "$1"
}

cpp() {
	# Check if the correct number of arguments is provided
	if [ "$#" -ne 2 ]; then
		echo "Usage: cpp <source_file> <destination_file>"
		return 1
	fi

	# Assign parameters to variables for better readability
	local source_file="$1"
	local destination_file="$2"

	# Check if the source file exists
	if [ ! -f "$source_file" ]; then
		echo "Error: Source file '$source_file' does not exist."
		return 1
	fi

	# Proceed with copying the file and showing the progress
	set -e
	strace -q -ewrite cp -- "$source_file" "$destination_file" 2>&1 |
		awk '{
        count += $NF
        if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++)
                printf "="
            printf ">"
            for (i=percent;i<100;i++)
                printf " "
            printf "]\r"
        }
    }
    END { print "" }' total_size="$(stat -c '%s' "$source_file")" count=0
}

extract() {
	for archive in "$@"; do
		if [ -f "$archive" ]; then
			case $archive in
			*.tar.bz2) tar xvjf $archive ;;
			*.tar.gz) tar xvzf $archive ;;
			*.bz2) bunzip2 $archive ;;
			*.rar) rar x $archive ;;
			*.gz) gunzip $archive ;;
			*.tar) tar xvf $archive ;;
			*.tbz2) tar xvjf $archive ;;
			*.tgz) tar xvzf $archive ;;
			*.zip) unzip $archive ;;
			*.Z) uncompress $archive ;;
			*.7z) 7z x $archive ;;
			*) echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

gcom() {
	git add .
	git status
	git commit -m "$1"
}

lazyg() {
	git add .
	git status
	git commit -m "$1"
	git push origin
}

lazygmain() {
	git add .
	git status
	git commit -m "$1"
	git push origin main
}

lazygmaster() {
	git add .
	git status
	git commit -m "$1"
	git push origin master
}

vscode() {
	code .
	exit
}

netinfo() {
	echo "--------------- Network Information ---------------"
	ip addr show | awk '/inet /{print $2}'
	echo ""
	ip addr show | awk '/inet /{print $4}'
	echo ""
	ip link show | awk '/ether /{print $2}'
	echo "---------------------------------------------------"
}

HISTTIMEFORMAT="%F %T "

alias jan='cal -m 01 | lolcat'
alias feb='cal -m 02 | lolcat'
alias mar='cal -m 03 | lolcat'
alias apr='cal -m 04 | lolcat'
alias may='cal -m 05 | lolcat'
alias jun='cal -m 06 | lolcat'
alias jul='cal -m 07 | lolcat'
alias aug='cal -m 08 | lolcat'
alias sep='cal -m 09 | lolcat'
alias oct='cal -m 10 | lolcat'
alias nov='cal -m 11 | lolcat'
alias dec='cal -m 12 | lolcat'

function find_largest_files() {
	du -h -x -s -- * | sort -r -h | head -20
}

function find_largest_files_all() {
	du -h -x -a -- * | sort -r -h | head -20
}

function git_init() {
	if [ -z "$1" ]; then
		printf "%s\n" "Please provide a directory name."
	else
		mkdir "$1"
		builtin cd "$1"
		pwd
		git init
		touch readme.md .gitignore LICENSE
		echo "# $(basename $PWD)" >>readme.md
	fi
}

export PATH="$PATH":~/.local/bin
export PATH="$PATH":usr/local/lib

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/include/postgresql

ppt_to_pdf() {
	soffice --headless --convert-to pdf "$1"
}

# Function to create a tar.gz file
create_tar_gz() {
	local source_dir="$1"
	local output_filename="$2"

	# Check if the source directory exists
	if [ ! -d "$source_dir" ]; then
		echo "Error: Source directory does not exist."
		return 1
	fi

	# Create the tar.gz file
	echo "Creating tar.gz file..."
	tar -czvf "$output_filename" "$source_dir"

	# Check if the tar.gz file was created successfully
	if [ $? -eq 0 ]; then
		echo "Tar.gz file created successfully: $output_filename"
	else
		echo "Error: Failed to create tar.gz file."
		return 1
	fi
}

# Function to remove .vscode directories and files recursively from a directory
remove_vscode_files() {
	if [ $# -ne 1 ]; then
		echo "Usage: remove_vscode_files <directory>"
		return 1
	fi

	local directory="$1"

	if [ ! -d "$directory" ]; then
		echo "Error: '$directory' is not a valid directory."
		return 1
	fi

	echo "Removing .vscode directories and files recursively from '$directory'..."

	find "$directory" -name .vscode -exec rm -rf {} \;

	echo "Done."
}

# Function to remove .out and .o files recursively from a directory
remove_out_o_files() {
	if [ $# -ne 1 ]; then
		echo "Usage: remove_out_o_files <directory>"
		return 1
	fi

	local directory="$1"

	if [ ! -d "$directory" ]; then
		echo "Error: '$directory' is not a valid directory."
		return 1
	fi

	echo "Removing .out and .o files recursively from '$directory'..."

	find "$directory" -type f \( -name "*.out" -o -name "*.o" \) -exec rm -f {} +

	echo "Done."
}

# Function to count the number of files in the current directory
countfiles_recursive() {
	local count=$(find . -type f | wc -l)
	echo "Number of files in the current directory (including subdirectories): $count"
}

#!/bin/bash

# Define the function
ascii_clock() {
	L1=(" --- " "    ." " --- " " --- " ".   ." " --- " " --- " " --- " " --- " " --- ")
	L2=("|   |" "    |" "    |" "    |" "|   |" "|    " "|    " "    |" "|   |" "|   |")
	L3=("|   |" "    |" " --- " " --- " " ---|" " --- " "|--- " "    |" " --- " " ---|")
	L4=("|   |" "    |" "|    " "    |" "    |" "    |" "|   |" "    |" "|   |" "    |")
	L5=(" --- " "    ." " --- " " --- " "    ." " --- " " --- " "    ." " --- " " --- ")

	ch="o"
	pattern="(.*) ([0-9])([0-9]):([0-9])([0-9]):([0-9])([0-9]) ([A-Za-z][A-Za-z])"
	while [ true ]; do
		clear
		vskip=$(((LINES - 9) / 2))
		hskip=$(((COLUMNS - 55) / 2))
		h=""
		i=0
		while [ $i -lt $hskip ]; do
			h="$h "
			i=$((i + 1))
		done
		t=$(date +"%A %d %B %Y %I:%M:%S %p %Z")
		if [[ $t =~ $pattern ]]; then
			d=${BASH_REMATCH[1]}
			h1=${BASH_REMATCH[2]}
			h2=${BASH_REMATCH[3]}
			m1=${BASH_REMATCH[4]}
			m2=${BASH_REMATCH[5]}
			s1=${BASH_REMATCH[6]}
			s2=${BASH_REMATCH[7]}
			m=${BASH_REMATCH[8]}
			i=0
			while [ $i -lt $vskip ]; do
				echo ""
				i=$((i + 1))
			done
			echo "$h$d"
			echo "$h+-----------------------------------------------------+"
			echo "$h|  ${L1[$h1]}  ${L1[$h2]}     ${L1[$m1]}  ${L1[$m2]}     ${L1[$s1]}  ${L1[$s2]}     |"
			echo "$h|  ${L2[$h1]}  ${L2[$h2]}  $ch  ${L2[$m1]}  ${L2[$m2]}  $ch  ${L2[$s1]}  ${L2[$s2]}     |"
			echo "$h|  ${L3[$h1]}  ${L3[$h2]}     ${L3[$m1]}  ${L3[$m2]}     ${L3[$s1]}  ${L3[$s2]}     |"
			echo "$h|  ${L4[$h1]}  ${L4[$h2]}  $ch  ${L4[$m1]}  ${L4[$m2]}  $ch  ${L4[$s1]}  ${L4[$s2]}     |"
			echo "$h|  ${L5[$h1]}  ${L5[$h2]}     ${L5[$m1]}  ${L5[$m2]}     ${L5[$s1]}  ${L5[$s2]}  $m |"
			echo "$h+-----------------------------------------------------+"
		else
			echo $t
		fi
		read -t 0.49 c && exit 0
		if [ $ch == "o" ]; then ch=" "; else ch="o"; fi
	done
}

image_to_ascii() {
	if [ $# -ne 1 ]; then
		echo "Usage: image_to_ascii <image_file>"
		return 1
	fi

	img2txt -W 180 -f utf8 -d fstein "$1"
}

# Function to compile and run a C++ file
run_cpp() {
	# Check if the file argument is provided
	if [ -z "$1" ]; then
		echo "Usage: run_cpp <file.cpp>"
		return 1
	fi

	# Get the filename without extension
	filename=$(basename -- "$1")
	filename="${filename%.*}"

	# Compile the C++ file to an executable
	g++ "$1" -O3 -o "${filename}.out"
	if [ $? -eq 0 ]; then
		echo "Compiled successfully to ${filename}.out"
		# Run the executable
		./"${filename}.out"
	else
		echo "Compilation failed"
	fi
}

# Function to compile and run a C file
run_c() {
	# Check if the file argument is provided
	if [ -z "$1" ]; then
		echo "Usage: run_c <file.c>"
		return 1
	fi

	# Get the filename without extension
	filename=$(basename -- "$1")
	filename="${filename%.*}"

	# Compile the C file to an executable
	gcc "$1" -O3 -o "${filename}.out"
	if [ $? -eq 0 ]; then
		echo "Compiled successfully to ${filename}.out"
		# Run the executable
		./"${filename}.out"
	else
		echo "Compilation failed"
	fi
}

convert_and_delete_pptx() {
	# Check if libreoffice is installed
	if ! command -v libreoffice &>/dev/null; then
		echo "LibreOffice is not installed. Please install it to use this function."
		return 1
	fi

	# Check if directory is specified
	if [ -z "$1" ]; then
		echo "Please provide a directory."
		return 1
	fi

	# Convert all pptx files to pdf
	for file in "$1"/*.pptx; do
		[ -e "$file" ] || continue
		libreoffice --headless --convert-to pdf "$file" --outdir "$1"
		if [ $? -eq 0 ]; then
			echo "Converted $file to PDF."
			rm "$file"
		else
			echo "Failed to convert $file."
		fi
	done
}

export LD_LIBRARY_PATH=/usr/lib/llvm-19/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib/llvm-20/lib:$LD_LIBRARY_PATH
. "$HOME/.cargo/env"

unzip_7z() {
	local filename="$1"
	local password="$2"

	if [[ -z "$filename" || -z "$password" ]]; then
		echo "Usage: unzip_7z <filename> <password>"
		return 1
	fi

	7z x "$filename" -p"$password"

	if [[ $? -eq 0 ]]; then
		echo "Extraction successful!"
	else
		echo "Extraction failed!"
		return 1
	fi
}

compile_cpp() {
	if [[ -z "$1" ]]; then
		echo "Please provide a C++ filename as an argument."
		return 1
	fi

	# Extract the filename without extension
	filename="${1%.cpp}"

	# Compile with gcc and optimization flag -O3
	g++ -O2 "$1" -o "${filename}.out"

	if [[ $? -eq 0 ]]; then
		echo "Compilation successful. Executable: ${filename}.out"
	else
		echo "Compilation failed."
	fi
}

compile_with_pthread() {
	if [[ -z "$1" ]]; then
		echo "Please provide a C filename as an argument."
		return 1
	fi

	# Extract the filename without extension
	filename="${1%.c}"

	# Compile with gcc and optimization flag -O3
	gcc -O2 -pthread "$1" -o "${filename}.out"

	if [[ $? -eq 0 ]]; then
		echo "Compilation successful. Executable: ${filename}.out"
	else
		echo "Compilation failed."
	fi
}

export PATH=$PATH:"/usr/local/texlive/2024/bin/x86_64-linux"

timer() {
	start=$(date +%s)
	"$@"
	end=$(date +%s)
	echo "Time taken: $((end - start)) seconds"
}

backup() {
	if [ -f "$1" ]; then
		cp "$1" "$1.bak"
		echo "Backup of $1 created as $1.bak"
	else
		echo "$1 does not exist."
	fi
}

findfile() {
	find . -iname "*$1*"
}

myip() {
	curl -s https://api.ipify.org
}

serve() {
	local port="${1:-8080}"
	local ip_address=$(hostname -I | awk '{print $1}')

	# Start the HTTP server in the background
	python3 -m http.server "$port" &

	# Print the access URL
	echo "Serving HTTP on http://$ip_address:$port/ (accessible from other devices)"

	# Wait for the server to stop
	wait $!
}

# This function will rename all files in the current directory by replacing spaces with underscores
rename_spaces() {
	for file in *\ *; do
		mv "$file" "${file// /_}"
	done
}

trash() {
	if [ $# -eq 0 ]; then
		echo "Usage: trash <file1> <file2> ..."
		return 1
	fi
	[ ! -d "$HOME/.trash" ] && mkdir "$HOME/.trash"
	mv "$@" "$HOME/.trash/"
}

flushdns() {
	sudo systemd-resolve --flush-caches
}

checkdisk() {
	df -h | grep -E '^/dev/*'
}

headers() {
	if [ -z "$1" ]; then
		echo "Usage: headers <URL>"
		return 1
	fi
	curl -I "$1"
}

fix_permissions() {
	find . -type d -exec chmod 755 {} \;
	find . -type f -exec chmod 644 {} \;
}

countdown() {
	if [ -z "$1" ]; then
		echo "Usage: countdown <seconds>"
		return 1
	fi
	secs=$1
	while [ $secs -gt 0 ]; do
		echo -ne "$secs\033[0K\r"
		sleep 1
		: $((secs--))
	done
	echo "Time's up!"
}

check_port() {
	if [ -z "$1" ]; then
		echo "Usage: check_port <port>"
		return 1
	fi
	nc -zv 127.0.0.1 $1
}

find_process() {
	if [ -z "$1" ]; then
		echo "Usage: find_process <process_name>"
		return 1
	fi
	ps aux | grep -i "$1" | grep -v grep
}

cleanup_old_files() {
	if [ -z "$1" ] || [ -z "$2" ]; then
		echo "Usage: cleanup_old_files <directory> <days>"
		return 1
	fi
	find "$1" -type f -mtime +"$2" -exec rm -f {} \;
}

check_url() {
	if [ -z "$1" ]; then
		echo "Usage: check_url <URL>"
		return 1
	fi
	if curl --output /dev/null --silent --head --fail "$1"; then
		echo "URL exists: $1"
	else
		echo "URL does not exist: $1"
	fi
}

uptime_info() {
	uptime -p
}

clearcache() {
	sudo sync
	sudo sysctl -w vm.drop_caches=3
}
