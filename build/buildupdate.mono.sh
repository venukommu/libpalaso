#!/bin/bash
# server=build.palaso.org
# build_type=PalasoTrusty64lfmergeContinuous
# root_dir=..
# Auto-generated by https://github.com/chrisvire/BuildUpdate.
# Do not edit this file by hand!

cd "$(dirname "$0")"

# *** Functions ***
force=0
clean=0

while getopts fc opt; do
case $opt in
f) force=1 ;;
c) clean=1 ;;
esac
done

shift $((OPTIND - 1))

copy_auto() {
if [ "$clean" == "1" ]
then
echo cleaning $2
rm -f ""$2""
else
where_curl=$(type -P curl)
where_wget=$(type -P wget)
if [ "$where_curl" != "" ]
then
copy_curl $1 $2
elif [ "$where_wget" != "" ]
then
copy_wget $1 $2
else
echo "Missing curl or wget"
exit 1
fi
fi
}

copy_curl() {
echo "curl: $2 <= $1"
if [ -e "$2" ] && [ "$force" != "1" ]
then
curl -# -L -z $2 -o $2 $1
else
curl -# -L -o $2 $1
fi
}

copy_wget() {
echo "wget: $2 <= $1"
f1=$(basename $1)
f2=$(basename $2)
cd $(dirname $2)
wget -q -L -N $1
# wget has no true equivalent of curl's -o option.
# Different versions of wget handle (or not) % escaping differently.
# A URL query is the only reason why $f1 and $f2 should differ.
if [ "$f1" != "$f2" ]; then mv $f2\?* $f2; fi
cd -
}


# *** Results ***
# build: palaso-trusty64-lfmerge Continuous (PalasoTrusty64lfmergeContinuous)
# project: libpalaso
# URL: http://build.palaso.org/viewType.html?buildTypeId=PalasoTrusty64lfmergeContinuous
# VCS: https://github.com/sillsdev/libpalaso.git [lfmerge]
# dependencies:
# [0] build: L10NSharp Mono continuous (bt271)
#     project: L10NSharp
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt271
#     clean: false
#     revision: l10nsharp-1.2.tcbuildtag
#     paths: {"L10NSharp.dll"=>"lib/ReleaseMono"}
#     VCS: https://github.com/sillsdev/l10nsharp [master]
# [1] build: L10NSharp Mono continuous (bt271)
#     project: L10NSharp
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt271
#     clean: false
#     revision: l10nsharp-1.2.tcbuildtag
#     paths: {"L10NSharp.dll"=>"lib/DebugMono"}
#     VCS: https://github.com/sillsdev/l10nsharp [master]
# [2] build: TagLib-Sharp Continuous (bt411)
#     project: Libraries
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt411
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"taglib-sharp.dll"=>"lib/ReleaseMono"}
#     VCS: https://github.com/sillsdev/taglib-sharp.git [develop]
# [3] build: TagLib-Sharp Continuous (bt411)
#     project: Libraries
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt411
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"taglib-sharp.dll"=>"lib/DebugMono"}
#     VCS: https://github.com/sillsdev/taglib-sharp.git [develop]
# [4] build: Spart Continuous (bt439)
#     project: Spart
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt439
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"Spart.dll"=>"lib/common"}
#     VCS: https://github.com/sillsdev/spart.git [master]

# make sure output directories exist
mkdir -p ../lib/DebugMono
mkdir -p ../lib/ReleaseMono
mkdir -p ../lib/common

# download artifact dependencies
copy_auto http://build.palaso.org/guestAuth/repository/download/bt271/l10nsharp-1.2.tcbuildtag/L10NSharp.dll ../lib/ReleaseMono/L10NSharp.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt271/l10nsharp-1.2.tcbuildtag/L10NSharp.dll ../lib/DebugMono/L10NSharp.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt411/latest.lastSuccessful/taglib-sharp.dll ../lib/ReleaseMono/taglib-sharp.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt411/latest.lastSuccessful/taglib-sharp.dll ../lib/DebugMono/taglib-sharp.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt439/latest.lastSuccessful/Spart.dll ../lib/common/Spart.dll
# End of script
