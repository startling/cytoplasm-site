# Some Hints
Here are some things I didn't know where else to put.

## Code Highlighting
First make sure that you have "codehilite" in your `markdown_extensions` list in `_config.py`, if you don't have it yet. Previously, python-markdown would raise some errors if you had both "codehilite" and "fenced_code" enabled, and so you might not have it.

You'll need a css file, too. Richeland's [pygments-css](https://github.com/richleland/pygments-css) repository is super helpful here; just grab one of those and put it in your site root. 

You'll need to add a line to your html header, too, something like:
~~~~{.html}
<link rel="stylesheet" href="/autumn.css" type="text/css">
~~~~

My favorite way to signify code in markdown is with the fenced_code extension, and you can specify languages really conveniently with it.

~~~~~{.markdown}
~~~~{.python}
print "hello, world!"
~~~~
~~~~~
## Interpreters:
Here's all the interpreters I've written so far; let me know if you have another one. Just add them to your `_config.py` if you want.

### Mako
~~~~~{.python}
import mako.lookup, mako.template
# Mako should look for templates to include in the current directory.
# This should let you include things like "_templates/site.mako"
mako_lookup = mako.lookup.TemplateLookup(directories=['.'])

@Interpreter("mako")
# Mako doesn't come with an easy built-in way to save the output to a certain file;
# this decorator does that.
@SaveReturned
def mako_interpreter(file, **kwargs):
    # pass kwargs to the mako template
    page = mako.template.Template(filename=file, lookup=mako_lookup, input_encoding='utf-8')
    # this is dumb but it's the only way I can make it work.
    if sys.version_info.major == 2:
        # if it's python 2, use .encode('utf-8', 'replace')
        return page.render_unicode(**kwargs).encode('utf-8', 'replace')
    elif sys.version_info.major == 3:
        # otherwise, just render it...
        return page.render_unicode(**kwargs)
~~~~~
### scss
~~~~~{.python}
from scss import parser as scss_parser

@Interpreter("scss")
@SaveReturned
def scss_interpreter(file):
    return scss_parser.load(file)

~~~~~
### Markdown
This probably came with your site... still:
~~~~~{.python}
import markdown
markdown_extensions = ['abbr', 'footnotes', 'toc', 'fenced_code', 'headerid', 'codehilite']

@Interpreter("markdown", "md")
def markdown_interpreter(file, destination):
    markdown.markdownFromFile(input=file, output=destination,
            extensions = markdown_extensions, encoding="utf8", safe=False)

~~~~~


    
