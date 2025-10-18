export def load-database [] {
  ensure-local-directory
  stor reset

  if ( database-exists ) {
    mkdir /tmp/novelist
    let database = mktemp $"XXXXXX-novelist.db" -p /tmp/novelist
    cp ~/.local/share/novelist/novels.db $database
    stor import -f $database
  } else {
    stor create -t novels -c {title: str, chapters: float, category: str}
  }

  ignore
}

export def save-database [] {
  ensure-local-directory
  if (stor open | is-not-empty) {
    mkdir /tmp/novelist
    let temp = mktemp $"XXXXXX-novelist.db" -p /tmp/novelist
    stor export -f $temp
    mv $temp ~/.local/share/novelist/novels.db
    stor reset
  }

  ignore
}

def database-exists [] {
  ls ~/.local/share/novelist | to text | $in has novels.db
}

def ensure-local-directory [] {
  if not ( "~/.local/share/novelist" | path exists) {
    mkdir ~/.local/share/novelist
  }
}

