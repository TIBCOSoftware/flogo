# Hugrid

Hugrid (Hugo+grid) is a simple grid theme for Hugo. It's a kind of boilerplate to perform anyone or anything quickly. Portfolio, collection, bookmarks, contacts and so on.

# Origin

Hugrid is based on Codrops' [Thumbnail Grid with Expanding Preview](http://tympanus.net/codrops/?p=14530). 

## Demo

- [Demo on themes.gohugo.io](http://themes.gohugo.io/theme/hugrid/)
- [Original demo from Codrops](http://tympanus.net/Tutorials/ThumbnailGridExpandingPreview/)

## Features

- Responsive design
- Google Analytics

## Screenshot

![Hugrid screenshot](https://raw.githubusercontent.com/aerohub/hugrid/master/images/screenshot.png)


## Contents

- [Installation](#installation)
- [Getting started](#getting-started)
    - [The config file](#the-config-file)
	- [Data file](#data-file)
    - [Nearly finished](#nearly-finished)
- [Contributing](#contributing)
- [License](#license)
- [Annotations](#annotations)


## Installation

Inside the folder of your new Hugo site run:

    $ mkdir themes
    $ cd themes
    $ git clone https://github.com/aerohub/hugrid

For more information read the official [setup guide](//gohugo.io/overview/installing/) of Hugo.


## Getting started

After installing the theme successfully it requires a just a few more steps to get your site running.


### The config file

Take a look inside the [`exampleSite`](//github.com/aerohub/hugrid/tree/master/exampleSite) folder of this theme. You'll find a file called [`config.toml`](//github.com/aerohub/hugrid/blob/master/exampleSite/config.toml). To use it, copy the [`config.toml`](//github.com/aerohub/hugrid/blob/master/exampleSite/config.toml) in the root folder of your Hugo site. Feel free to change the strings in this theme.

### Data file

Take a look inside the [`exampleSite/data`](//github.com/aerohub/hugrid/tree/master/exampleSite/data) folder of this theme. You'll find a file called [`items.toml`](//github.com/aerohub/hugrid/blob/master/exampleSite/data/items.toml). To use it, copy the [`exampleSite/data`](//github.com/aerohub/hugrid/tree/master/exampleSite/data) folder in the root folder of your Hugo site. Change the strings in the `items.toml` with your data.

### Nearly finished

In order to see your site in action, run Hugo's built-in local server. 

    $ hugo server -w

Now enter `localhost:1313` in the address bar of your browser.


## Contributing

Did you found a bug or got an idea for a new feature? Feel free to use the [issue tracker](//github.com/aerohub/hugrid/issues) to let me know. Or make directly a [pull request](//github.com/aerohub/hugrid/pulls).


## License

This work is licensed under the MIT License. For more information read the [License](//github.com/aerohub/hugrid/blob/master/LICENSE.md).
And there are [Original Codrops Licensing and Terms Of Use](http://tympanus.net/codrops/licensing/).


## Annotations

Thanks 

- to [spf13](//github.com/spf13) for creating Hugo and the awesome community around the project
- to [digitalcraftsman](//github.com/digitalcraftsman) for creating Hugo themes and writing nice READMEs
- to Codrops for original [Thumbnail Grid with Expanding Preview](http://tympanus.net/codrops/?p=14530). 