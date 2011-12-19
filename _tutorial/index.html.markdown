# Whirlwind Tour
I've spent a lot of time on this and now I'm winding down to where I should probably let people know how to use it. So here's this instead of full-fledged documentation, which will probably come later. Maybe.

[TOC]

## Installation
For now, you have to install Cytoplasm from the git repository; Cytoplasm isn't in PyPI. Get [Git](http://git-scm.com/) and [pip](http://pypi.python.org/pypi/pip) if you don't have them already; they're both really useful tools and I'm sure you'll find something to do with them.

Clone the repository from [Github](https://github.com/startling/cytoplasm), `cd` into the directory, and install with pip:

    git clone git://github.com/startling/cytoplasm.git
    cd cytoplasm
    pip install .

Pip will find the dependencies you need, install them, and then install Cytoplasm.

## Initialization
Make a new directory somewhere where you want to keep the source of your blog. Go into it and `cytoplasm init bare` -- this will git clone the [cytoplasm-bare](https://github.com/startling/cytoplasm-bare) repository into the working directory, assuming it's empty, and initialize its submodules

You'll see two things probably -- a directory called `_controller` and a file named `_config.py`.

## Underscored and Ordinary Files
Files and directories in your site directory fall into two categories: the ordinary ones and the underscored ones.  The ordinary ones will be interpreted, if you have the appropriate interpreters, and copied over to your build directory -- this means you can keep "static" things there, like CSS files or images. The underscored ones are reserved for use either by Cytoplasm or one of your controllers.

First and foremost of the underscored files is your `_config.py`. This is your configuration, where everything but the content and controller reside. You have your interpreters here, and you can also change variables like `build_dir`. We'll return to this file in a little bit.

## Run It!
Put a bunch of files ending in `.markdown` in a directory called `_posts`. These will be your blog posts. Each of these needs to have a header of this form:
~~~~~{.yaml}
<!-- metadata
title: An Example Post
date: 2011/12/17
tags: [category1, category2]
-->

~~~~~
(Make sure you have that blank line after this header; markdown will be upset if you don't.)

Execute `cytoplasm build`; Cytoplasm will run for a few seconds, if everything's working right. And then there should magically be a directory in your site directory named `_build` (don't worry, Git is already set to ignore it), where now exist some html files. 

(You'll probably get some errors the first time, namely that Python doesn't have libraries called yaml or markdown. Pip has you covered here: `pip install pyyaml markdown`. These aren't required by Cytoplasm because they aren't strictly necessary; they're used by the blog controller and the markdown interpreter in your `_config.py`, to be precise. There should probably be some kind of mechanism for this...)

If you want to test your new site, `cd` into `_build` and use `python -m SimpleHTTPServer 8080` if you're using Python 2.x or `python -m http.server 8080` if you use Python 3. While that's running, you can go to <http://localhost:8080/blog> and see your glorious content framed in half-assed HTML.

So what's happening here?

## Controllers
In your `_config.py`, there's a line that looks something like this:

~~~~~{.python}
controllers = [
    ("blog", ["_posts", "_build/blog", "_controllers/blog/templates"]),
]]
~~~~~
This tells Cytoplasm to use the controller "blog" (that is, the controller that lives in the directory `_controllers/blog`), and that it should find data for the blog under `_posts`; furthermore, it should put these files in `_build`, and it should get the templates (the half-assed HTML you saw earlier) from `_controllers/blog/templates`, the controller's example templates. Cool!

You can also do some neat things, like bind one controller multiple times:
~~~~~{.python}
controllers = [
    ("page", ["_pages", "_build"]),
    ("page", ["_documentation", "_build/documentation"]),
    ("page", ["_tutorial", "_build/tutorial"])
]
~~~~~
Here you see the [pages controller](https://github.com/startling/cytoplasm-page-controller) (which is the only other controller, so far) making pages from the `_pages`, `_documentation`, and `_tutorial` and putting them all in unique locations.

Controllers, by the way, are classes that inherit from a class in the Cytoplasm module, cytoplasm.controllers.Controller. You can install them just by putting them into your `_controllers` directory and adding a line like one of those above to your `_config.py`.  If the controller is in a git repository, you can `git submodule add url _controllers/wherever` and be able to pull further updates.

Let's dive in even further...

## Interpreters

Interpreters, in Cytoplasm, are things that convert a mark-up language to the files you want to serve. Like, I've written interprters for [Mako](http://makotemplates.org), [Markdown](http://daringfireball.net/projects/markdown/), and [SCSS](http://sass-lang.com), because those are the ones I use. In practice, interpreters are python functions, and are defined in either the Cytoplasm default configuration (cytoplasm.defaults) or you `_config.py`.

You can look in your `_config.py` for examples, but they should be functions that take two arguments: the file to be read and interpreted, and where the interpreted file should be written. You can also have the decorator `@SaveReturned` in front of one, in which case your interpreter only needs to take a single argument, the file to be read, and return the interpreted output. This is useful for modules like SCSS, which don't seem to have a built-in way to read and write to and from files in one line.

Here's an SCSS interpreter, used in the making of this very website. Just for kicks:
~~~~~{.python}

# an scss interpreter
from scss import parser as scss_parser

# interpret files that end in .scss
@Interpreter("scss")
@SaveReturned
def scss_interpreter(file):
    return scss_parser.load(file)
~~~~~
A little warning here: you need to have the python-scss module installed, and it doesn't appear to be compatible with Python 3, so there's that.

Anyway, when the blog controller is called, it interprets each of your Markdown files and then gives them as arguments to the controller's template files, in this case `post.mako` and `chronological.mako`.

## Templates

The first of these templates, `post.mako`, is given as an argument a Post object, as defined in the blog-controller's `__init__.py`. In your template, then, you can use things like `post.content` and `post.date` adn `post.year`. `post.mako` is used for the pages for single posts, like where the permalinks go.

The other template, `chronological.py`, is used for any page that displays more than one post. It's given two things: a list of post objects, to be displayed on that page, and the `next` and `previous` variables, which are either `None` (in the case of the last and first pages, respectively, ones that don't have a next or previous) or the (relative) url to the next or previous page.

The pages controller, on the other hand, has a single, very very basic template, to which everything is applied. This makes it useful for writing pages (like this one) entirely in Markdown, but still having them have a consistent html base.

You should probably copy the templates from the controller's example directory into a directory called `_templates`. You can edit them there. You should also probably have them inherit from a base, named something like `site.mako`. If you don't know what I mean, you should check out the [Mako syntax](http://www.makotemplates.org/docs/syntax.html#inherit) and [this site's `_templates` directory](https://github.com/startling/cytoplasm-site/tree/master/_templates).

## A To-Do List
So, we can generalize this experience and make a sort of to-do list for making a Cytoplasm site:

* Install Cytoplasm.
* Install Markdown, pyyaml, and whatever other things you might want.
* `cytoplam init bare`, or, alternatively, write a `_config.py` from scratch and install controllers yourself.
* Edit your `_config.py` to bind the controllers wherever it is you want them.
* Copy over the example templates from your controllers to `_templates` and edit them to work well together. Make a `site.mako` and have all of your other templates inherit from it.
* Add other things like images, stylesheets, and posts.
* `cytoplasm build`!
