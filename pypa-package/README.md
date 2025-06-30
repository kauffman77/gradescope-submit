

# gradescope-submit

A command line script to upload programming projects to Gradescope.

This python script allows a user to upload a programming project to
Gradescope from the command line.

The project homepage is on Github here:
<https://github.com/kauffman77/gradescope-submit>


## Example Run

    >> gradescope-submit 618117 6326806 lab01-complete.zip 
    Submitting zipfile lab01-complete.zip with 17 files
    ==Gradscope Login Credentials==
    email: student9@terpmail.umd.edu
    password: 
    
    Contacting Gradescope
    - https://www.gradescope.com OK (200)
    - https://www.gradescope.com/login OK (200)
    - https://www.gradescope.com/courses/618117/assignments/6326806 OK (200)
    - https://www.gradescope.com/courses/618117/assignments/6326806/submissions OK (200)
    - https://www.gradescope.com/courses/618117/assignments/6326806/submissions/336679776 submission link
    Submit Successful
    
    Monitoring Autograder Progress
    - unprocessed
    - autograder_task_started
    - autograder_harness_started
    - processed
    
    Autograder Results
    - Lab Tests: 1.0 / 1.0


## Kinds of Submissions

Submissions of various kinds are supported

    >> gradescope-submit 618117 6326806 lab01-complete.zip  # submit files in a zip file
    >> gradescope-submit 618117 6326806 lab01-complete/     # submit all files in named directory
    >> gradescope-submit 618117 6326806 .                   # submit all files in this directory
    >> gradescope-submit 618117 6326806                     # default: submit all files in this directory
    >> gradescope-submit 618117 6326806 file1.c file2.c     # submit specific files together


## Installation

There are two ways to install `gradescope-submit`


### Copy the File

Just copy the file `gradescope-submit` to wherever you plan to use it
and distribute. It works as a stand-alone script and can be included
with assignments. A direct link to the most recent version published
on Github is here: [direct link to script.](https://raw.githubusercontent.com/kauffman77/gradescope-submit/refs/heads/master/gradescope-submit)  Save it, `wget` it, do what
you've gotta do.

If you are a student and want to use it for a project and are
relatively new to Linux/UNIX, try the commands:

    >> wget https://raw.githubusercontent.com/kauffman77/gradescope-submit/refs/heads/master/gradescope-submit
    ...
    >> chmod u+x gradescope-submit
    >> ./gradescope-submit --help

If you see a help message, you're in business.


### Install via pip

The code is also on [The Python Package Index (PyPI)](https://pypi.org/project/gradescope-submit/). Try ONE of the
following commands

    >> sudo pip install gradescope-submit    # system-wide install for admins/root user
    
    >> pip install gradescope-submit --user  # single-user install for normal users

For folks whose environment doesn't allow installs like this (hello
Arch Linux users), mess with virtual environments to get things going,
something along the lines of

    >> python -m venv .venv
    >> source .venv/bin/activate
    (.venv) >> pip install gradescope-submit

Of course you'll have to source the virtual environment when you want
to use it but I'm betting you're accustomed to such things
already. You can also just plop the `gradescope-submit` file down in
`/usr/bin` and make it executable.


# Course / Assignment ID

The Course and Assignment IDs along with Submission IDs must be passed
as command line arguments. These show up in the URLs on Gradescope's
site:

    https://www.gradescope.com/courses/618117/assignments/6326806/submissions/336672290
                                       |                  |                   +-> Submission ID
                                       |                  +-> Assignment ID
                                       +-> Course ID

Hopefully some kindly instructor has wrapped submissin in a `Makefile`
which passes the IDs to this script so you can just type `make submit`
but if not, the URL where you'd go to submit manually reveals this
(and then you can add your own target for `make submit` to this to your own
Makefile; you **do** have a `Makefile`, right?).

Each submission is assigned an ID as well with most recent submission
being the "active" submission which usually gets graded. on visiting
the assigment, one can change the active submission to a past one if
desired. 


# Login / Password

When run, the script will prompt for the email address and password on
Gradescope. This is typically NOT the same as the Single Sign-On
passwords used at most schools. If you get password errors, you might
try reseting your Gradscope password at:
<https://www.gradescope.com/reset_password>

If you are willing to run a modest security risk, you can set your
email address and passwod in environment variables which the script
will use removing the need to type these in.

**WARNING**: Storing passwords in plain text configuration files is
generally not a good idea so do thie following at your own
risk. Convenience almost always trades away security.


## Bash Shell Temporary

    >> export GRADESCOPE_EMAIL=student9@terpmail.umd.edu  # replace with your email
    >> export GRADESCOPE_PASSWORD=suPer_seCret7           # and password
    
    >> gradescope-submit 618117 6326806 lab01-complete.zip 
    Submitting zipfile lab01-complete.zip with 17 files
    
    Contacting Gradescope                                 # no prompts, direct connect
    - https://www.gradescope.com OK (200)
    - https://www.gradescope.com/login OK (200)
    ....


## Bash Shell Permanent

    >> echo export GRADESCOPE_EMAIL=student9@terpmail.umd.edu >> ~/.bashrc  # replace with your email
    >> echo export GRADESCOPE_PASSWORD=suPer_seCret7 >> ~/.bashrc           # and password
    >> source ~/.bashrc


## tcsh Shell Temporary

    >> setenv GRADESCOPE_EMAIL student9@terpmail.umd.edu  # replace with your email
    >> setenv GRADESCOPE_PASSWORD suPer_seCret7           # and password
    >> gradescope-submit 618117 6326806 lab01-complete.zip 


## tcsh Shell Permanent

    >> echo setenv GRADESCOPE_EMAIL student9@terpmail.umd.edu >> ~/.cshrc  # replace with your email
    >> echo setenv GRADESCOPE_PASSWORD suPer_seCret7 >> ~/.cshrc           # and password


## Other Shells

You probably know what you're doing if you aren't using one of the
defaults so, you know, set an envioronment variable.


# Dependencies

The script depends on the [`requests` library](https://pypi.org/project/requests/) to handle the HTTP
communications. This library is fairly ubiquitous with many pieces of
software depending on it so it's likely
installed on most systems. However, if errors arise like

    ModuleNotFoundError: No module named 'requests'

then consult how you might install this on your system likely via an
OS package manager or the Python package manager.  A `pip` via a
command like

-   `pip install requests`
-   `pip install requests --user`

will often do the trick


# API

The code is mainly intended as a stand-alone script BUT has just a few
functions in it that can be used by other code. If installed via PyPI,
you should be able to import the module and see the central functions.

    $ python
    >>> import gradescope_submit
    >>> gradescope_submit.submit_assignment
    <function submit_assignment at 0x7f7086ae4400>

If you're interested in using the functions as a module, let me know
and we can work together on it.


# License

`gradescope-submit` is released under the terms of the **GNU General
Public License v3.0-or-later (GPLv3-or-later)**. A copy of the
GPLv3-or-later is included in the file `LICENSE` in the source
repository.


# Development and Contributions

This is a small solo project but contributors are welcome. The source
is documented to try to ease understanding and <NOTES.txt> in the
git repository has some development notes on how the program was
constructed and plans for the future. Ping me if you'd like to suggest
changes.

Happy Hacking!
&#x2013; Chris

