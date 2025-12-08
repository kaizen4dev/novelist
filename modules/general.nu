export def search-novel-title [title? --list-name(-l): string = "novels"] {
  let search_title = if ($title | is-not-empty) {$title} else { input "Search for a title: " }
  let search_list = stor open |
    query db $"SELECT * FROM ($list_name) WHERE title LIKE ?" -p [$"%($search_title)%"]

  let novel_index = if ($search_list | is-empty) {
    print "Couldn't find any title, try again"
    return (search-novel-title)
  } else {
    print "Titles found:"
    print $search_list
    input "Select title by index(0 by default): " |
      if ($in | is-empty) { 0 } else { $in | into int }
  }

  let novel_title = $search_list | enumerate | where index == $novel_index | get item.title

  return ($novel_title | to text | str trim)
}

export def confirm [message?] {
  let answer = [no yes] | input list ($message + "\nProceed?")
  $answer | str contains -i "y"
}
