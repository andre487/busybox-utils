#!/usr/bin/env bash
set -eufo pipefail
cd "$(dirname "$0")/.."

IFS=$'\n' read -r -d '' -a files < <(
    find . \
        -not -path './.git/*' \
        -not -path './dev/*' \
        -type f \
        -exec grep -Iq '# Command is autogenerated by ./dev/generate-command.sh' {} \; \
        -print  && \
    printf '\0'
)

for file_name in "${files[@]}"; do
    read -r -d '' -a command < <(
        # shellcheck disable=SC2016
        grep -oE '^"\$bin" .+$' "$file_name" | sed -E 's#^"\$bin" ##' | sed -E 's# "\$@"$##' &&
        printf '\0'
    )

    if [[ -z "${command[*]:-}" ]]; then
        continue
    fi

    ./dev/generate-command.sh "${command[@]}"
done
