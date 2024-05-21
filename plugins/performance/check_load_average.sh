#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This script has the ability to verify the current server load average, with the  #
# option to alter the comparison parameters. By default, it examines the 5-minute  #
# average against the warning and critical thresholds, but you can modify this by  #
# using the optional '-i' parameter.                                               #
#                                                                                  #
#  Usage: load_average.sh [ -h ] [ -i value ] [ -w value ] [ -c value ]            #
#    -h      : Print this screen                                                   #
#    -i      : Time interval [Default: 5, Valid Options: 1, 5 or 15]               #
#    -w      : Warn level [Default: 3.0]                                           #
#    -c      : Critial level [Default: 5.0]                                        #
#                                                                                  #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Flags                                                                            #
# -------------------------------------------------------------------------------- #
# A set of global flags that we use for configuration.                             #
# -------------------------------------------------------------------------------- #

ALLOW_ZERO_INPUT=true            # Do we require any user input ?

# -------------------------------------------------------------------------------- #
# Global Variables                                                                 #
# -------------------------------------------------------------------------------- #
# As Bash does not provide a straightforward method for passing associative arrays #
# to functions, we've decided to employ global variables to preserve the script's  #
# simplicity.                                                                      #
# -------------------------------------------------------------------------------- #

WARNING_LEVEL=3.0
CRITICAL_LEVEL=5.0
INTERVAL=5

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
    # shellcheck disable=SC2312
    if (( INTERVAL == 1)); then
        LOAD_AVERAGE=$(uptime | awk '{print $10}' | cut -d "," -f 1)
    elif (( INTERVAL == 5)); then
        LOAD_AVERAGE=$(uptime | awk '{print $11}' | cut -d "," -f 1)
    elif (( INTERVAL == 15)); then
        LOAD_AVERAGE=$(uptime | awk '{print $12}' | cut -d "," -f 1)
    fi
    
    [[ -z ${LOAD_AVERAGE} ]] && handle_unknown "Unable to get load average"

    # shellcheck disable=SC2312
    if (( $(echo "${LOAD_AVERAGE} >= ${CRITICAL_LEVEL}" | bc -l) )); then
        handle_critical "${LOAD_AVERAGE} (${INTERVAL} minute average)"
    elif (( $(echo "${LOAD_AVERAGE} >= ${WARNING_LEVEL}" | bc -l) )); then
        handle_warning "${LOAD_AVERAGE} (${INTERVAL} minute average)"
    elif (( $(echo "${LOAD_AVERAGE} >= 0" | bc -l) )); then
        handle_ok "${LOAD_AVERAGE} (${INTERVAL} minute average)"
    else
        handle_unknown "${LOAD_AVERAGE} (${INTERVAL} minute average)"
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
  Usage: $0 [ -h ] [ -i value ] [ -w value ] [ -c value ]
    -h      : Print this screen
    -i      : Time interval [Default: 5, Valid Options: 1, 5 or 15]
    -w      : Warn level [Default: ${WARNING_LEVEL}]
    -c      : Critial level [Default: ${CRITICAL_LEVEL}]
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

    while getopts ":hi:c:w:" opt; do
        case ${opt} in
            h)
                usage
                ;;
            i)
                INTERVAL=${OPTARG}
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

    if (( INTERVAL != 1 )) && (( INTERVAL != 5 )) && (( INTERVAL != 15)); then
        handle_unknown "Invalid time internal ${INTERVAL}"
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
