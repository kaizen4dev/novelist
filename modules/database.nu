export def load-database [] {
  ensure-directories
  stor reset

  if ( database-exists ) {
    let database = mktemp $"XXXXXX-novelist.db" -p /tmp/novelist
    cp ~/.local/share/novelist/novels.db $database
    stor import -f $database
  } else {
    stor create -t novels -c {title: str, chapters: int, category: str}
  }

  ignore
}

export def save-database [] {
  ensure-directories
  if (stor open | is-not-empty) {
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

def ensure-directories [] {
  # local directory
  if not ( "~/.local/share/novelist" | path exists) {
    mkdir ~/.local/share/novelist
  }

  # temporary directory
  if not ( "/tmp/novelist" | path exists) {
    mkdir /tmp/novelist
  }
}

