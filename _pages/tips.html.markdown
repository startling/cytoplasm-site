# Some Hints
Here are some things I didn't know where else to put.

## Code Highlighting
First make sure that you have "codehilite" in your `markdown_extensions` list in `_config.py`, if you don't have it yet. You'll need a css file, too. Richeland's [pygments-css](https://github.com/richleland/pygments-css) repository is super helpful here; just grab one of those and put it in your site root. Add a line toinclude it in your html header, too, something like:
~~~~{.html}
<link rel="stylesheet" href="/autumn.css" type="text/css">
~~~~

My favorite way to signify code in markdown is with the fenced_code extension, and you can specify languages really conveniently with it.

~~~~~{.markdown}
~~~~{.python}
print "hello, world!"
~~~~
~~~~~
