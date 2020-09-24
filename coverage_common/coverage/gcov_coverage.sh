#!/bin/bash

# These are filled in by the gcov_coverage rule
GCOV_PATH=%GCOV_PATH_STRING%
LCOV_PATH=%LCOV_PATH_STRING%
GCOV_OPTIONS=""

# passed along to the original lcov merge tool
ORIGINAL_OPTS=$@

opts=$(getopt --longoptions "coverage_dir:: output_file::" --options "" --name "$0" -- "$@")
eval set --$opts

while [[ $# -gt 0 ]]; do
    case "$1" in
        --coverage_dir)
            COVERAGE_DIR=$2
            shift
            ;;

        --output_file)
            OUTPUT_FILE=$2
            shift
            ;;

        --source_file_manifest)
            COVERAGE_MANIFEST=$2
            shift
            ;;

        --)
            break
            ;;
        *)
            ;;
    esac
    shift
done

# Copy gcno files next to the corresponding gcda files in $COVERGE_DIR.
# Then call gcov and move the output file to the output directory
while read -r line; do
    if [[ ${line: -4} == "gcno" ]]; then
        gcno_path=${line}
        gcda="${COVERAGE_DIR}/$(dirname ${gcno_path})/$(basename ${gcno_path} .gcno).gcda"
        if [[ -f "$gcda" ]]; then
            if [ ! -f "${COVERAGE_DIR}/${gcno_path}" ]; then
                mkdir -p "${COVERAGE_DIR}/$(dirname ${gcno_path})"
                cp "$ROOT/${gcno_path}" "${COVERAGE_DIR}/${gcno_path}"
            fi

            # Invoke gcov
            "${GCOV_PATH}" -ib $GCOV_OPTIONS -o "$(dirname ${gcda})" "${gcda}" || exit 1

            mv -- *.gcov.json.gz "$COVERAGE_DIR"
        fi
    fi
done < "${COVERAGE_MANIFEST}"

# We depend on $ROOT being set by bazel's collect_coverage script
$ROOT/${LCOV_PATH} ${ORIGINAL_OPTS}
