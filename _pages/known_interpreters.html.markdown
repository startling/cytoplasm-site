# Interpreters:
These are all the interpreters known to man. Let me know if you have another one. Just add them to your `_config.py` if you want.

[TOC]

## Mako
This is probably in your `cytoplasm.defaults`, but it can be helpful to look at:
~~~~~{.python}
import mako.lookup, mako.template
# Mako should look for templates to include in the current directory.
# This should let you include things like "_templates/site.mako"
mako_lookup = mako.lookup.TemplateLookup(directories=['.'])

@Interpreter("mako")
# Mako doesn't come with an easy built-in way to save the output to 
# a certain file; this decorator does that.
@SaveReturned
def mako_interpreter(file, **kwargs):
    # pass kwargs to the mako template
    page = mako.template.Template(file.read(), lookup=mako_lookup, 
        input_encoding='utf-8')
    # this is dumb but it's the only way I can make it work.
    if sys.version_info.major == 2:
        # if it's python 2, use .encode('utf-8', 'replace')
        return page.render_unicode(**kwargs).encode('utf-8', 
            'replace')
    elif sys.version_info.major == 3:
        # otherwise, just render it...
        return page.render_unicode(**kwargs)
~~~~~
## scss
~~~~~{.python}
from scss import parser as scss_parser

@Interpreter("scss")
@SaveReturned
def scss_interpreter(file):
    return scss_parser.load(file)

~~~~~
I should probably note here that SCSS doesn't install on Python 3. So uh, don't use it if you expect to use Python 3.

## Haml.
A Haml interpreter using [PyHaml](https://github.com/mikeboers/PyHAML). You know, you can use this for templates, instead of Mako. Something like `post.haml`. Or whatever.

PyHaml doesn't work with Python 3 either, though.
~~~~~{.python}
# A PyHaml Interpreter.
# PyHaml is a preprocessor for mako, so a lot of this
# is the same as it was there.
import haml

@Interpreter("haml")
@SaveReturned
def pyhaml_interpreter(file, **kwargs):
    page = mako.template.Template(file.read(), lookup=mako_lookup,
        input_encoding='utf-8', preprocessor=haml.preprocessor)
    # this is dumb but it's the only way I can make it work.
    if sys.version_info.major == 2:
        # if it's python 2, use .encode('utf-8', 'replace')
        return page.render_unicode(**kwargs).encode(
            'utf-8', 'replace')
    elif sys.version_info.major == 3:
        # otherwise, just render it...
        return page.render_unicode(**kwargs)
~~~~~
## Markdown
This probably came with your site... still:
~~~~~{.python}
import markdown
markdown_extensions = ['abbr', 'footnotes', 'toc', 'fenced_code', 
    'headerid', 'codehilite']

@Interpreter("markdown", "md")
def markdown_interpreter(file, destination):
    markdown.markdownFromFile(input=file, output=destination,
        extensions = markdown_extensions, encoding="utf8", 
        safe=False)

~~~~~
Still here? Are you looking for something in particular? Well, interpreters are [really easy to write](/controllers_and_interpreters.html#interpreters)...
