# Novelist
A simple nushell script for your title lists.

## Motivation
As it came to be, for my entire reading journey, I've been using simple txt file for tracking purposes.
I don't need anything fancy, just one line per book in format "title, progress, category" is enough for me.
Once number of lines in said file hit couple of hundred, it became a mess(obviously). And so this project was born.

## How it works
Basically, novelist acts as a wrapper around sqlite database.
With help of novelist (sub)commands you can create tables(lists) and add/edit/remove rows(titles) within those tables.
Each list/table has 3 columns: title, progress and category.

## Commands preview
General:
- novelist - show all subcommands
- novelist version - show novelist version

Lists:
- novelist lists - show all lists
- novelist create - create new list
- novelist burn - delete list and all titles associated with it

Titles:
- novelist show - show titles in the list
- novelist add - add title to the list
- novelist edit - edit title in the list
- novelist remove - remove title from the list
- novelist categories - show categories of a list

For further information on how to use them please proceed with installation and use --help flag on every command.
I've made an effort to make help messages (somewhat) helpful and don't want to repeat myself here, if you still
have some questions you're free to open an issue and ask me.

## Installation
Using nix(with flakes):
- run ```nix profile add github:kaizen4dev/novelist```

Other:
- make sure nushell is istalled
- use it as any other script

## To Do
This section is a list of features or changes that novelist is lacking and I might be willing to implement them in the future.

- ability to change default list
- ability to rename lists
