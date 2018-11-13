import sys
import os

# project variables
project = u'<sdk_project>'
copyright = u'<sdk_company>'
author = u'<sdk_author>'
version = u'<sdk_version>'
release = u'<sdk_version>'

# theme config
html_theme = 'satheme'
html_theme_options = {"logo_only":True}
html_theme_path = ["themes",]
html_logo = 'themeres/logo.png'
html_context = {
    'all_versions' : <full_version_string>,
    'domain': '<sdk_domain>',
    'sourcecode': '<sdk_source>',
	'sdk_id': '<sdk_id>'
}

# aux vars
extensions = []
templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'
language = None
exclude_patterns = []
show_authors = True
pygments_style = 'sphinx'
todo_include_todos = False
