# vim: ft=sh

alias ppjson='python -mjson.tool'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias serve='python -m SimpleHTTPServer'

alias grepall='find . -type f -print0 | xargs -0 grep -n --colour=auto'
grepfile() {
  local pattern="$1"
  shift
  find . -type f -a \( \( -path '*/target/*' -prune \) -o \( -name "$pattern" -print0 \) \) |\
    xargs -0 grep -n --colour=auto "$@"
}
alias grepclj="grepfile \*.clj"
alias grepjs="grepfile \*.js"
alias grepscala="grepfile \*.scala"

inplace() {
  local f=$1
  shift
  cat "$f" | "$@" | sponge "$f"
}

alias mvn_notests="mvn -DskipTests install"
alias mvn_jetty_prod="mvn -Drun.mode=production jetty:run"
alias mvn_jetty_dev="mvn jetty:run"

alias g=git

inw() {
    while "$@" ; inotifywait -qq -r -e modify .; sleep 0.2; do
      echo
    done
}

=() {
  echo "$@" | bc
}
