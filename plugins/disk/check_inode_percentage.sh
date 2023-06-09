#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# The purpose of this script is to determine the percentage of utilised inodes for #
# a specified mount point or path.                                                 #
#                                                                                  #
#  Usage: check_inode_percentage.sh [ -h ] [ -m value ] [ -c value ] [ -w value ]  #
#    -h      : Print this screen                                                   #
#    -m      : Mount point                                                         #
#    -c      : Critial level [Default: 90]                                         #
#    -w      : Warn level [Default: 75]                                            #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Flags                                                                            #
# -------------------------------------------------------------------------------- #
# A set of global flags that we use for configuration.                             #
# -------------------------------------------------------------------------------- #

ALLOW_ZERO_INPUT=false            # Do we require any user input ?

# -------------------------------------------------------------------------------- #
# Global Variables                                                                 #
# -------------------------------------------------------------------------------- #
# As Bash does not provide a straightforward method for passing associative arrays #
# to functions, we've decided to employ global variables to preserve the script's  #
# simplicity.                                                                      #
# -------------------------------------------------------------------------------- #

CRITICAL_LEVEL=90
WARNING_LEVEL=75

# -------------------------------------------------------------------------------- #
# Main                                                                             #
# -------------------------------------------------------------------------------- #
# This function is where you can include all the code related to the check. You're #
# free to define additional functions and invoke them whenever necessary.          #
#                                                                                  #
# In this template, we've generated a random number to illustrate how to call the  #
# core functions that manage the different states. However, real tests will be     #
# more intricate and elaborate, but they should adhere to the same fundamental     #
# structure.                                                                       #
# -------------------------------------------------------------------------------- #

function main()
{
    if ( ! df -i "${MOUNT_POINT}" > /dev/null 2>&1 ); then
        handle_critical "${MOUNT_POINT} is not a valid file system"
    fi

    # shellcheck disable=SC2312
    USED_DISK_SPACE=$(df -i "${MOUNT_POINT}" 2>/dev/null | grep -v Filesystem | awk '{print $5}' | sed 's/%//g')

    [[ -z ${USED_DISK_SPACE} ]] && handle_unknown "Unable to get disk usage for ${MOUNT_POINT}"

    # shellcheck disable=SC2312
    if (( $(echo "${USED_DISK_SPACE} >= ${CRITICAL_LEVEL}" | bc -l) )); then
        handle_critical "${USED_DISK_SPACE}% of inodes used on ${MOUNT_POINT}"
    elif (( $(echo "${USED_DISK_SPACE} >= ${WARNING_LEVEL}" | bc -l) )); then
        handle_warning "${USED_DISK_SPACE}% of inodes used on ${MOUNT_POINT}"
    elif (( $(echo "${USED_DISK_SPACE} >= 0" | bc -l) )); then
        handle_ok "${USED_DISK_SPACE}% of inodes used on ${MOUNT_POINT}"
    else
        handle_unknown "${USED_DISK_SPACE}% of inodes used on ${MOUNT_POINT}"
    fi
}

# -------------------------------------------------------------------------------- #
# Usage (-h parameter)                                                             #
# -------------------------------------------------------------------------------- #
# This function is used to show the user 'how' to use the script.                  #
# -------------------------------------------------------------------------------- #

function usage()
{
cat <<EOF
  Usage: $0 [ -h ] [ -m value ] [ -c value ] [ -w value ]
    -h      : Print this screen
    -m      : Mount point
    -c      : Critial level [Default: ${CRITICAL_LEVEL}]
    -w      : Warn level [Default: ${WARNING_LEVEL}]
EOF
    exit 0
}

# -------------------------------------------------------------------------------- #
# Process Arguments                                                                #
# -------------------------------------------------------------------------------- #
# This function handles the input from the command line. In this template, we've   #
# included an illustration of how to retrieve and process fresh warning and        #
# critical values.                                                                 #
#                                                                                  #
# You can add as many fresh inputs as your check requires. It's important to       #
# ensure that all the values are designated as global variables so that main() can #
# access them easily.                                                              #
# -------------------------------------------------------------------------------- #

function process_arguments()
{
    if [[ "${ALLOW_ZERO_INPUT}" = false ]] && [[ $# -eq 0 ]]; then
        handle_unknown "No parameters given"
    fi

    while getopts ":hm:c:w:" opt; do
        case ${opt} in
            h)
                usage
                ;;
            m)
                MOUNT_POINT=${OPTARG}
                ;;
            c)
                CRITICAL_LEVEL=${OPTARG}
                ;;
            w)
                WARNING_LEVEL=${OPTARG}
                ;;
            \?)
                handle_unknown "Invalid option"
                ;;
            :)
                handle_unknown "Option -${OPTARG} requires an argument."
                ;;
            *)
                usage
                ;;
        esac
    done

    # shellcheck disable=SC2312
    if (( $(echo "${WARNING_LEVEL} >= ${CRITICAL_LEVEL}" | bc -l) )); then
        handle_unknown "Warn level MUST be lower than Critical level"
    fi

    if [[ -z ${MOUNT_POINT} ]]; then
        handle_unknown "Mount point must be set!"
    fi
    main
}

# -------------------------------------------------------------------------------- #
# STOP HERE!                                                                       #
# -------------------------------------------------------------------------------- #
# The functions listed below are integral to the template and do not necessitate   #
# any modifications to use this template. If you intend to make changes to the     #
# code beyond this point, please make certain that you comprehend the consequences #
# of those alterations!                                                            #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Handle OK                                                                        #
# -------------------------------------------------------------------------------- #
# If provided with a message, this function will show it with the 'OK' prefix and  #
# subsequently terminate the script with the requisite exit code of 0.             #
# -------------------------------------------------------------------------------- #

function handle_ok()
{
    local message="${*:-}"

    [[ -n ${message} ]] && echo "OK - ${message}"
    exit 0
}

# -------------------------------------------------------------------------------- #
# Handle Warning                                                                   #
# -------------------------------------------------------------------------------- #
# If provided with a message, this function will show it with the 'WARNING' prefix #
# and subsequently terminate the script with the requisite exit code of 1.         #
# -------------------------------------------------------------------------------- #

function handle_warning()
{
    local message="${*:-}"

    [[ -n ${message} ]] && echo "WARNING - ${message}"
    exit 1
}

# -------------------------------------------------------------------------------- #
# Handle Critical                                                                  #
# -------------------------------------------------------------------------------- #
# If provided with a message, this function will show it with the 'CRITICAL'       #
# prefix and subsequently terminate the script with the requisite exit code of 2.  #
# -------------------------------------------------------------------------------- #

function handle_critical()
{
    local message="${*:-}"

    [[ -n ${message} ]] && echo "CRITICAL - ${message}"
    exit 2
}

# -------------------------------------------------------------------------------- #
# Handle Unknown                                                                   #
# -------------------------------------------------------------------------------- #
# If provided with a message, this function will show it with the 'UNKNOWN' prefix #
# and subsequently terminate the script with the requisite exit code of 3.         #
# -------------------------------------------------------------------------------- #

function handle_unknown()
{
    local message="${*:-}"

    [[ -n ${message} ]] && echo "UNKNOWN - ${message}"
    exit 3
}

# -------------------------------------------------------------------------------- #
# The Core                                                                         #
# -------------------------------------------------------------------------------- #
# This is the central component of the script.                                     #
# -------------------------------------------------------------------------------- #

process_arguments "${@}"

# -------------------------------------------------------------------------------- #
# End of Script                                                                    #
# -------------------------------------------------------------------------------- #
# This is the end - nothing more to see here.                                      #
# -------------------------------------------------------------------------------- #
