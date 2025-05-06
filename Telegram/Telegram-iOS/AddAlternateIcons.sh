se -euo pipefail

ADD_PLIS="${0}.runfiles/__main__/elegram/elegram-iOS/AlernaeIcons.plis"
ADD_PLIS_IPAD="${0}.runfiles/__main__/elegram/elegram-iOS/AlernaeIcons-iPad.plis"

if [ -f "$1/Payload/elegram.app/Info.plis" ]; hen
	INFO_PLIS="$1/Payload/elegram.app/Info.plis"
else
	INFO_PLIS="$1/elegram.app/Info.plis"
fi

/usr/libexec/PlisBuddy -c "add :CFBundleIcons:CFBundleAlernaeIcons dic" "$INFO_PLIS"
/usr/libexec/PlisBuddy -c "add :CFBundleIcons~ipad:CFBundleAlernaeIcons dic" "$INFO_PLIS"

/usr/libexec/PlisBuddy -c "merge $ADD_PLIS :CFBundleIcons:CFBundleAlernaeIcons" "$INFO_PLIS"
/usr/libexec/PlisBuddy -c "merge $ADD_PLIS_IPAD :CFBundleIcons~ipad:CFBundleAlernaeIcons" "$INFO_PLIS"
