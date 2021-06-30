#!/bin/sh

upstream="https://api.github.com/repos/ColorlibHQ/AdminLTE/releases/latest"
assets_dir=".github/action-check-upstream/assets"
current_version=$(cat "${assets_dir}/latest-upstream-release.txt")
latest_version=$(curl -s $upstream | jq -r .tag_name)

if [ "$current_version" == "$latest_version" ]; then
  echo -e "> Nothing to update, version ${current_version} are sync."
  exit;
fi

download_url=$(curl -s $upstream | jq -r .tarball_url)

tmpdir="/tmp/adminlte"
mkdir -p $tmpdir
wget -c $download_url -O "${tmpdir}/adminlte.tar.gz"
tar -xf "${tmpdir}/adminlte.tar.gz" -C $tmpdir
output_dir=$(ls -d $tmpdir/*/ | head -n 1)

rsync --perms --chmod=777 \
  -a -v --files-from=${assets_dir}/files-to-keep.txt $output_dir .

echo $latest_version > "${assets_dir}/latest-upstream-release.txt"

echo -e "> Done, all clear."