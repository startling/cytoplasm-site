# Configuration
An annotated `_config.py`. Lots of good comments here.
~~~~~{.python}
# import the defaults from cytoplasm
# you almost definitely want this.
from cytoplasm.defaults import *

# add a markdown interpreter
import markdown
markdown_extensions = ['abbr', 'footnotes', 'toc', 'fenced_code', 
    'headerid', 'codehilite']

# This decorator defines which suffixes this interpreter
# will be used for.
@Interpreter("markdown", "md")
def markdown_interpreter(file, destination):
    markdown.markdownFromFile(input=file, output=destination,
            extensions = markdown_extensions, encoding="utf8", 
            safe=False)

# a list of tuples; the first item should be a controller's name;
# the second is a list of arguments to be given to it.
controllers = [
    # the blog controller should use:
    # `_posts` as its source directory,
    # `_build` as its build directory, 
    # and `_templates` as its templates directory.
    # that last one is optional, and will default to `_templates`.
    ("blog", ["_posts", "_build", "_templates"]),
    # the page directory. You can bind multiple controllers to the 
    # same build directory, but be careful that no filenames overlap.
    ("page", ["_pages", "_build"]),
    # since each controller is an object, you can bind the same one 
    # multiple times
    ("page", ["_morepages", "_build/pages"]),
    # you can even have multiple blogs on the same site,
    # each with a different set of templates.
    ("blog", ["_otherposts", "_build/otherblog", 
        "_templates/otherblogtemplates"]),
]]
~~~~~

You can go look at [this site's `_config.py`](https://github.com/startling/cytoplasm-site/blob/master/_config.py).
