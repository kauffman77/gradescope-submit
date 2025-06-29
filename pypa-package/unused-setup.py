# This (incomplete) file is what the setuptools package historically
# used to describe a python install. According to sources, the
# pyproject.toml file is preferred as it is now a standard and used by
# several of pythons various build/packaging systems.

from setuptools import setup

setup(
   name='gradescope_submit',
   version='0.1',
   description='Script/Module to upload assignments to Gradescope from the command line',
   author='Chris Kauffman',
   author_email='kauffman77@gmail.com',
   packages=['gradescope_submit'],
   install_requires=[                           # external packages as dependencies
     'requests',                                # used for communication with server
   ],
   entry_points={
     'console_scripts': [
       'gradescope-submit = gradescope_submit', # allows running of module as a script
     ]
   },
)
