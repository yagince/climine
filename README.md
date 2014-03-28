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
$ climine init -k xxxx -u http://xxxx.xxx.xx/ -e `which emacs`
```

```climine.yml
url: http://xxxx.xxx.xx/
apikey: xxxx
editor: /path/to/emacs
```

Path of the configuration file can also be specified in the environment variable.

```
export CLIMINE_CONF=path/to/climine.yml
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

#### get issue list

```
Usage:
  climine list [TICKET_NO]

Options:
  -s, [--sort=SORT_KEYS]                # default asc. ex) 'id,category:desc,updated_on'
  -l, [--limit=LIMIT]                   # limit of search result (default: 25)
  -o, [--offset=OFFSET]                 # page of seach result(0 origin) (default: 0)
  -p, [--project-id=PROJECT_ID]         # id of RedmineProject ( Please search by `climine project` ) (default: all project)
      [--status-id=STATUS_ID]           # id of issue status. ( Please search by `climine status` ) (default: all status)
                                        # Default: *
  -u, [--assigned-to-id=USER_ID]        # ID of the user being assigned ( Please search by `climine user` )
  -c, [--created-on=CREATED_DATE]       # ex) >=2013-10-01, >2013-10-01, <2013-10-01, 2013-10-01
  -r, [--updated-on=LAST_UPDATED_DATE]  # ex) >=2013-10-01, >2013-10-01, <2013-10-01, 2013-10-01
  -w, [--before-week=WEEKS]             # search tickets that has been updated in the last X weeks
  -t, [--template=TEMPLATE_PATH]        # rendering by given template

get Redmine Issues. see) http://www.redmine.org/projects/redmine/wiki/Rest_Issues#Listing-issues
```

#### get issue

```
Usage:
  climine issue get [TICKET_NO]

Options:
  -t, [--template=TEMPLATE_PATH]  # rendering by given template

get Redmine Issues. see) http://www.redmine.org/projects/redmine/wiki/Rest_Issues#Listing-issues
```

You can be rendered using the your own ERB template file.

```
$ climine issue (get|list) -t [template_path]
```

#### create issue

```
Usage:
  climine issue new

Options:
  -p, [--project=PROJECT_ID]  # project_id (search by `project` command)
  -t, [--tracker=TRACKER_ID]  # tracker_id (search by `tracker` command)
  -s, [--status=STATUS_ID]    # status_id (search by `status` command)
  -u, [--user=USER_ID]        # user_id (search by `user` command)
      [--subject=SUBJECT]     # ticket title
      [--desc=DESCRIPTION]    # ticket description

create Issue
```

#### update issue

```
Usage:
  climine issue update [TICKET_NO]

Options:
  -t, [--tracker-id=TRACKER_ID]  # tracker_id (search by `tracker` command)
  -s, [--status-id=STATUS_ID]    # status_id (search by `status` command)
  -u, [--user-id=USER_ID]        # user_id (search by `user` command)

update Redmine Issues. see) http://www.redmine.org/projects/redmine/wiki/Rest_Issues#Updating-an-issue
```

#### update issue status


```
Usage:
  climine issue start [TICKET_NO]

Options:
  -t, [--tracker-id=TRACKER_ID]  # tracker_id (search by `tracker` command)
  -u, [--user-id=USER_ID]        # user_id (search by `user` command)

update status of issue to ID:2.
```

```
Usage:
  climine issue close [TICKET_NO]

update status of issue to ID:5.
```

```
Usage:
  climine issue finish [TICKET_NO]

alias for close
```

```
Usage:
  climine issue reject [TICKET_NO]

update status of issue to ID:6.
```

### Users

```
Usage:
  climine user list

Options:
  -n, [--name=NAME]  # filter users on their login, firstname, lastname and mail
```

```
Usage:
  climine user get [ID]

get Redmine User
```

### Projects

```
Usage:
  climine project list

get Redmine Projects.
```

```
Usage:
  climine project get [PROJECT_ID]

get Redmine Project.
```

### Ticket Statauses

```
Usage:
  climine status list

Options:
  -t, [--table]  # default asc. ex) 'id,category:desc,updated_on'

get Redmine IssueStatuses.
```

### Ticket Trackers

```
Usage:
  climine tracker list

get Redmine Trackers.
```

### Project Members

```
Usage:
  climine member list -p, --project-id=PROJECT_ID

Options:
  -p, --project-id=PROJECT_ID  # see) http://www.redmine.org/projects/redmine/wiki/Rest_Memberships#GET

get Project Members
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
