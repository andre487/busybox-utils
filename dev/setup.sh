#!/usr/bin/env bash
set -eufo pipefail
cd "$(dirname "$0")/.."

cur_dir="$PWD"
# shellcheck disable=SC2016
export_expression='export PATH="$PATH:'"$cur_dir"'"'

shell_base_name="$(basename "$SHELL")"
rc_file_path=''
if [[ "$shell_base_name" == sh ]]; then
    for file_name in .profile .bash_profile .bash_login .bashrc; do
        rc_file_path="$HOME/$file_name"
        if [[ -f "$rc_file_path" ]]; then
            break
        fi
        rc_file_path=''
    done
elif [[ "$shell_base_name" == bash ]]; then
    for file_name in .bash_profile .bash_login .bashrc .profile; do
        rc_file_path="$HOME/$file_name"
        if [[ -f "$rc_file_path" ]]; then
            break
        fi
        rc_file_path=''
    done
elif [[ "$shell_base_name" == zsh ]]; then
    for file_name in .zsh_profile .zsh_login .zshrc.extra .zshrc .profile; do
        rc_file_path="$HOME/$file_name"
        if [[ -f "$rc_file_path" ]]; then
            break
        fi
        rc_file_path=''
    done
else
    echo "Unsupported shell: $SHELL" >/dev/stderr
    echo "Please add this string to your rc-file: $export_expression" >/dev/stderr
    exit 1
fi

if [[ -z "$rc_file_path" ]]; then
    echo "Unexpected configs layout for $SHELL" >/dev/stderr
    echo "Please add this string to your rc-file: $export_expression" >/dev/stderr
    exit 1
fi

if grep -E "export PATH=.*$cur_dir" "$rc_file_path" &>/dev/null; then
    echo "Toolset is already known in this system" >/dev/stderr
    exit 0
fi


cat  << EOF >>"$rc_file_path"
#
# Busybox utils init
# See: https://github.com/andre487/busybox-utils
#
$export_expression
EOF

echo "Success! Now re-login or make source $rc_file_path" >/dev/stderr
