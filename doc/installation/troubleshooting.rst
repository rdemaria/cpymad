.. _troubleshooting:

Troubleshooting
---------------

In the following we will try to keep a list of the various issues and fixes
that might occur during or after installation.

After a successful installation, please use the following command to verify
that the extension can be loaded:

.. code-block:: bash

    python -c "import cpymad.libmadx as l; l.start()"

The MAD-X banner should appear.

.. contents:: :local:


Setup or compile time errors
============================

Errors that occur during the execution of ``pip install cpymad`` or ``python
setup.py build``.


ERROR: No matching distribution found
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Problem: ``pip install cpymad`` fails with either or both of these messages::

    ERROR: Could not find a version that satisfies the requirement cpymad
    ERROR: No matching distribution found for cpymad

This usually means that we haven't uploaded wheels for your platform or python
version. In this case, either ping us about adding a corresponding wheel, or
refer to the platform specific `Installation Instructions`_.

.. _Installation Instructions: ./installation


fatal error: ``madX/mad_types_f.h``: No such file or directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Problem: ``pip install cpymad`` fails and shows an error similar to the
following::

    gcc [...] -c src/cpymad/libmadx.c [...]
    src/cpymad/libmadx.c:642:10: fatal error: madX/mad_types_f.h: No such file or directory
      642 | #include "madX/mad_types_f.h"
          |          ^~~~~~~~~~~~~~~~~~~~
    compilation terminated.
    error: command 'gcc' failed with exit status 1
    ----------------------------------------
    ERROR: Command errored out with exit status 1: [...]

This occurs because pip couldn't find a prebuilt binary wheel that is
compatible with your platform, and tried to build the source distribution
instead. Please ping us about adding a wheel for your platform or refer to the
:ref:`building-from-source` guide.


OSError: Missing source file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Message::

    OSError: Missing source file: 'cpymad/libmadx.c'. Install Cython to resolve this problem.

This can occur if building cpymad from a local checkout without having Cython
installed. The solution is to install cython and try again:

.. code-block:: bash

    pip install cython


Runtime errors
==============

Errors that occur after a successful installation when trying to use cpymad.


ImportError: undefined symbol: dgelsd\_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Message::

    ImportError: [...]/cpymad/libmadx.so: undefined symbol: dgelsd_

This message is the result of linking cpymad's libmadx extension module
without a required dependency. In the specific case above, it means that MAD-X
was built with BLAS/LAPACK, but cpymad was not linked against these libraries.
The cpymad setup currently has no mechanism to detect with which libraries
MAD-X was built and assumes by default only some standard libraries.

Possible solutions are either rebuilding MAD-X without BLAS/LAPACK, or passing
appropriate libraries during the cpymad build step. The latter can be done by
through environment variables:

.. code-block:: bash

    export BLAS=1
    export LAPACK=1
    pip install .

Or by passing linker flags to the ``setup.py build_ext`` command manually:

.. code-block:: bash

    python setup.py build_ext -lblas -llapack


ImportError: libmadx.so
~~~~~~~~~~~~~~~~~~~~~~~

Message::

    ImportError: libmadx.so: cannot open shared object file: No such file or directory

This error can have multiple causes. It often means that cpymad is linked
against one or more dynamic libraries that could not be found at runtime.
Reasons may be that the MAD-X installation was moved or removed after building
cpymad.

A possible solution is to use a permanent installation directory for MAD-X and
specify this during the build:

.. code-block:: bash

    export MADXDIR=<madx-install-prefix>
    pip install .

Another possible solution is to specify the appropriate ``RPATH`` to the setup
script when building:

.. code-block:: bash

    python setup.py build_ext --rpath=<rpath>
    python setup.py install

Here, ``<madx-install-prefix>`` is the base folder containing the subfolders
``bin``, ``include``, ``lib`` of the MAD-X build and ``<rpath>`` contains the
dynamic library files.

If this does not work, you can set the ``LD_LIBRARY_PATH`` (or
``DYLD_LIBRARY_PATH`` on OSX) environment variable before running pymad, for
example:

.. code-block:: bash

    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.local/lib/
