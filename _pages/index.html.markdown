# Welcome to Cytoplasm!
This is Cytoplasm, a simple static blogging-and-other-things generator. Cytoplasm takes some posts and templates and outputs a bunch of HTML files, which you can host basically anywhere. Since everything is plain text, using version control and making back-ups are both super easy.

## Getting Started 
You'll need [Git][] and [pip][] to get started. (Side note: this example will only work in Python 2.x, sorry; python-scss doesn't support 3 yet. If you're set on using Python 3, though, read on: Cytoplasm itself is fully compatible with Python 3.x.)

[Git]: http://git-scm.com/
[pip]: http://www.pip-installer.org/en/latest/index.html
~~~~{.bash}
# install cytoplasm -- pip will install cytoplasm's dependencies.
pip install cytoplasm
# install this site's dependencies.
pip install markdown scss pyyaml
# make a directory for your site and change into it.
mkdir cytoplasm-site
cd cytoplasm-site
# initialize this site.
cytoplasm init cytoplasm-site
# build the site..
cytoplasm build
# serve it!
cytoplasm serve
~~~~
Go to <http://localhost:8080> and you'll have a local replica of this website running. How's that for recursion? Douglas Hofstadter would be proud.

After you spend a few moments in awe, you can quit the web server with ctrl-C.

## Your Very Own Site
Now that you can see the edges of how Cytoplasm works, you're probably bounding with unharnessed creativity. Don't worry. It's easy. 

We're going to start from the beginning here, but feel free to just edit the files you got above. You might want to pretend to follow along, though, just to get the hang of things:
~~~~{.bash}
# make a new directory and change into it.
mkdir bounding_creativity
cd bounding_creativity
# Initialize the bare cytoplasm site here.
cytoplasm init bare
# make the `_posts` directory
mkdir _posts
~~~~
Let's make an example post and put it into our `_posts` directory as `creativity.html.markdown`, just for kicks.
~~~~{.markdown}
<!-- metadata
title: Unbounded Creativity
date: 2011/12/17
tags: [creativity, cytoplasm]
-->

Oh man, Cytoplasm is _so_ exciting!
~~~~
The first part of this is an html comment that includes all of your metadata -- you _need_ to have the first two elements, `title` and `date`. Everything else is optional, and you can put whatever you want.

For now, though, see what you've got with `cytoplasm serve -r`. Go to <http://localhost:8080> again and you'll see your glorious content framed in half-assed html.

Keep the server running for now; `cytoplasm serve -r` will rebuild the site every time you make a change to the source.
## Chose Your Own Adventure
Do you want to...

* __edit__ the __half-assed html__? Go to [page 12][templates].
* __configure__ your new blog? You want [page vii][configuration].
* learn more about __controllers__ and __interpreters__? Go to [page 34][controllers, interpreters].
* __see__ the __example blog__? It's the third door on the [left][blog].
* __enable syntax highlighting__ or __read some more tips__? Go to [page 71][tips].
* __get more interpreters__? See the [glossary][known interpreters].
* browse the __git repository for Cytoplasm__? See Github, [Appendix A][Github cytoplasm].
* browse the __git repository for this site__? See Github, [Appendix B][Github cytoplasm-site]

[templates]: /templates.html
[configuration]: /configuration.html
[controllers, interpreters]: /controllers_and_interpreters.html
[blog]: /blog
[tips]: /tips.html
[known interpreters]: /known_interpreters.html
[Github cytoplasm-site]: https://github.com/startling/cytoplasm-site
[Github cytoplasm]: https://github.com/startling/cytoplasm
