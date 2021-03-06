A wedding website for Martin Stancsics and Dóri Boros.
This package is a simple `Flask` blueprint that
provides a static site plus RSVP functionality (with
emails notifications).

This webpage is a fork of the wedding webpage of
(https://github.com/davenquinn/wedding-website)[Daven Quinn's wedding website].
 Many thanks to him for making it open source and encouraging forking.

# Installation

The blueprint can be used either at the root
of a website or as part of a larger `Flask` app. An example
of the former setup is contained in `test-app.py`. On my website,
I mounted the entire package at the `/wedding` endpoint.

As this is a standard Python package, the installation
is best accomplished via `pip`:

    > pip install git+https://github.com/davenquinn/wedding-website.git

If you're modifying this for your own use, it might be a
better idea to fork the code, clone the repository to a
local directory, and install using `pip install -e <your repo dir>`
so you can change things at will.

The website includes a basic testing server (`test-app.py`).
In general, serving should be accomplished via a performant
web + WSGI server stack (e.g. `nginx` + `gunicorn`), with
specific  provisions for handling static files.
[Tutorials](https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-uwsgi-and-nginx-on-ubuntu-14-04)
[abound](https://devcenter.heroku.com/articles/python-gunicorn) on
how to make this happen.

# Frontend development

The website uses `sass`/`compass` for stylesheet compilation
and  `coffeescript` for coming up with Javscript. I fully
acknowledge that these are kind of over-complex tools for
this small project, but they are easy enough to implement
if desired.

The `Makefile` contains recipes for installing and using
these tools: simply `make install` to bootstrap the tools
(requires Ruby, Node.js and `npm`), and `make` to compile.

