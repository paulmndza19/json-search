# README

This is a simple ruby command line tool that searches a given json array for a specific key and query string and also returns duplicate emails.

## Installation

* Ruby version:
```2.6.8```

* Setup instructions
1. Install ruby `2.6.8` depending on your choice of version manager (rvm, rbenv, asdf).
2. Clone the repository and go to its directory.
3. Run
```
ruby search.rb -h
```
to view the arguments that this command line tool accepts.

## Accepted options
This command line tools accepts 3 options:
1.  `-q` or `--query` this is a required option. It accepts a string that is going to be used to search for a specific value in the json.
    - Sample Usage:
    ```
    ruby search.rb --query Jane
    ```
2.  `-k` or `--key` this option accepts a string that represents the json key in which we are going to compare the query string that we provided.
    - Sample Usage:
    ```
    ruby search.rb --key email
    ```
3.  `-j` or `--json` this option accepts a string that provides the JSON file in which we are going to do the search.
    - Sample Usage:
    ```
    ruby search.rb --json ./clients.json
    ```

## Example
Command:
```
ruby search.rb --q Jane -k email
```

Result:
```
Key: email
Query String: jane
Search Results:
         1.
                 ID: 2
                 Full Name: Jane Smith
                 Email: jane.smith@yahoo.com
         2.
                 ID: 15
                 Full Name: Another Jane Smith
                 Email: jane.smith@yahoo.com
1 Duplicate(s) Found:
  1. Clients with ids 2, and 15 are using the same email (jane.smith@yahoo.com)
```
