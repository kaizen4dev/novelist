export def search-novel-title [title?] {
  let search_title = if ($title | is-not-empty) {$title} else { input "Search for a title: " }
  let search_list = stor open |
    query db $"SELECT * FROM novels WHERE title LIKE ?" -p [$"%($search_title)%"]

  let novel_index = if ($search_list | is-empty) {
    print "Couldn't find any novel, try again"
    search-novel-title
  } else {
    print "Novels found:"
    print $search_list
    input "Select novel by index(0 by default): " |
      if ($in | is-empty) { 0 } else { $in | into int }
  }

  let novel_title = $search_list | enumerate | where index == $novel_index | get item.title

  return ($novel_title | to text | str trim)
}
