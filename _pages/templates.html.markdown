# An Introduction to Templates
The first thing you want to do is to copy the example templates from `_controllers/blog/examples` to a new directory in your site root called `_templates`. You need to edit `_config.py`, so the controllers knows the new location of the templates. Change the following line:
~~~~~{.python}
controllers = [
    ("blog", ["_posts", "_build", "_controllers/blog/templates"]),
]
~~~~~
<center> ⇣ </center>
~~~~~{.python}
controllers = [
    ("blog", ["_posts", "_build", "_templates"]),
]
~~~~~
## Editing Templates
The blog controller comes with three templates, by default: `post.mako`, `chronological.mako`, and `feeds/atom.xml.mako`.
###`post.mako`
`post.mako` is what gets used whenever the controller makes a page containing only one post. There's not much to see here, really, though you can go see [this site's](https://github.com/startling/cytoplasm-site/blob/master/_templates/post.mako) and compare it to the [example blog](/blog). It takes a single argument, a Post object. More on those later.
###`chronological.mako`
`chronological.mako` is used for whatever pages have more than one post on it: specifically, the index page of your blog, and the pages corresponding to months, years, and tags. It takes three arguments: a list of Post objects and the urls of the next and previous pages. Those last two can also be `None`.

Things can get a little cluttered if you put the entire contents of every post there. Instead, you can have a mako function that gets the first hundred words of every post.
~~~~{.mako}
<%def name="excerpt(post)">
## if there are fewer than 100 words, put the whole thing:
% if len(post.contents.split(" ")) < 100:
    ${post.contents}
% else:
### otherwise, put the first 100 words
    ${" ".join(post.contents.split(" ")[:100])}
## and a (read more) link
    <p><a href="/blog/${post.url}">(read more)</a></p>
%endif
</%def>
~~~~
This is a little problematic though. It could sometimes cut html or markdown tags in pieces, or end your post awkwardly. A better solution is to put a specific break in each post, like `<!-- fold -->`, and define your excerpt function like so:
~~~~{.mako}
<%def name="excerpt(post)">
## if post.contents doesn't have <!-- fold -->...
% if post.contents.find("<!-- fold -->") == -1:
## put the whole thing.
    ${post.contents}
% else:
## otherwise, put the first part of the string,
## split on the fold signifier.
    ${post.contents.split("<!-- fold -->")[0]}
## and a (read more) link
    <p><a href="/blog/${post.url}">(read more)</a></p>
%endif
</%def>
~~~~
Either way, replace `${post.contents}` with `${excerpt(post)}`
### `feeds/atom.xml.mako`
`feeds/atom.xml` is what the controller uses to generate the Atom feed, of course. It takes a single argument, a list of Post objects. It's different from `chronological.mako` because all the posts go on a single document or page, here. In fact, anything you put in the `feeds` directory will behave like that. You could make an RSS feed pretty easily (if you _really_ wanted) or some sort of JSON database. Maybe even OStatus or something.

Anyway, if you want your Atom template to work correctly, you need to change the following lines:
~~~~~{.python}
    # configure these...
    title = "Example Blog"
    url = "http://example.com/blog"
~~~~~
## A Sitewide Template
You probably want to have a single template echoed throughout the entire site. Mako has a really simple way of doing things called inheritance. First, make a file in `_templates` called `site.mako` like this:
~~~~{.mako}
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <title> my cytoplasm site </title>
</head>
<body>
    ${self.body()}
</body>
</html>
~~~~
See that one line that's not quite html? `${self.body()}`? That's where Mako will put the results of any template that inherits from `site.mako`. To make your templates inherit from it, add this to the beginning of `post.mako` and `chronological.mako`:
~~~~{.mako}
<%inherit file="/_templates/site.mako" />
~~~~
## Post Objects
The blog controller takes each post and makes it into a Post object. Post objects have a number of attributes that you could use in your templates.

* `self.contents` is a string of the contents of the file, doncha know.
* `self.path` is the name of file, in the blog controller's source directory, that the Post object was made from.
* `post.title` is whatever you define it as in the metadata.
* `self.slug` is the title with spaces replaced by dashes. It's useful for making things like urls.
* `self.url` is the url of the post, relative to the blog controller's build directory. It'll probably look like `2011/12/Unbounded-Creativity.html`.
* `post.author` and `post.email` are whatever you define them as in the metadata comment; know that these aren't required, but that your Atom feed will not be valid as per W3C standards. They default to `None`, and nothing terrible will happen if you don't define them.
* `post.date` is a [datetime][] object, read from the what you define as the date in the metadata.
* `post.year`, `post.month`, and `post.day` are syntactic sugar for their respective things, read from the above datetime objects.
* `post.tags` is a list of strings corresponding to the tags you give to the metadata. It defaults to an empty list.

You can optionally define more attributes in the metadata. Anything further than `title`, `date`, and `tags` are like blank canvases, delivered to your doorstep in a blister packs with some paints and a cheap paintbrush. You could define a `feeling` field for each post and have your template put little fox-shaped emoticons according to it. Or anything really.

[datetime]: http://docs.python.org/library/datetime.html

