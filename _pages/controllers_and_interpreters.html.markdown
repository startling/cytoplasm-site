# Controllers and Interpreters

In your Cytoplasm site, two classes of things do most of the work: controllers and interpreters.

##Controllers

Controllers live in modules in `_controllers`. They're bound to certain directories in `_config.py`, and do things with the files in those directories. If this seems a little vague, it's meant to be; controllers can do anything you can do in Python.

Controllers should be defined as classes inheriting from `cytoplasm.controllers.Controller`. The stuff that it does should be in the class method `__call__`.

Make sure you have a dictionary called `info`, in your module, with at least one key, `"class"`, that points to the controller class. That's how Cytoplasm knows which class to instantiate to make a controller object.

### The Page Controller

The page controller is probably the simplest usable controller. It takes a bunch of files, interprets them, and then puts them in a template called `page.mako` (or `.haml`, or whatever). To do this, it makes a Page object out of each file. That might turn out to be a common pattern in controllers; the blog controller uses it too.

Why don't you go look at [the source](https://github.com/startling/cytoplasm-page-controller/blob/master/__init__.py)? It's pretty simple.

If you use a site-wide template, you might want page.mako to look something like this:
~~~~{.mako}
<inherit file="/_templates/site.mako"/>
${page.contents}
~~~~

Want to install it?

~~~~~{.bash}
git submodule add\
    git://github.com/startling/cytoplasm-page-controller.git\
    _controllers/page
~~~~~
### The Blog Controller

The blog controller takes a series of posts in a directory, interprets them, and then makes chronological pages, post pages, and feeds with them by giving the posts to certain templates. There's a separate page detailing these templates, by the way.

There's not a whole lot to say here; it's kind of straightforward. You can look at the example blog or the source of the blog controller.

## Interpreters

Interpreters live in `_config.py` and are used in translating any sort of mark-up language, things like Markdown, Mako, and scss. Controllers use interpreters for certain actions (like interpreting a Markdown post to html, before putting them in templates); in addition, everything in the root of your site directory that doesn't begin with `.` or `_` will be interpreted.

Interpreters are just functions. Use the decorator `@Interpreter(suffix)` to add them to your dictionary of interpreters, to interpret files ending in suffix. You can give it as many suffixes as you want; the Markdown interpreter's one, for example, is `@Interpreter("markdown", "md")`.

Some mark-up languages don't come with quick ways to save to a file; in those cases, return the interpreted text and use the decorator `@SaveReturned`.

This might all seem rather abstract, but you can see a bunch in the [list of interpreters](/known_interpreters.html).
