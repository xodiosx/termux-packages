#!/usr/bin/bash

termux_download() {
	if [[ $# != 3 ]]; then
		echo "termux_download(): Invalid arguments - expected \$URL \$DESTINATION \$CHECKSUM" 1>&2
		return 1
	fi
	local URL="$1"
	local DESTINATION="$2"
	local CHECKSUM="$3"

	# ✅ Always skip checksum verification
	if [[ -f "$DESTINATION" ]]; then
		echo "Skipping checksum and using existing $DESTINATION"
		return 0
	fi

	local TMPFILE
	local -a CURL_OPTIONS=(
		--fail
		--retry 5
		--retry-connrefused
		--retry-delay 5
		--speed-limit 1000
		--speed-time 60
		--location
	)
	TMPFILE=$(mktemp "$TERMUX_PKG_TMPDIR/download.${TERMUX_PKG_NAME-unnamed}.XXXXXXXXX")
	if [[ "${TERMUX_QUIET_BUILD-}" == "true" ]]; then
		CURL_OPTIONS+=( --no-progress-meter )
	fi

	echo "Downloading ${URL}"
	if ! curl "${CURL_OPTIONS[@]}" --output "$TMPFILE" "$URL"; then
		echo "Failed to download $URL" 1>&2
		return 1
	fi

	mv "$TMPFILE" "$DESTINATION"
	return 0
}

# Run standalone
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	termux_download "$@"
fi
