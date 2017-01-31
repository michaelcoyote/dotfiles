#
# Handy place to store all my bash functions
# some of these are stolen from elsewhere some I've written myself.
#

#------------------------------------------------------
# File manipulation and managment functions.
#
# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fexec() { find . -type f -iname '*'"${1:-}"'*' \
-exec "${2:-file}" {} \;  ; }

function swapname()
{ # Swap 2 filenames around, if they exist (from Uzi's bashrc).
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e "$1" ] && echo "swap: $1 does not exist" && return 1
    [ ! -e "$2" ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}


#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------


function myps() { ps "$@" -u "$USER" -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { myps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }


function killps()   # kill by process name
{
    local pid pname sig="-TERM"   # default signal
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(myps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} )
    do
        pname=$(myps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
            then kill "$sig" "$pid"
        fi
    done
}

function mydf()         # Pretty-print of 'df' output.
{                       # Inspired by 'dfc' utility.
    for fs ; do

        if [ ! -d $fs ]
        then
          echo -e $fs" :No such file or directory" ; continue
        fi

        local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
        local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
        local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
        local out="["
        for ((j=0;j<20;j++)); do
            if [ ${j} -lt ${nbstars} ]; then
               out=$out"*"
            else
               out=$out"-"
            fi
        done
        out="${info[2]} $out] ($free free on $fs)"
        echo -e "$out"
    done
}

function iflist() {
  ifconfig -a | awk '/^[^[[:space:]]/ { split($0,iface,"  ");
         print iface[1]
    }'
}

function ifarray() {
  ifconfig -a | awk '/^[^[[:space:]]/{a[NR]=$1} 
    END {count=asort(a,b);
        for(i=1;i<count;i++){printf "%s,", b[i]};
        printf "%s\n", b[count]
    }'
}

# TODO clean this up to just print if:addr pairs.
function ip() {
    ifconfig -a | awk 'BEGIN {RS="";FS="\n"} 
        {split($1,iface," "); 
            gsub(/^[ /t]+inet/,"",$2); 
            if ($2 ~ /addr/) print iface[1]":"$2
        }'
} 

function hii()   # Get current host related info.
{
    echo -e "\nYou are logged on $HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\nUsers logged on:$NC " ; w -h |
             cut -d " " -f1 | sort | uniq
    echo -e "\nCurrent date :$NC " ; date
    echo -e "\nMachine stats :$NC " ; uptime
    echo -e "\nMemory stats :$NC " ; free
    echo -e "\nDiskspace :$NC " ; mydf / "$HOME"
    echo -e "\nLocal IP Addresses :$NC" ; ip
    echo -e "\nOpen connections :$NC "; netstat -pan --inet;
    echo
}

#-------------------------------------------------------------
# Misc utilities:
#-------------------------------------------------------------
function repeat()       # Repeat n times command.
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}

function ask()          # See 'killps' for example of use.
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

function corename()   # Get name of app that created a corefile.
{
    for file ; do
        echo -n $file : ; gdb --core=$file --batch | head -1
    done
}

# convert mac to an IPv6 link local
mac2ipv6 () {
    IFS=':'; set "$1"; unset IFS
    ipv6_address="fe80::$(printf %02x $((0x$1 ^ 2)))$2:${3}ff:fe$4:$5$6"
    echo "$ipv6_address"
}


# change xterm frame title 
function xtitle()
{
    case "$TERM" in
    *term* | rxvt)
        echo -en  "\033]0;$*\007" ;;
    *)  ;;
    esac
}

# really basic grep function to find IP/netmask octets.
function ipgrep()
{
# find any pattern from "0.0.0.0" to "259.259.259.259"
# TODO fix this so it checks for legal octets (255.255.255.255) (Note: may be some time)
grep -o -E '\b(((2[0-5]|1[0-9])|[0-9])?([0-9]){1,2}\.){3}((2[0-5]|1[0-9])|[0-9])?([0-9])\b'
} 

# Parse git branch branch for prompt
parse_git_branch () {
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
  }

