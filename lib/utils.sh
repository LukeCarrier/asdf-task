# get the OS family name
get_os() {
  if [[ "$(uname)" == MSYS_NT* ]]; then
    echo windows
  else
    uname | tr '[:upper:]' '[:lower:]'
  fi
}

# get the cpu architecture
get_arch() {
  local -r arch=$(uname -m)

  case $arch in
    x86_64)
      echo amd64
      ;;
    *86)
      echo 386
      ;;
    aarch64)
      echo arm64
      ;;
    *)
      # e.g. "arm64"
      echo $arch
      ;;
  esac
}

get_archive_fmt() {
  local -r os=$1

  case $os in
    windows)
      echo zip
      ;;
    *)
      echo tar.gz
      ;;
  esac
}

extract_archive() {
  local -r fmt=$1
  local -r download_pkg=$2
  local -r dest=$3
  local -r tool=$4

  case $fmt in
    tar.gz)
      tar xf "$download_pkg" -C "$dest" "$tool" 2>/dev/null
      ;;
    zip)
      unzip -u "$download_pkg" "$tool" -d "$dest" 2>/dev/null
      ;;
  esac
}

get_bin_ext() {
  local -r os=$1

  case $os in
    windows)
      echo .exe
      ;;
    *)
      echo
      ;;
  esac
}