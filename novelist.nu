#!/usr/bin/env nu

use modules/database.nu *
use modules/general.nu *

# Your own novel list in simple script!
#
# Add, view, edit and remove your novels with these commands:
#
#   novelist                  - list all novels
#   novelist show             - list all novels
#   novelist show [category]  - list novels only in specific category
#   novelist add              - get prompt to add a novel to the list
#   novelist edit             - get prompt to search and edit an entry
#   novelist remove           - get prompt to search and remove an entry
def main [mode?: string = "show" category?: string = "all"] {
  ensure-local-directory
  load-database

  match $mode {
    show => { show-novels $category },
    add => { add-novel },
    categories => { show-categories },
    edit => { edit-novel },
    remove => { remove-novel },
    _ => { print "Unknown mode" }
  }

  save-database
}

def show-novels [category: string] {
  let list = if $category == "all" {
    stor open | query db "SELECT * FROM novels"
  } else {
    stor open | query db "SELECT title, chapters FROM novels WHERE category LIKE ?" -p [$category]
  }

  print $list
}

def add-novel [] {
  let title = (input "Plese enter novel title: ")
  let chapters = (input "Chapters: ")
  let category = (input "Category: ")
  stor insert -t novels -d {title: $title, chapters: $chapters, category: $category}
}

def show-categories [] {
  stor open | query db "SELECT DISTINCT category FROM novels" | print $in
}


def edit-novel [] {
  let title = search-novel-title

  let new_title = input "New title(leave empty to skip): "
  let new_chapters = input "Update chapters: "
  let new_category = input "Update category: "

  if ($new_chapters | is-not-empty) {
    stor update -t novels -u {chapters: $new_chapters} -w $"title LIKE '($title)'"
  }

  if ($new_category | is-not-empty) {
    stor update -t novels -u {category: $new_category} -w $"title LIKE '($title)'"
  }

  if ($new_title | is-not-empty) {
    stor update -t novels -u {title: $new_title} -w $"title LIKE '($title)'"
  }

  print "Updated record:"
  stor open |
    query db "SELECT * FROM novels WHERE title LIKE ? OR title LIKE ?" -p [$title $new_title] |
    print $in
}

def remove-novel [] {
  let title = search-novel-title

  stor delete -t novels -w $"title LIKE '($title)'"
  print $"Deleted \"($title)\""
}
