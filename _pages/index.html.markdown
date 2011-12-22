# Features & Design:
Cytoplasm is a simple-ish static site compiler. It's meant to be used mostly as a blogging engine, though it [can be used for more than that](#cytoplasm-is-easily-extensible). Here are some things you might like about it:

## Cytoplasm is Portable
A Cytoplasm site is defined completely by its configuration and its contents. The output is just a set of plain html files, and so can be hosted just about anywhere. `cytoplasm`, the script, will run anywhere where Python is installed -- it's tested and works in Pythons 2.7.2 and 3.2.

## Cytoplasm is Pretty Simple
[Install Cytoplasm](/tutorial/#installation) and run `cytoplasm init bare` to get the basis of your future blog. Add some posts in `_posts`, edit your templates in `_templates`, and `cytoplasm build` to generate some html files.

## `cytoplasm serve`
Cytoplasm comes with a built-in server for local testing. `cytoplasm serve` will start it on port number 8080; `cytoplasm serve -r` will serve on port 8080 and automatically re-build your site whenever you make a change to a source file. You can specify a port with something like `cytoplasm serve 8000`.

## Cytoplasm is Easily Extensible
Cytoplasm interpreters are python functions in your configuration file. The markdown one, for example, is just:
~~~~{.python}
import markdown
markdown_extensions = ['abbr', 'footnotes', 'toc', 'fenced_code', 'headerid']

@Interpreter("markdown", "md")
def markdown_interpreter(file, destination):
    markdown.markdownFromFile(input=file, output=destination,
        extensions = markdown_extensions, encoding="utf8", safe=False)
~~~~
Similarly, Cytoplasm controllers are classes that inherit from a base class in the cytoplasm module.

## Cytoplasm Integrates Well With Git
This source of this site (compiled by Cytoplasm, of course) can be cloned from `https://startling@github.com/startling/cytoplasm-site.git`. Everything works within a git repository; in fact, you'll be missing a lot if you don't use one. Controllers can be installed as git submodules. Pull and push wherever you want!

## More Information
* A [sample blog](/blog).
* A weird [combination](/tutorial) of install instructions, documentation, and tutorial.
* Some [tips](/tutorial/tips.html) that I didn't know where else to put.
* [Github](https://github.com/startling/cytoplasm) and [Gitorious](https://gitorious.org/cytoplasm/cytoplasm) repositories for Cytoplasm. 
* [Github repository](https://github.com/startling/cytoplasm-site) for this site.

## Addenda
So, what do you think so far? Do you like Cytoplasm? Is there anything you don't understand here, or would like to hear more about? Feel free to get in touch with me -- I'm tim/startling and my email address for now is <tdixon51793@gmail.com>; you can see what I'm up to at [my website](http://somethingsido.com). I'd like to hear if you use Cytoplasm for anything, or have any feedback.

Cytoplasm was mostly inspired by [Blogofile](http://blogofile.com/), though the codebase is completely from scratch.

## License

Cytoplasm is free software and is released under the [MIT (Expat) License](https://github.com/startling/cytoplasm/blob/master/LICENSE).
