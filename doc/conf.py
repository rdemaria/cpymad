#!/usr/bin/env python3

# -- General configuration ------------------------------------------------
extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.intersphinx',
    'sphinx.ext.viewcode',
    'sphinx.ext.githubpages',
    'sphinx-prompt',
    'sphinx_substitution_extensions',
]

templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'
exclude_patterns = ['_build']
add_function_parentheses = True
pygments_style = 'sphinx'


# General information about the project.
project = 'cpymad'
copyright = (
    u'2014-2020, T. Gläßle,'
    u'2014-2019, HIT Betriebs GmbH,'
    u'2011-2013 Y.I. Levinsen, K. Fuchsberger (CERN)')

import cpymad
release = cpymad.__version__                # The full version
version = '.'.join(release.split('.')[:2])  # The short X.Y version

with open('../MADX_VERSION') as f:
    MADX_VERSION = f.read().strip()

rst_prolog = """
.. |VERSION| replace:: {}
""".format(MADX_VERSION)


# -- Options for HTML output ----------------------------------------------
import sphinx_rtd_theme
html_theme = 'sphinx_rtd_theme'
html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
html_static_path = []
htmlhelp_basename = 'cpymaddoc'
