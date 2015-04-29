CPyMAD
------
|Version| |Downloads| |License| |Python|

CPyMAD is a Cython_ binding to MAD-X_.

MAD-X is a software package to simulate particle accelerators and is used
at CERN and all around the world. It has its own proprietary scripting
language and is usually launched from the command line.

This version of CPyMAD is tested with MAD-X |VERSION|. Other MAD-X
versions (and immediate revisions) might work too, but are more likely to
cause problems.

The installable wheel archives that are provided for some versions of
python to simplify the installation on windows contain a precompiled
version of CPyMAD that is statically linked against MAD-X |VERSION|.

.. _Cython: http://cython.org/
.. _MAD-X: http://cern.ch/mad
.. |VERSION| replace:: 5.02.05


Disclaimer
~~~~~~~~~~

This is a heavily modified fork of the cern-cpymad_ package. The fork is
not authored or maintained by CERN members.

CPyMAD links against an unofficial build of MAD-X that is not supported by
CERN, i.e. in case of problems you will not get help there.

.. _cern-cpymad: https://github.com/pymad/cpymad


Project pages
~~~~~~~~~~~~~

- `Installation`_
- `Source code`_
- `Documentation`_
- `Issue tracker`_
- `Releases`_

.. _Installation: http://hibtc.github.io/cpymad/installation
.. _Source code: https://github.com/hibtc/cpymad
.. _Documentation: http://hibtc.github.io/cpymad
.. _Issue tracker: https://github.com/hibtc/cpymad/issues
.. _Releases: https://pypi.python.org/pypi/cpymad


Usage
~~~~~

The ``Madx`` class provides a basic binding to the MAD-X interpreter:

.. code-block:: python

    from cpymad.madx import Madx

    # create a new interpreter instance:
    # the optional 'command_log' parameter can be used to store MAD-X
    # command history.
    madx = Madx(command_log="log.madx")

    # determine the version of MAD-X that is actually loaded:
    print(madx.version)

    # you execute arbitrary textual MAD-X commands:
    madx.input('call, file="input_file.madx";')

    # there is a more convenient syntax available which does the same:
    madx.command.call(file="input_file.madx")

    # And for some commands there exist direct shortcuts:
    madx.call('/path/to/some/input_file.madx')

    # Calculate TWISS parameters:
    twiss = madx.twiss(sequence='LEBT',
                       betx=0.1, bety=0.1,
                       alfx=0.1, alfy=0.1)

    # Your own analysis below:
    from matplotlib import pyplot as plt
    plt.plot(twiss['s'], twiss['betx'])
    plt.show()

There is also a ``Model`` class which encapsulates more metadata for complex
accelerator machines. If you have ready-to-use model definitions on your
filesystem, models can be instanciated and used as follows:

.. code-block:: python

    from cpymad.model import Model

    model = Model.load('/path/to/model/definition.cpymad.yml')

    for sequence in model.sequences.values():
        twiss = sequence.twiss()

See http://hibtc.github.io/cpymad for further documentation.


Contributing
~~~~~~~~~~~~

Try to be consistent with the PEP8_ guidelines. Add `unit tests`_ for all
non-trivial functionality. `Dependency injection`_ is a great pattern to
keep modules testable.

Commits should be reversible, independent units if possible. Use descriptive
titles and also add an explaining commit message unless the modification is
trivial. See also: `A Note About Git Commit Messages`_.

.. _PEP8: http://www.python.org/dev/peps/pep-0008/
.. _`unit tests`: http://docs.python.org/2/library/unittest.html
.. _`Dependency injection`: http://www.youtube.com/watch?v=RlfLCWKxHJ0
.. _`A Note About Git Commit Messages`: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html


Tests
~~~~~

When a commit is pushed upstream, the tests are automatically run on the
following continuous integration (CI) systems:

- `AppVeyor`_ runs the tests in windows environments for python{2.7,3.4}.
  |AppVeyor|

- `Travis CI`_ runs the tests in a linux container for python{2.7,3.4}.
  For performance reasons the tests make use of a precompiled version of
  the MAD-X library which is hosted in an *unofficial* launchpad PPA_.
  |Travis| |Coverage|


.. _AppVeyor: https://ci.appveyor.com/project/coldfix/cpymad
.. _Travis CI: https://travis-ci.org/hibtc/cpymad
.. _PPA: https://launchpad.net/~coldfix/+archive/ubuntu/madx/

.. |AppVeyor| image:: https://ci.appveyor.com/api/projects/status/github/hibtc/cpymad?branch=master&svg=true
   :target: https://ci.appveyor.com/project/coldfix/cpymad
   :alt: Windows built status

.. |Travis| image:: https://api.travis-ci.org/hibtc/cpymad.svg?branch=master
   :target: https://travis-ci.org/hibtc/cpymad
   :alt: Linux build status

.. |Coverage| image:: https://coveralls.io/repos/hibtc/cpymad/badge.svg?branch=master
   :target: https://coveralls.io/r/hibtc/cpymad
   :alt: Coverage

.. |Version| image:: https://pypip.in/v/cpymad/badge.svg
   :target: https://pypi.python.org/pypi/cpymad/
   :alt: Latest Version

.. |Downloads| image:: https://pypip.in/d/cpymad/badge.svg
   :target: https://pypi.python.org/pypi/cpymad#downloads
   :alt: Downloads

.. |License| image:: http://img.shields.io/badge/license-CC0,_Apache,_Non--Free-red.svg
   :target: https://github.com/hibtc/cpymad/blob/master/COPYING.rst
   :alt: License

.. |Python| image:: https://pypip.in/py_versions/cpymad/badge.svg
   :target: https://pypi.python.org/pypi/cpymad#downloads
   :alt: Supported Python versions
