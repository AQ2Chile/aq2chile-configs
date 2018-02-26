Configs Deploy
--

This is a small capistrano app that's meant to help with the deployment of config files for q2 servers.

## Requirements:

* Ruby
* Bundler

## Setup:

Assuming you already have ruby and bundler installed:

1. Install capistrano gem:

```bash
  bundle install #install capistrano
```

2. Setup your `config/deploy.rb` and `config/deploy/production.rb` accordingly.

**NOTE:** I'm not gonna teach you how to use capistrano here, so go to the official docs: http://capistranorb.com/

## Usage:

All the relevant files for the q2 server are inside the `files` folder.
Since I'm managing an action server, most of my files are inside the `action` folder, but this may as well be some other mod folder.

When the files get synced they follow the structure inside the `files` folder. Meaning that the `files` folder acts as a representation for your q2 root folder.

```ruby
    cap -T # Lists all available tasks

    # deploy files and link them
    cap production deploy

    # start the watcher for the gameserver launcher
    cap production server:start_watcher
```

All the tasks can be changed inside the `lib/capistrano/tasks` folder.

## Development

1. Fork it.
2. Do your thang.
3. Push a PR.
4. Ping me.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elfenars/q2_server_query.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
