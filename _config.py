# import the defaults from cytoplasm
from cytoplasm.defaults import *

# add a markdown interpreter
import markdown
markdown_extensions = ['abbr', 'footnotes', 'toc', 'fenced_code', 'headerid']
def markdown_interpreter(file, destination):
    markdown.markdownFromFile(input=file, output=destination,
            extensions = markdown_extensions, encoding="utf8", safe=False)

interpreters["markdown"] = markdown_interpreter

# and a scss interpreter
from scss import parser as scss_parser
@SaveReturned
def scss_interpreter(file):
    return scss_parser.load(file)

interpreters["scss"] = scss_interpreter


# the first thing in the tuple is the name of the module where the controller lives;
# the second thing is a list of arguments to be used when instantiating a controller object.
# In the case of the blog controller, at least, it's the source directory for it to find posts in
# and the destination directory of its output.
controllers = [
    ("blog", ["_posts", "_build/blog"]),
    ("page", ["_pages", "_build"])
]
