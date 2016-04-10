Sample Python Project
=====================

This repository is a very simple Python application skeleton.  I do not start
new projects by cloning this or anything.  It is just a really useful thing
to point new Python developers at.  It shows how to use a handful of *best
practices* techniques and tools.  First we need to discuss two very important
utilities that are absolutely required if you are doing any Python development.

setuptools
----------

This is the standard utility that extends and expands the standard Python
``distutils`` package.  Installation is described on the `pypi entry`_
for ``setuptools``.

virtualenv
----------

This is a utility that you absolutely need to install unless you are lucky
enough to be writing code against Python 3.3 or later (it has this built in).
Download and install it from `virtualenv`_.  You will want to install this
globally (system-wide) if at all possible.

Quick Start
-----------

If you are really impatient and already have ``setuptools`` and ``virtualenv``
installed, then run the following commands in a shell and you will be off and
running::

    prompt$ make requirements
    Makefile:86: ...: No such file or directory (1)
    Creating virtual environment in ...
    Installing requirements using pip.
    This make take a few minutes...
       You are installing ...(2)
    prompt$

The first time that you run *make*, you will get a warning about including
*makefile.inc* that you can ignore.  This file is created once the environment
is set up.  You might also see some warnings about *installing an externally
hosted file*.  These are also ignorable; they come from installing `dulwich`_.

At this point, you can run a number of useful make targets such as *make test*
to run unit tests.  *Makefile.inc* mentioned previously is a generated file
that will proxy commands through to *setup.py* so that you can use targets
like *make sdist* to generate a source distribution using *setup.py sdist* or
*make nosetests* to run *nosetests*.  In addition to the conventional *make
clean* targets, you can run *make shell* to drop into a command shell with
the virtual environment activated.

Files
=====

Now that we have that out of the way, let's talk through the various files.
There are only a handful of them that really matter.  The python files in
the *packagename* and *tests* directories are pretty worthless but they are
required to make the whole package work.

*setup.py*
----------

This is the ever present setup file that utilizes `setuptools`_ to provide
a nice command line installation and build utility.  The comments in
*setup.py* describe the various components.  My contribution here is that I
reuse the pip requirements file and top-level README to configure the setup
utility.

*requirements.txt*
------------------

This is a `pip requirements file`_ which contains the packages that your
project requires in the installation environment to run.  In other words,
your runtime dependencies.  These will be installed as dependencies when
someone installs your package.

*test-requirements.txt*
-----------------------

This is the `pip requirements file`_ which contains the packages that your
project needs for testing purposes.  These will not be installed until the
test target of *setup.py* is invoked.  By default, I've included a few
packages that I really cannot develop code without these days.

*tools.txt*
-----------

Yet another `pip requirements file`_ that contains my basic SCM environment.
I use `mercurial`_ for my day-to-day source control, `hg_git`_ to integrate
against github.com, and `setuptools_hg`_ to integrate setup tools and my
source control.

*setup.cfg*
-----------

This is a seldom described but very useful file.  Many of the various
development utilities such as `nose`_, `pytest`_, and `flake8`_ will peek in
a *setup.cfg* file for configuration settings.  This is a standard INI style
file that contains separate sections for each of the utilities that use it.


.. _pypi entry: https://pypi.python.org/pypi/setuptools
.. _virtualenv: http://www.virtualenv.org/
.. _setuptools: https://pypi.python.org/pypi/setuptools
.. _pip requirements file: http://www.pip-installer.org/en/latest/cookbook.html#requirements-files
.. _nose: https://nose.readthedocs.org/en/latest/usage.html#configuration
.. _pytest: http://pytest.org/latest/customize.html
.. _flake8: http://flake8.readthedocs.org/en/latest/config.html
.. _mercurial: http://mercurial.selenic.com
.. _hg_git: http://hg-git.github.io
.. _setuptools_hg: https://pypi.python.org/pypi/setuptools_hg
.. _dulwich: http://www.samba.org/~jelmer/dulwich/
