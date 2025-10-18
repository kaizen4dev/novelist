export def load-database [] {
  ensure-local-directory
  stor reset

  if ( database-exists ) {
    let database = mktemp -t --suffix ".db"
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
    let temp = mktemp -t --suffix ".db"
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

