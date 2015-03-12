#!/bin/bash

function download_and_unpack() {
    if [ -z "${1}" ] || [ -z "${2}" ]; then
        echo "download_and_unpack: expected two arguments"
        return 1
    fi

    local pkg=${1}
    local pkg_url=${2}

    # Determin the extraction directory
    local extract_dir=''
    if [ ! -z "${3}" ]; then
        extract_dir="${3}"
    else
        local pkg_len=${#pkg}
        if [[ "${pkg}" == *'.tar.gz' ]]; then
            extract_len=$((pkg_len - 7))
        elif [[ "${pkg}" == *'.tgz' ]]; then
            extract_len=$((pkg_len - 4))
        elif [[ "${pkg}" == *'.tar.bz2' ]]; then
            extract_len=$((pkg_len - 8))
        else
            echo "ERROR: ${pkg} unknown extension."
            exit -1
        fi
        extract_dir="${pkg:0:extract_len}"
    fi

    # Determin extract arguments
    local extract_args=xfz
    if [[ "${pkg}" == *'.tar.bz2' ]]; then
        extract_args=xfj
    fi

    # Download the package
    echo "Downloading ${pkg}:"
    if [ ! -f "${pkg}" ] || [ ! -d "${extract_dir}" ]; then
        wget --progress=dot --output-document=./${pkg} ${pkg_url}
        echo "- done"
    else
        echo "- skipping file exists."
    fi

    # Check file (incase openshift hangsup)
    echo "Unpacking ${pkg}:"
    local check_file=`md5sum ${pkg} | awk '{ print $1 }'`
    if [ -f ${check_file} ]; then
        echo "- cleaning failure."
        # We know extraction failed previously
        # So remove that folder
        rm -rf "${extract_dir}"
    elif [ -d "${extract_dir}" ]; then
        # The directory exists so don't extract again
        echo "- skipping directory exists."
        return 0
    fi

    # Extract
    touch ${check_file}
    tar ${extract_args} "${pkg}"

    # Done so remove the check file
    rm ${check_file}
    echo "- done."

    return 0
}
