# Climine (クリミネ)

CLI for Redmine

## Installation

Add this line to your application's Gemfile:

    gem 'climine'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install climine

## Usage

### Initialize

create `config.yml`

```
$ climine init -k xxxx -u http://xxxx.xxx.xx/
```

```config.yml
url: http://xxxx.xxx.xx/
apikey: xxxx
```

### Help

- show all help

```
$ climine help
Commands:
  climine help [COMMAND]                                       # Describe available commands or one specific command
  climine init  -k, --key=API-Access-Key -u, --url=RedmineURL  # initialize config.yml
  climine issue [TICKET_NO]                                    # get Redmine Issues. see) http://www.redmine.org/projects/redmine/wiki/Rest_Issues#Listing-issues
  climine project [PROJECT_ID]                                 # get Redmine Projects.
  climine user [ID]                                            # get Redmine Users
```

- show command help

```
$ climine help [COMMAND]
```

### Issues

```
Usage:
  climine issue [TICKET_NO]

Options:
  -s, [--sort=SORT_KEYS]                # default asc. ex) 'id,category:desc,updated_on'
  -l, [--limit=LIMIT]                   # limit of search result (default: 25)
  -o, [--offset=OFFSET]                 # page of seach result(0 origin) (default: 0)
  -p, [--project-id=PROJECT_ID]         # id of RedmineProject ( Please search by `climine project` ) (default: all project)
  -u, [--assigned-to-id=USER_ID]        # ID of the user being assigned ( Please search by `climine user` )
  -c, [--created-on=CREATED_DATE]       # ex) >=2013-10-01, >2013-10-01, <2013-10-01, 2013-10-01
  -r, [--updated-on=LAST_UPDATED_DATE]  # ex) >=2013-10-01, >2013-10-01, <2013-10-01, 2013-10-01
  -w, [--before-week=WEEKS]             # search tickets that has been updated in the last X weeks

get Redmine Issues. see) http://www.redmine.org/projects/redmine/wiki/Rest_Issues#Listing-issues
```

### Users

```
Usage:
  climine user [ID]

Options:
  -n, [--name=NAME]  # filter users on their login, firstname, lastname and mail
```

### Projects

```
Usage:
  climine project [PROJECT_ID]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
