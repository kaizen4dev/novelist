export def search-novel-title [title? --list-name(-l): string = "novels"] {
  stor open |
    query db $"SELECT * FROM ($list_name) WHERE title LIKE ?" -p [$"%($title)%"] |
    input list ("Search:") -f -d "title" |
    get title
}

export def confirm [message?] {
  let answer = [no yes] | input list ($message + "\nProceed?")
  $answer | str contains -i "y"
}
