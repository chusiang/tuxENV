#!/bin/sh
# -------------------------------------------------------------------------
# The New Linux Counter Project
# Copyright (c) 2011 LinuxCounter project
# This script is licensed under GNU GPL version 2.0 or above
# For more info, please visit:
#            https://linuxcounter.net
# -------------------------------------------------------------------------

scriptversion="lico-update.sh version 0.3.17"

# -------------------------------------------------------------------------

export LANG=C
export PATH="${HOME}/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

if [ -x /bin/egrep ]; then
  EGREP="/bin/egrep"
elif [ -x /usr/bin/egrep ]; then
  EGREP="/usr/bin/egrep"
elif [ -x /usr/local/bin/egrep ]; then
  EGREP="/usr/local/bin/egrep"
fi

if [ -x /bin/grep ]; then
  GREP="/bin/grep"
elif [ -x /usr/bin/grep ]; then
  GREP="/usr/bin/grep"
elif [ -x /usr/local/bin/grep ]; then
  GREP="/usr/local/bin/grep"
fi

if [ -x /bin/head ]; then
  HEAD="/bin/head"
elif [ -x /usr/bin/head ]; then
  HEAD="/usr/bin/head"
elif [ -x /usr/local/bin/head ]; then
  HEAD="/usr/local/bin/head"
fi

if [ -x /bin/which ]; then
  WHICH="/bin/which"
elif [ -x /usr/bin/which ]; then
  WHICH="/usr/bin/which"
elif [ -x /usr/local/bin/which ]; then
  WHICH="/usr/local/bin/which"
fi

# Bins
WHICH=$( which which 2>/dev/null )
if [ "${WHICH}" = "" ]; then
  WHICH=$( type type 2>/dev/null | ${HEAD} -n 1 )
  if [ "${WHICH}" = "" ]; then
    WHICH=$( locate locate 2>/dev/null | ${EGREP} "bin/locate$" | ${HEAD} -n 1 )
    if [ "${WHICH}" = "" ]; then
      WHICH=$( find /usr/ -name find 2>/dev/null | ${EGREP} "bin/find$" | ${HEAD} -n 1 )
      if [ "${WHICH}" = "" ]; then
        echo "> No tool to locate the needed binaries found! I can not continue here!"
        exit 1
      else
        WHICH="${WHICH} / -name"
        HOW="find"
      fi
    else
      HOW="locate"
    fi
  else
    HOW="type"
  fi
else
  HOW="which"
fi

getBin() {
  binary="${1}"
  case "${HOW}" in
    "which")
      echo $( ${WHICH} ${binary} 2>/dev/null )
      ;;
    "type")
      # type is a shell builtin, so we don't have a path
      echo $( type -p ${binary} 2>/dev/null )
      ;;
    "locate")
      echo $( ${WHICH} ${binary} 2>/dev/null | ${EGREP} "bin/${binary}$" | ${GREP} -v proc | ${HEAD} -n 1 )
      ;;
    "find")
      for d in ${SPTH}; do
        f=$( ${WHICH} ${d} -name ${binary} | ${EGREP} "bin/${binary}$" | ${GREP} -v proc | ${HEAD} -n 1 )
        [[ ! "${f}" = "" ]] && break
      done
      echo "${f}"
      ;;
    *)
      echo $( ${WHICH} ${binary} 2>/dev/null )
      ;;
  esac
}

scriptJob() {
  s0=`echo ${SCRIPTNAME} | ${CUT} -d '.' -f 1`
  echo $s0
}

AT=$( getBin at 2>/dev/null )
AWK=$( getBin awk 2>/dev/null )
BASENAME=$( getBin basename 2>/dev/null )
CAT=$( getBin cat 2>/dev/null )
CRONTAB=$( getBin crontab 2>/dev/null )
CURL=$( getBin curl 2>/dev/null )
CUT=$( getBin cut 2>/dev/null )
DATE=$( getBin  date 2>/dev/null )
DF=$( getBin df 2>/dev/null )
DIFF=$( getBin diff 2>/dev/null )
DIRNAME=$( getBin dirname 2>/dev/null )
DMESG=$( getBin dmesg 2>/dev/null )
EGREP=$( getBin egrep 2>/dev/null )
FILE=$( getBin file 2>/dev/null )
FIND=$( getBin find 2>/dev/null )
GREP=$( getBin grep 2>/dev/null )
HEAD=$( getBin head 2>/dev/null )
ID=$( getBin id 2>/dev/null )
IFCONFIG=$( getBin ifconfig 2>/dev/null )
IOSTAT=$( getBin iostat 2>/dev/null )
KLDSTAT=$( getBin kldstat 2>/dev/null )
LAST=$( getBin last 2>/dev/null )
LASTLOG=$( getBin lastlog 2>/dev/null )
LASTLOGIN=$( getBin lastlogin 2>/dev/null )
LINKS=$( getBin links 2>/dev/null )
LS=$( getBin ls 2>/dev/null )
LSB_RELEASE=$( getBin lsb_release 2>/dev/null ) 
LSMOD=$( getBin lsmod 2>/dev/null )
MD5SUM=$( getBin md5sum 2>/dev/null )
NETCAT=$( getBin netcat 2>/dev/null )
NETSTAT=$( getBin netstat 2>/dev/null )
OD=$( getBin od 2>/dev/null )
PS=$( getBin ps 2>/dev/null )
PERL=$( getBin perl 2>/dev/null )
RUNLEVEL=$( getBin runlevel 2>/dev/null )
SED=$( getBin sed 2>/dev/null )
SORT=$( getBin sort 2>/dev/null )
SYSCTL=$( getBin sysctl 2>/dev/null )
TAIL=$( getBin tail 2>/dev/null )
UNAME=$( getBin uname 2>/dev/null )
W=$( getBin w 2>/dev/null )
WC=$( getBin wc 2>/dev/null )
WGET=$( getBin wget 2>/dev/null )
WHOAMI=$( getBin whoami 2>/dev/null )

HOSTNAME=$( getBin hostname 2>/dev/null )
PING=$( getBin ping 2>/dev/null ) 
UPTIME=$( getBin uptime 2>/dev/null )

if [ "${NETCAT}" = "" ]; then
  NETCAT=$( getBin nc 2>/dev/null )
fi

if [ "${HOME}" = "" ]; then
  if [ "${home}" = "" ]; then
    if [ "${WHOAMI}" != "" ]; then
      user=$( ${WHOAMI} )
      userhome="/home/${user}"
    else
      userhome="~"
    fi
  else
    userhome="${home}"
  fi
else
  userhome="${HOME}"
fi

export PATH="${userhome}/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
SPTH="${userhome}/bin /bin /usr/bin /sbin /usr/sbin /usr/local/bin /usr/local/sbin"
CONFDIR="${userhome}/.linuxcounter"
SPATH=$( pwd 2>/dev/null )
mypath="$( cd -P "$( ${DIRNAME} "$0" )" && pwd )"
SHADOW_FILE="/etc/shadow"
PASSWD_FILE="/etc/passwd"
LOGINDEFS_FILE="/etc/login.defs"
LSB_FILE="/etc/lsb-release"
myversion=$( echo ${scriptversion} | ${CUT} -d " " -f 3 )
SCRIPTNAME=$( ${BASENAME} ${0} )
SCRIPTJOB=$( scriptJob )
SCRIPT="${mypath}/${SCRIPTNAME}"

TMPDIR=""
if [ -w /tmp ]; then
   TMPDIR="/tmp"
elif [ -w /var/tmp ]; then
   TMPDIR="/var/tmp"
elif [ -w ${userhome}/tmp ]; then
   TMPDIR="${userhome}/tmp"
fi
if [ "${TMPDIR}" = "" ]; then
   TMPDIR="${CONFDIR}/tmp"
   if [ ! -d ${TMPDIR} ]; then
      mkdir -p ${TMPDIR}
   fi
fi

if [ -z "${1}" ]; then
  echo " Usage:  ${SCRIPTNAME} [--allow-root] [-i|-s|-m|-ci|-cu|-h|-v|-update]"
  echo " Use -h to get more help."
  exit 1
fi

allowroot=0
interactive=0
showdata=0
senddata=0
installcron=0
uninstallcron=0
showhelp=0
showversion=0
doupdate=0
wrongcmd=0
while [ $# -gt 0 ]
do
  case "x${1}x" in
    x-ix)           interactive=1;;
    x-sx)           showdata=1;;
    x-mx)           senddata=1;;
    x-cix)          installcron=1;;
    x-cux)          uninstallcron=1;;
    x-hx)           showhelp=1;;
    x-vx)           showversion=1;;
    x-updatex)      doupdate=1;;
    x--allow-rootx) allowroot=1;;
    *)              wrongcmd=1;;
  esac
  shift
done

if [ ${wrongcmd} -eq 1 ]; then
  echo " Usage:  ${SCRIPTNAME} [--allow-root] [-i|-s|-m|-ci|-cu|-h|-v|-update]"
  echo " Use -h to get more help."
  exit 1
fi


if [ "${CRONTAB}" = "" ]; then
  CRONTAB=$( getBin fcrontab 2>/dev/null )
  if [ "${CRONTAB}" = "" ]; then
    echo "> No cron daemon found! Only cron or fcron are supported!"
    echo "> Automatic machine updates through cron would not be possible!"
  else
    USECRON="fcrontab"
  fi
else
  USECRON="crontab"
fi

releasefile=""
releasefile=$( ${FIND} /etc -depth -mindepth 1 -maxdepth 1 -type f -iname "*-release" | ${GREP} -v lsb | ${GREP} -i -v strato )
if [ "${releasefile}" = "" ]; then
  releasefile=$( ${FIND} /etc -depth -mindepth 1 -maxdepth 1 -type f -iname "*version" )
fi

if [ "${UNAME}" = "" ]; then
  echo "> Program \"uname\" is needed to run this script!"
  exit 1
fi

OS=$( ${UNAME} )
if [ "${OS}" != "Linux" ]; then
  echo "This script actually supports only Linux!"
  exit 1
fi

if [ ! -r "${LSB_FILE}" -a "${LSB_RELEASE}" = "" -a "${releasefile}" = "" ]; then
  echo "> Program \"lsb_release\" is needed to run this script!"
  echo "  If this program is not available in your distribution repositories, then"
  echo "  Please create the file \"${LSB_FILE}\" with the following content:"
  echo "DISTRIB_ID=\"Your Distribution Name\""
  echo "DISTRIB_RELEASE=\"The version string of your distribution\""
  exit 1
fi
if [ "${GREP}" = "" ]; then
  echo "> Program \"grep\" is needed to run this script!"
  exit 1
fi
if [ "${CAT}" = "" ]; then
  echo "> Program \"cat\" is needed to run this script!"
  exit 1
fi
if [ "${HEAD}" = "" ]; then
  echo "> Program \"head\" is needed to run this script!"
  exit 1
fi
if [ "${TAIL}" = "" ]; then
  echo "> Program \"tail\" is needed to run this script!"
  exit 1
fi
if [ "${AWK}" = "" ]; then
  echo "> Program \"awk\" is needed to run this script!"
  exit 1
fi
if [ "${PING}" = "" ]; then
  echo "> Program \"ping\" is needed to run this script!"
  exit 1
fi
if [ "${SED}" = "" -a "${OS}" = "Linux" ]; then
  echo "> Program \"sed\" is needed to run this script!"
  exit 1
fi


if [ "${LSB_RELEASE}" = "" ]; then  
  if [ -r "${LSB_FILE}" ]; then 
    . ${LSB_FILE} 
    distribution="${DISTRIB_ID}" 
    distribversion="${DISTRIB_RELEASE}" 
  else 
    release=""
    if [ "${releasefile}" = "" ]; then
      if [ -d "/var/smoothwall" ]; then
        release="Smoothwall Linux"
      elif [ -n "$( getBin sorcery 2>/dev/null | ${GREP} -v ' ' )" -a -n "$( getBin gaze 2>/dev/null | ${GREP} -v ' ' )" ]; then
        release="Source Mage Linux"
      else
        release=""
      fi
    else
      case "${releasefile}" in
        /etc/gentoo-release)
          if [ -h /etc/make.profile ]; then
            release="Gentoo `${LS} -l /etc/make.profile 2>/dev/null | ${SED} -e 's;^.*/\([^/]*/[^/]*\)$;\1;' | tr '/' ' '`"
          else
            release="Gentoo"
          fi
          ;;
        /var/ipcop/general-functions.pl)
          release=`${GREP} 'version *=' ${releasefile} | ${HEAD} -n 1`
          ;;
        /etc/debian_version)
          release="Debian `${CAT} ${releasefile}`"
          ;;
        /etc/GoboLinuxVersion)
          release="GoboLinux `${CAT} ${releasefile}`"
          ;;
        /etc/knoppix-version)
          release="Knoppix `${CAT} ${releasefile}`"
          ;;
        /etc/zenwalk-version)
          release="Zenwalk `${CAT} ${releasefile}`"
          ;;
        *)
          release=$( ${CAT} ${releasefile} 2>/dev/null | ${HEAD} -n 1 )
          ;;
      esac
    fi
    if [ "${release}" = "" ]; then
      distribution=""
      distribversion=""
    else
      distribution=$( echo ${release} | ${AWK} '{print $1}' )
      distribversion=$( echo ${release} | ${AWK} '{print $2}' )
    fi
  fi 
else
  distribution=$(${LSB_RELEASE} -is) 
  distribversion=$(${LSB_RELEASE} -rs) 
fi

# OpenWrt
if [ "${distribution}" = "IPCop" -o "${distribution}" = "OpenWrt" ]; then
  if [ "$(${ID} -u)" != "0" ]; then
    echo "Your distribution needs to run this script as user \"root\"!"
    exit 1
  fi
else
  if [ "$(${ID} -u)" = "0" ]; then
    if [ ${allowroot} -eq 0 ]; then
      echo "DO NOT RUN THIS SCRIPT WITH USER \"root\"!!!"
      exit 1
    fi
  fi
fi

# Displays OS name for example FreeBSD, Linux etc
getOs(){
  echo "$(${UNAME})"
}

# Display hostname
# host (FQDN hostname), for example, vivek (vivek.text.com)
getHostName(){
  # try 'hostname -f'
  myhostname=$(${HNAME} -f 2>/dev/null || echo "")
  if [ "${OS}" = "Linux" ]; then
    if [ "${HOSTNAME}" = "" ]; then
      if [ -e /etc/hostname ] ; then
        myhostname=$( ${CAT} /etc/hostname 2>/dev/null )
      else
        myhostname=$( ${CAT} /proc/sys/kernel/hostname 2>/dev/null )
        mydomname=$( ${CAT} /proc/sys/kernel/domainname 2>/dev/null )
        if [ "${mydomname}" = "(none)" ]; then
          mydomname="unknown-domain"
        fi
        myhostname=${myhostname}.${mydomname}
      fi
    else
      myhostname=$( ${HOSTNAME} )
    fi
  fi
  if [ "${myhostname}" = "" ]; then
    echo "The hostname of this machine couldn't be found."
  echo "Please install the \"inetutils\" (a.k.a. net-tools) package."
    exit 1
  else
    echo ${myhostname}
  fi
}

# Display CPU information such as Make, speed
getAccounts(){
  if [ "${OS}" = "Linux" ]; then
    UID_MIN=""
    UID_MAX=""
    if [ -r "${LOGINDEFS_FILE}" ]; then
      UID_MIN=$( ${EGREP} "^UID_MIN" ${LOGINDEFS_FILE} | ${AWK} '{print $2}' )
      UID_MAX=$( ${EGREP} "^UID_MAX" ${LOGINDEFS_FILE} | ${AWK} '{print $2}' )
    fi
    if [ "${UID_MIN}" = "" ]; then
      UID_MIN=1000
    fi
    if [ "${UID_MAX}" = "" ]; then
      UID_MAX=10000
    fi
    echo $(${CAT} ${PASSWD_FILE} 2>/dev/null | ${AWK} -F':' '{ if($3 >= '${UID_MIN}' && $3 <= '${UID_MAX}') print $0 }' | ${WC} -l)
  fi
}

# Get CPU model name
getCpuInfo(){
  if [ "${distribution}" = "OpenWrt" ]; then
    [ "${OS}" = "Linux" ] && echo $(${GREP} -i "cpu model" /proc/cpuinfo | ${HEAD} -n 1 | ${SED} "s/.*: \(.*\)/\1/") || :
  else
    [ "${OS}" = "Linux" ] && echo $(${GREP} -i "model name" /proc/cpuinfo | ${HEAD} -n 1 | ${SED} "s/.*: \(.*\)/\1/") || :
  fi
}

# Get CPU MHz
getCpuFreq(){
  [ "${OS}" = "Linux" ] && echo $(${GREP} -i "cpu mhz" /proc/cpuinfo | ${HEAD} -n 1 | ${SED} "s/.*: \(.*\)/\1/") || :
}

# get CPU flags
getCpuFlags(){
  [ "${OS}" = "Linux" ] && echo $(${GREP} -i "flags" /proc/cpuinfo | ${HEAD} -n 1 | ${SED} "s/.*: \(.*\)/\1/") || :
}

# get CPU Cores
getNumCPUCores(){
  if [ "${distribution}" = "OpenWrt" ]; then
    [ "${OS}" = "Linux" ] && echo $(${GREP} -i "cpu model" /proc/cpuinfo | ${WC} -l) || :
  else
    [ "${OS}" = "Linux" ] && echo $(${GREP} -i "model name" /proc/cpuinfo | ${WC} -l) || :
  fi
}

# Display total RAM in system
getTotalRam(){
  [ "${OS}" = "Linux" ] && echo $(${GREP} -i "memtotal" /proc/meminfo | ${HEAD} -n 1 | ${SED} "s/.*: *\(.*\) kB/\1/") || :
}

# Display free RAM in system
getFreeRam(){
  [ "${OS}" = "Linux" ] && echo $(${GREP} -i "memfree" /proc/meminfo | ${HEAD} -n 1 | ${SED} "s/.*: *\(.*\) kB/\1/") || :
}

# Display total Swap in system
getTotalSwap(){
  [ "${OS}" = "Linux" ] && echo $(${GREP} -i "swaptotal" /proc/meminfo | ${HEAD} -n 1 | ${SED} "s/.*: *\(.*\) kB/\1/") || :
}

# Display free Swap in system
getFreeSwap(){
  [ "${OS}" = "Linux" ] && echo $(${GREP} -i "swapfree" /proc/meminfo | ${HEAD} -n 1 | ${SED} "s/.*: *\(.*\) kB/\1/") || :
}

# Display system load for last 5,10,15 minutes
getSystemLoad(){
  [ "${OS}" = "Linux" ] && echo "$(${UPTIME} | ${AWK} -F'load average:' '{ print $2 }')" || :
}

# List total number of users logged in (both Linux and FreeBSD)
getNumberOfLoggedInUsers(){
  [ "${OS}" = "Linux" ] && echo "$(${W} -h | ${CUT} -d " " -f 1 | ${SORT} -u | ${WC} -l)" || :
}

getTotalDiskSpace() {
  if [ "${OS}" = "Linux" ]; then
    olddf=$( [ -z "$( ${DF} --help | ${GREP} -- "-P" )" ] && echo "1" || echo "0" )
    if [ "${olddf}" = "1" ]; then
      space=$( ${DF} | ${EGREP} "^/dev/" | ${SED} "s/  */\ /g" | ${CUT} -d " " -f 2 | ${AWK} '{s+=$1} END {printf "%f", s}' )
    else
      space=$( ${DF} -l -P | ${EGREP} "^/dev/" | ${SED} "s/  */\ /g" | ${CUT} -d " " -f 2 | ${AWK} '{s+=$1} END {printf "%f", s}' )
    fi
    echo ${space}
  fi
}

getFreeDiskSpace() {
  [ "${OS}" = "Linux" ] && echo $(${DF} -l -P | ${EGREP} "^/dev/" | ${SED} "s/  */\ /g" | ${CUT} -d " " -f 4 | ${AWK} '{s+=$1} END {printf "%f", s}') || :
}

getUptime() {
  [ "${OS}" = "Linux" ] && echo $(${UPTIME} | ${SED} "s/.* up \([^,]*\), .*/\1/g") || :
}

getOnlineStatus() {
  if [ "${OS}" = "Linux" ]; then
    pingstatus=$( ${PING} -q -c 1 linuxcounter.net 2>&1 | ${GREP} -i packet | ${CUT} -d " " -f 1 )
    [ "${pingstatus}" = "" ] && echo "offline"
    [ "${pingstatus}" -gt 0 ] && echo "online"
  fi
}

# Encode argument as application/x-www-form-urlencoded
urlEncode(){
  echo "${1}" | ${AWK} '
    BEGIN { RS = sprintf("%c", 0) }  # operate on whole text including newlines
    { gsub(/%/,"%25")
      for (i = 1; i < 10; ++i) gsub(sprintf("%c", i),"%" sprintf("%.2X", i) )
      gsub(/\013/,"%0B"); gsub(/\014/,"%0C")
      for (i = 14; i < 32; ++i) gsub(sprintf("%c", i),"%" sprintf("%.2X", i) )
      gsub(/\041/,"%21"); gsub(/\042/,"%22"); gsub(/\043/,"%23")
      gsub(/\$/,"%24");   gsub(/\046/,"%26"); gsub(/\047/,"%27")
      gsub(/\(/,"%28");   gsub(/\)/,"%29");   gsub(/\*/,"%2A")
      gsub(/\+/,"%2B");   gsub(/\054/,"%2C"); gsub(/\057/,"%2F")
      gsub(/\072/,"%3A"); gsub(/\073/,"%3B"); gsub(/\074/,"%3C")
      gsub(/\075/,"%3D"); gsub(/\076/,"%3E"); gsub(/\?/,"%3F")
      gsub(/\100/,"%40"); gsub(/\[/,"%5B");   gsub(/\\/,"%5C")
      gsub(/\135/,"%5D"); gsub(/\^/,"%5E");   gsub(/\140/,"%60")
      gsub(/\{/,"%7B");   gsub(/\|/,"%7C");   gsub(/\175/,"%7D")
      for (i = 126; i < 256; ++i) gsub(sprintf("%c", i),"%" sprintf("%.2X", i) )
      gsub(/\040/,"+");   gsub(/\012/,"%0D%0A")  # convert LF to CR LF
      gsub(/\015%0D/,"%0D")  # do not double CR when already part of CR LF
      gsub(/\015/,"%0D"); sub(/%0D%0A$/,"")      # remove trailing CR LF
      print } '
}

if [ ${showhelp} -eq 1 ]; then
  echo ""
  echo "# -------------------------------------------------------------------- #"
  echo "#                        LiCo - The New Linux Counter Project          #"
  echo "# Copyright (c) 2011 LiCo - The New Linux Counter Project              #"
  echo "# This script is licensed under GNU GPL version 2.0 or above           #"
  echo "# For more info, please visit: https://linuxcounter.net                #"
  echo "# -------------------------------------------------------------------- #"
  echo ""
  echo " Usage:  ${SCRIPTNAME} [--allow-root] [-i|-s|-m|-ci|-cu|-h|-v|-update]"
  echo ""
  echo "   -i           Use this switch to enter interactive mode. The script will"
  echo "                then ask you a few questions related your counter"
  echo "                membership. Your entered data will be stored in"
  echo "                ${CONFDIR}/<hostname>"
  echo ""
  echo "   -s           This will show you what will be sent to the counter, without"
  echo "                sending anything. The script will only send with -m."
  echo ""
  echo "   -m           Use this switch to let the script send the collected data"
  echo "                to the counter project. If the machine entry does not exist,"
  echo "                it will be created."
  echo ""
  echo "   -ci          Use this switch to automatically create a cronjob (or at job)"
  echo "                for this script. The data will then get sent once per week."
  echo ""
  echo "   -cu          Use this to uninstall the cronjob (or at job)"
  echo ""
  echo "   -h           Well, you've just used that switch, no?"
  echo "   -v           This gives you the version of this script"
  echo ""
  echo "   -update      Get and install the most recent version (may need sudo!)"
  echo ""
  echo " Additional options:"
  echo ""
  echo "   --allow-root Allow the script to run as user \"root\"."
  echo ""
  echo ""
  echo " ATTENTION:"
  echo " You NEED to rerun \"${SCRIPTNAME} -i\" and enter your number and the"
  echo " number of the machine it has to update. Otherwise, the script would"
  echo " create a new machine on each run!"
  echo ""
  echo ""
  echo " More information here:  https://linuxcounter.net/script.html"
  echo ""
fi
if [ ${showversion} -eq 1 ]; then
  echo ""
  echo "# -------------------------------------------------------------------- #"
  echo "#                        LiCo - The New Linux Counter Project          #"
  echo "# Copyright (c) 2011 LiCo - The New Linux Counter Project              #"
  echo "# This script is licensed under GNU GPL version 2.0 or above           #"
  echo "# For more info, please visit: https://linuxcounter.net                #"
  echo "# -------------------------------------------------------------------- #"
  echo ""
  echo " ${scriptversion}"
  echo ""
fi
if [ ${installcron} -eq 1 ]; then
  ${CRONTAB} -l > ${TMPDIR}/crontab.tmp
  isset=$( ${GREP} "${SCRIPTJOB}" ${TMPDIR}/crontab.tmp )
  if [ "${isset}" != "" ]; then
    echo "The cronjob already is active!"
    exit 1
  else
    min=$((`${CAT} /dev/urandom | ${OD} -N1 -An -i` % 59))
    hour=$((`${CAT} /dev/urandom | ${OD} -N1 -An -i` % 23))
    dow=$((`${CAT} /dev/urandom | ${OD} -N1 -An -i` % 7))
    echo "# added by ${scriptversion}" >> ${TMPDIR}/crontab.tmp
    echo "${min} ${hour} * * ${dow} ${SCRIPT} -m" >> ${TMPDIR}/crontab.tmp
    ${CRONTAB} ${TMPDIR}/crontab.tmp
    rm ${TMPDIR}/crontab.tmp
    echo "The cronjob was successfully activated!"
  fi
fi
if [ ${uninstallcron} -eq 1 ]; then
  ${CRONTAB} -l > ${TMPDIR}/crontab.tmp
  isset=$( ${GREP} "${SCRIPTJOB}" ${TMPDIR}/crontab.tmp )
  if [ "${isset}" = "" ]; then
    echo "The cronjob is not active!"
    exit 1
  else
    ${SED} -e "/${SCRIPTJOB}/d" -e "/${scriptversion}/d" -i ${TMPDIR}/crontab.tmp
    ${CRONTAB} ${TMPDIR}/crontab.tmp
    status=$?
    rm ${TMPDIR}/crontab.tmp
    if [ ${status} -ne 0 ]; then
       echo "> cron encountered a problem and exited with status ${status}"
       exit ${status}
    fi
    echo "The cronjob was successfully removed!"
  fi
fi

script=${scriptversion}
hostname=$(getHostName)
version=$(${UNAME} -r)
machine=$(${UNAME} -m)
processor=$(getCpuInfo)
cpunum=$(getNumCPUCores)
flags=$(getCpuFlags)
totalram=$(getTotalRam)
freeram=$(getFreeRam)
totalswap=$(getTotalSwap)
freeswap=$(getFreeSwap)
load=$(getSystemLoad)
date=$(${DATE})
numusers=$(getNumberOfLoggedInUsers)
accounts=$(getAccounts)
totaldisk=$(getTotalDiskSpace)
freedisk=$(getFreeDiskSpace)
uptime=$(getUptime)
cpufreq=$(getCpuFreq)
update_key=""
online=$(getOnlineStatus)

if [ -r ${CONFDIR}/${hostname} ]; then
  if [ "$( ${FILE} ${CONFDIR}/${hostname} | ${CUT} -d " " -f 2)" = "ASCII" ]; then
    if [ ${interactive} -eq 0 ]; then
      echo "Host information file in wrong (old) format!"
      echo "Please run \"${SCRIPTNAME} -i\" first."
      exit 1
    fi
  else
    . ${CONFDIR}/${hostname}
  fi
else
  if [ ${interactive} -eq 0 ]; then
    echo "Host information file not found!"
    echo "Please run \"${SCRIPTNAME} -i\" first."
    exit 1
  fi
fi

if [ ${interactive} -eq 0 ]; then
  if [ "${machine_number}" != "" -a "${update_key}" = "" ]; then
    echo "ATTENTION: You have still not entered your LiCo Machine Update Key!"
    echo "Please login to your account, go to your profile edit the machine in question and get"
    echo "the update_key from the form (directly below the hostname field)."
    echo "Then run \"${SCRIPTNAME} -i\" and enter your counter number, the"
    echo "number for the machine this script has to update and the update_key for"
    echo "this machine."
    exit 1
  fi
fi

string="${script}##${hostname}##${counter_number}##${machine_number}##${processor}##${cpunum}##${accounts}##${totaldisk}##${totalram}##${numusers}##${freedisk}##${freeram}##${totalswap}##${freeswap}##${flags}##${machine}##${version}##${uptime}##${load}##${cpufreq}##${distribution}##${distribversion}##${online}##${update_key}"
if [ ${senddata} -eq 1 ]; then
  if [ "${machine_number}" = "" ]; then
    echo "ATTENTION: You have still not entered a machine number!"
    echo "Please run \"${SCRIPTNAME} -i\" and enter your counter number and the"
    echo "number for the machine this script has to update. Otherwise this script"
    echo "will create a new machine on each run!"
    echo ""
    echo "Continue anyway? [N/y]"
    read confirm
    if [ "${confirm}" = "" ]; then
      exit 1
    elif [ "${confirm}" = "y" -o "${confirm}" = "Y" ]; then
      true
    elif [ "${confirm}" = "n" -o "${confirm}" = "N" ]; then
      exit 1
    else    
      exit 1
    fi
  fi
  if [ "${machine_number}" != "" -a "${update_key}" = "" ]; then
    echo "ATTENTION: You have still not entered your LiCo Machine Update Key!"
    echo "Please login to your account, go to your profile edit the machine in question and get"
    echo "the update_key from the form (directly below the hostname field)."
    echo "Then run \"${SCRIPTNAME} -i\" and enter your counter number, the"
    echo "number for the machine this script has to update and the update_key for"
    echo "this machine."
    exit 1
  fi
  date=$( date +%Y%m%d%H%M%S )
  tmpfile="${TMPDIR}/lico-update.${counter_number}.${date}.tmp"
  sendstring=$( urlEncode "${string}" )
  
  wgetold="0"
  wgetnopost="1"
  curlnopost="1"
  if [ "${WGET}" != "" ]; then
    wgetold=$( [ -z "$( ${WGET} --help | ${GREP} -- "--no-check-certificate" )" ] && echo "1" || echo "0" )
    wgetnopost=$( [ -z "$( ${WGET} --help | ${GREP} -- "--post-data" )" ] && echo "1" || echo "0" )
  fi
  if [ "${CURL}" != "" ]; then
    curlnopost=$( [ -z "$( ${CURL} --help | ${GREP} -- "-d/--data" )" ] && echo "1" || echo "0" )
  fi
  
  if [ "${wgetnopost}" = "1" ]; then
    if [ "${curlnopost}" = "0" ]; then
      ${CURL} -d 'senddata='${sendstring}'' https://linuxcounter.net/api.php >/dev/null 2>&1
    else
      if [ "${NETCAT}" != "" ]; then
        echo "Trying to send the data with netcat. This is not supported yet!!!"
        echo "The sent data will not reach the server. If someone has a solution"
        echo "for the line 698, then please send it to info@linuxcounter.net"
        exit 1
        sendthis="POST http://linuxcounter.net/api.php HTTP/1.0\r\nHost: linuxcounter.net\r\nContent-type: application/x-www-form-urlencoded\r\nConnection: Close\r\n\r\nsenddata=${sendstring}"
        echo -ne "${sendthis}" | ${NETCAT} linuxcounter.net 80
      else
        if [ "${PERL}" != "" ]; then
          echo "Trying to send the data with Perl LWP. This is not supported yet!!!"
          echo "The script would not exit and run forever. If someone has a solution"
          echo "for the line 706, then please send it to info@linuxcounter.net"
          exit 1
          ${PERL} -ne 'use strict; use LWP::UserAgent; my $ua = new LWP::UserAgent(timeout => 5); $ua->agent("lico-update/0.3"); $ua->post("http://linuxcounter.net/api.php", ["senddata" => '"\"${sendstring}\""'] );'
        else
          echo "Trying to send the data with /dev/tcp. This is not supported yet!!!"
          echo "The sent data will not reach the server. If someone has a solution"
          echo "for the line 713 and following, then please send it to info@linuxcounter.net"
          exit 1
          # exec is a bash builtin, so we don't have a path
          exec 3<>/dev/tcp/linuxcounter.net/80
          echo -en "POST /api.php HTTP/1.0\r\n" >&3
          echo -en "Accept: text/html, text/plain\r\n" >&3
          echo -en "Accept-Language: en\r\n" >&3
          echo -en "User-Agent: ${scriptversion}\r\n" >&3
          echo -en "\r\n" >&3
          echo -en "senddata=${sendstring}\r\n" >&3
          while read LINE <&3
          do
            echo ${LINE}
          done
          exec 3>&-
        fi
      fi
    fi
  else
    if [ "${wgetold}" = "1" ]; then
      ${WGET} -q -O ${tmpfile} --post-data "senddata=${sendstring}" http://linuxcounter.net/api.php >/dev/null 2>&1
    else
      ${WGET} -q -O ${tmpfile} --no-check-certificate --post-data "senddata=${sendstring}" https://linuxcounter.net/api.php >/dev/null 2>&1
    fi
    output=$( ${CAT} ${tmpfile} )
    rm ${tmpfile}
    if [ "${output}" != "" ]; then
      echo ${output}
    fi
  fi
fi


if [ ${interactive} -eq 1 ]; then
  echo "> entering interactive mode..."
  echo ""
  echo "In order to assign the data sent by this script to the correct user"
  echo "account, I will need your counter user number."
  echo "Please enter your counter number:"
  echo -n " [${counter_number}]  "
  read counter_numbern
  if [ "${counter_numbern}" != "" ]; then
    counter_number=${counter_numbern}
  fi
  echo ""
  echo ""
  echo "If this machine already exists in your counter profile, then"
  echo "I will also need the machine counter number in order to assign"
  echo "the data to the correct machine."
  echo "Please enter the machine number (if any):  "
  echo -n " [${machine_number}]  "
  read machine_numbern
  if [ "${machine_numbern}" != "" ]; then
    machine_number=${machine_numbern}
  fi
  echo ""
  echo ""
  echo "In order to be able to update this machine, I will need the"
  echo "machine update_key. "
  echo "Please login to your account, go to your profile edit the machine in question and get"
  echo "the update_key from the form (directly below the hostname field)."
  echo "Please enter your update_key for this machine (if any):  "
  echo -n " [${update_key}]  "
  read update_keyn
  if [ "${update_keyn}" != "" ]; then
    update_key=${update_keyn}
  fi
  if [ "${machine_number}" != "" -a "${update_key}" = "" ]; then
    echo "Without the update_key for this machine, I can not continue. Sorry."
    exit 1
  fi
  echo ""
  echo ""
  if [ "${distribution}" = "" ]; then
    echo "I was not able to detect your distribution on this machine."
    echo "Please enter the name of the distribution (without version!):  "
    echo -n " [${distribution}]  "
    read distributionn
    if [ "${distributionn}" != "" ]; then
      distribution=${distributionn}
    fi
    echo ""
    echo ""
  fi
  if [ "${distribversion}" = "" ]; then
    echo "I was not able to detect the version of your distribution."
    echo "Please enter only the version information of this distribution:  "
    echo " [${distribversion}]  "
    read distribversionn
    if [ "${distribversionn}" != "" ]; then
      distribversion=${distribversionn}
    fi
    echo ""
    echo ""
  fi
  if [ ! -d ${CONFDIR} ]; then
    mkdir ${CONFDIR}
    chmod 700 ${CONFDIR}
  fi
  rm ${CONFDIR}/${hostname} 2>/dev/null
  echo "#!/bin/bash" > ${CONFDIR}/${hostname}
  echo "scriptversion='${scriptversion}'" >> ${CONFDIR}/${hostname}
  echo "hostname='${hostname}'" >> ${CONFDIR}/${hostname}
  echo "counter_number='${counter_number}'" >> ${CONFDIR}/${hostname}
  echo "update_key='${update_key}'" >> ${CONFDIR}/${hostname}
  echo "machine_number='${machine_number}'" >> ${CONFDIR}/${hostname}
  echo "distribution='${distribution}'" >> ${CONFDIR}/${hostname}
  echo "distribversion='${distribversion}'" >> ${CONFDIR}/${hostname}
  chmod 700 ${CONFDIR}/${hostname}
  echo "Host file created: ${CONFDIR}/${hostname}"
  echo "Thanks!"
fi

if [ ${showdata} -eq 1 ]; then
  echo " The following data will be sent to the counter:"
  echo ""
  echo " ================================================================"
  echo " Script:           ${script}"
  echo " Hostname:         ${hostname}"
  echo " update_key:       ${update_key}"
  echo " onlinestatus:     ${online}"
  echo " Distribution:     ${distribution}"
  echo " Distrib Version:  ${distribversion}"
  echo " Counter Num:      ${counter_number}"
  echo " Machine Num:      ${machine_number}"
  echo " Processor:        ${processor}"
  echo " CPU Frequency:    ${cpufreq}"
  echo " CPU flags:        ${flags}"
  echo " Num cores:        ${cpunum}"
  echo " Num of Accounts:  ${accounts}"
  echo " Num of users:     ${numusers}"
  echo " Total diskspace:  ${totaldisk}"
  echo " Free diskspace:   ${freedisk}"
  echo " Total RAM:        ${totalram}"
  echo " Free RAM:         ${freeram}"
  echo " Total Swap:       ${totalswap}"
  echo " Free Swap:        ${freeswap}"
  echo " Architecture:     ${machine}"
  echo " Kernel:           ${version}"
  echo " Uptime:           ${uptime}"
  echo " Load:             ${load}"
  echo " ================================================================"
  echo " The string that sends the data consists of all information mentioned above"
  echo " separated by \"##\"."
  echo ""
  echo " Actually nothing was sent to the counter! Use -m to send the data."
fi

if [ ${doupdate} -eq 1 ]; then
  if [ ! -d ${CONFDIR}/old ]; then
    echo " > Creating backup dir ${CONFDIR}/old..."
    mkdir -p ${CONFDIR}/old
  fi
  cd ${TMPDIR}
  echo " > Getting last version of ${SCRIPTNAME}..."
  wgetbusybox=$( [ -z "$( ${WGET} --help | ${GREP} -- "-N" )" ] && echo "1" || echo "0" )
  wgetwoprefix=$( [ -z "$( ${WGET} --help | ${GREP} -- "prefix" )" ] && echo "1" || echo "0" )
  wgopt=""
  if [ "${wgetwoprefix}" = "0" ]; then
     wgopt=" -P ${TMPDIR}"
  fi
  if [ "${wgetbusybox}" = "1" ]; then
    ${WGET}${wgopt} -q http://linuxcounter.net/script/lico-update.sh
  else
    ${WGET}${wgopt} -q -N --no-cache http://linuxcounter.net/script/lico-update.sh
  fi
  if [ "${DIFF}" != "" ]; then
    isnew=$( ${DIFF} -u ${TMPDIR}/lico-update.sh ${mypath}/${SCRIPTNAME} )
    if [ "${isnew}" = "" ]; then
      rm ${TMPDIR}/lico-update.sh
      echo " ! You already have the most recent version installed!"
      exit 0
    fi
  fi
  cd ${SPATH}
  echo " ! New version detected! Installing..."
  if [ -r ${mypath}/${SCRIPTNAME} ]; then 
    echo " > Copying ${SCRIPTNAME} to ${CONFDIR}/old/lico-update-${myversion}.sh..."
    cp -fp ${mypath}/${SCRIPTNAME} ${CONFDIR}/old/lico-update-${myversion}.sh
  fi
  echo " > Moving ${TMPDIR}/lico-update.sh to \"${SCRIPTNAME}\"..."
  echo "   (if you get an error, use \"sudo\"!)"
  if [ -w ${mypath}/${SCRIPTNAME} ]; then
    mv ${TMPDIR}/lico-update.sh ${mypath}/${SCRIPTNAME}
    chmod +x ${mypath}/${SCRIPTNAME}
    echo " ! Update finished!"
  else
    rm ${TMPDIR}/lico-update.sh 2>/dev/null
    echo " ! I was not able to copy ${TMPDIR}/lico-update.sh to ${mypath}/${SCRIPTNAME}!"
    exit 1
  fi
fi













exit 0
# end
