#!/usr/bin/env python3
# Release: Mon Jun 30 10:14:36 AM EDT 2025
"""gradescope-submit: submit files to Gradescope assignment. Depends
on the `requests` python library for http communications.""" 

__version__ = "0.2.2"

import sys                      # argv etc
import os                       # for getcwd()
import re                       # regexs
import getpass                  # read a password from stdin
import argparse                 # command args
import zipfile                  # for handling zip files
import time                     # for sleep()

import requests                 # 3rd party lib for http communications

# main url for gradescope; the www is important
GRADESCOPE_URL="https://www.gradescope.com"

def submit_assignment(course_id, assign_id, email, password,
                      file_objs, autograder_wait=True):
  """Submit the indicated files to a course.

  Arguments are
  - course_id: string or int
  - assign_id: string or int
  - email: string, registered email on gradescope
  - password: string, password on gradescope
  - file_objs: a list of [(name,handle),...] for submission
  - autograder_wait: T/F controls whether to wait on the autograder

  This function is the workhorse of the script. Given the parameter
  information, it sets up a session with Gradescope, particularly with
  the cookies needed to submit. The basic protocol is

  1. GET www.gradescope.com to obtain an "authenticity_token" which is
     buried in the HTML of the page and required to attempt a login.
  2. POST to the login page with the token / email / password to
     log in and get appropriate cookies, most importantly the
     signed_token which represents a valid login.
  3. GET the assignment page to get another authenticity_token.
  4. POST to the assignment submission page passing the token and
     files that are part of the submission page.
  5. GET JSON data from the specific submission repeatedly which
     allows the progress and results of the autograder to be observed
     and reported.

  The `requests` library does the heavy listing allowing the above
  GET/POST operations to happen via simple function calls. 

  Note that the authenticity_tokens are buried in the HTML of the
  pages visited and regexs are used to extract the values. These are
  likely fragile and would need to be updated on changes to
  Gradescopes site and page formats."""
  print("\nContacting Gradescope")
  session = requests.Session()  # maintains cookies, does redirects
  
  url = GRADESCOPE_URL
  response = session.get(url)
  print(f"- {url} {response.reason} ({response.status_code})")
  response.raise_for_status()
  
  # extract token from the html on the main page
  login_auth_token = \
    re.search(r'action="/login".*?authenticity_token" value="([^"]*)"', \
              response.text)[1]
  
  # data required on the login page
  login_data = [
    ("utf8", "✓"),
    ("session[email]", email),
    ("session[password]", password),
    ("session[remember_me]", 0),
    ("commit", "Log+In"),
    ("session[remember_me_sso]", 0),
    ("authenticity_token", login_auth_token),
  ]
  
  # perform the login request which will store cookies for the session
  url = f"{GRADESCOPE_URL}/login"
  response = session.post(url,login_data)
  print(f"- {url} {response.reason} ({response.status_code})")
  response.raise_for_status()
  if not 'signed_token' in session.cookies.keys():
    print(f"""
LOGIN ERROR for {email}:
Check password and try again. Your Gradescope password may not be the
same as you school password. Reset Gradescope passwords at:
  {GRADESCOPE_URL}/reset_password""")
    return False

  # visit the assignment page to get an authentication token for
  # submission by visiting the assignment page
  url = f"{GRADESCOPE_URL}/courses/{course_id}/assignments/{assign_id}"
  response = session.get(url)
  print(f"- {url} {response.reason} ({response.status_code})")
  response.raise_for_status()
  
  # extract the token needed for submit from the meta tag where it appears
  submit_auth_token = re.search(r'meta name="csrf-token" content="([^"]*)"', 
                                response.text)[1]
  
  # submit form data has a "plain" part and a "files" part; this is the
  # data needed for the plain part
  submit_data = [                 
    # field  value
    ("utf8", "✓"),
    ("authenticity_token", submit_auth_token),
    ("submission[method]", "upload"),
  ]
    
  # requests library accetps files in form data as nested tuples:
  #   [ (field_name, (filename, file_handle)), ... ]
  # file_objs are the inner pair so deocorate with the field_name
  submit_files = [("submission[files][]", obj) for obj in file_objs]

  # perform the actual submission; adjust the headers to get JSON data
  # which shows success/failure of submission
  json_headers = {'Accept': 'application/json, text/javascript'}
  url = f"{GRADESCOPE_URL}/courses/{course_id}/assignments/{assign_id}/submissions"
  response = session.post(url, data=submit_data, files=submit_files, headers=json_headers)
  print(f"- {url} {response.reason} ({response.status_code})")
  response.raise_for_status()
  submit_json = response.json()           # parse response as json as was requestd
  if not submit_json["success"]:          # check for failed submission due
    print(f"SUBMISSION FAILED: The assignment deadline has likely closed")
    return False

  # report successful submission
  submission_url = f"{GRADESCOPE_URL}{submit_json['url']}"
  print(f"- {submission_url} submission link")
  print("Submit Successful")

  if not autograder_wait:                  # not waiting on autograder
    return True

  print("\nMonitoring Autograder Progress")
  ag_response = None                       # response on autograder progress
  status_prev = None                       # status from previous iteration
  ag_json = None                           # json data from response, set each iteration

  while True:                              # loop until autograder indicates 'processed'
    ag_response = session.get(submission_url,headers=json_headers)
    ag_response.raise_for_status()         # JSON headers show autograder progress / results
    ag_json = ag_response.json()           # parse response as json as was requestd
    status = ag_json['status']             # status indicates progress
    if status != status_prev:              # print on status changes
      print(f"- {status}")
      status_prev = status
    if status == 'processed':              # break as autograder completed
      break
    time.sleep(1)                          # wait a tick before polling again

  print("\nAutograder Results")
  for test in ag_json['results']['tests']: # iterate over each AG test and print summary
    print(f"- {test['name']}: {test['score']} / {test['max_score']}")
   
  return True


def file_objs_from_dir(dirname):
  """Recursively traverse the given directory and returns a list of
  (filename,handle). Includes only regular files, not
  directories. Used to provide files for assignment submission.
  
  NOTE: the handles returned are open so these handles will leak open
  file descriptors unless later closed; this is not done at present as
  the expectation is the script will complete immediately after
  submitting and the fds will thus be closed.

  """
  file_objs = []
  for path,_,files in os.walk(dirname):
    for f in files:
      fname = os.path.join(path,f)
      file_objs.append((fname, open(fname,"rb")))
  return file_objs

def file_objs_from_zip(zipname):
  """Returns a list of (filename,handle) objects extracted from the
  named zip file. Only regular files are included, not directories but
  the paths are preserved.
  
  NOTE: the handles returned are open so these handles will leak open
  file descriptors unless later closed; this is not done at present as
  the expectation is the script will complete immediately after
  submitting and the fds will thus be closed.

  """
  zf = zipfile.ZipFile(zipname)
  file_objs = [
    (n,zf.open(n))                              # pairs of name/file handle
    for n in zf.namelist()                      # 
    if not zf.getinfo(n).is_dir()               # filter plain directories
  ]
  return file_objs

def file_objs_from_list(fnames):
  """Returns a list of (filename,handle) objects based on the given
  list of filenames.
  
  NOTE: the handles returned are open so these handles will leak open
  file descriptors unless later closed; this is not done at present as
  the expectation is the script will complete immediately after
  submitting and the fds will thus be closed.

  """
  file_objs = [(n,open(n,"rb")) for n in fnames]
  return file_objs

def get_credentials():
  if 'GRADESCOPE_EMAIL' in os.environ and 'GRADESCOPE_PASSWORD' in os.environ:
    email = os.environ['GRADESCOPE_EMAIL']
    password = os.environ['GRADESCOPE_PASSWORD']
    return ("user/pass",(email,password))
  elif 'GRADESCOPE_EMAIL' in os.environ:
    email = os.environ['GRADESCOPE_EMAIL']
    print("==Gradscope Login Credentials==")
    print(f"email: {email}")
    password = getpass.getpass("password: ")
    return ("user/pass",(email,password))
  else:
    print("==Gradscope Login Credentials==")
    email = input('email: ')
    password = getpass.getpass("password: ")
    return ("user/pass",(email,password))

SHORT_DESCRIPTION = """\
Submit directories, zips, or files as a Gradescope assignment
"""

LONG_DESCRIPTION = """\
------------------------------
--- COURSE / ASSIGNMENT ID ---
------------------------------
The Course and Assignment IDs along with Submission IDs show up in the
URLs on the Gradescope site:

https://www.gradescope.com/courses/618117/assignments/6326806/submissions/336672290
                                   |                  |                   +-> Submission ID
                                   |                  +-> Assignment ID
                                   +-> Course ID

Hopefully some kindly instructor has wrapped submissin in a Makefile
which passes the IDs to this script so you can just type `make submit`
but if not, the URL where you'd go to reveals this (and then you can
add support for `make submit` to this to your own Makefile; you *do*
have a Makefile, right?).

Each submission is assigned an ID as well with most recent submission
being the "active" submission which usually gets graded. on visiting
the assigment, one can change the active submission to a past one if
desired. 
                                   
------------------------
--- LOGIN / PASSWORD ---
------------------------
When run, script will prompt for the email address and password on
Gradescope. This is typically NOT the same as the Single Sign-On
passwords used at most universities. If you get password errors, you
might try reseting your Gradscope password at
  https://www.gradescope.com/reset_password

If you are willing to run modest security risk, you can set your email
address and passwod in environment variables which the script will use
to limit the amoutn of typing.

--- WARNING ---
Storing passwords in plain text configuration files is generally not a
good idea so do thie following at your own risk. Convenience almost
always trades away security.

--- BASH SHELL TEMPORARY ---
>> export GRADESCOPE_EMAIL=student9@terpmail.umd.edu  # replace with your email
>> export GRADESCOPE_PASSWORD=suPer_seCret7           # and password

>> gradescope-submit 618117 6326806 lab01-complete.zip 
Submitting zipfile lab01-complete.zip with 17 files

Contacting Gradescope                                 # no prompts, direct connect
- https://www.gradescope.com OK (200)
- https://www.gradescope.com/login OK (200)
....

--- BASH SHELL PERMANENT ---
>> echo export GRADESCOPE_EMAIL=student9@terpmail.umd.edu >> ~/.bashrc  # replace with your email
>> export GRADESCOPE_PASSWORD=suPer_seCret7 >> ~/.bashrc                # and password
>> source ~/.bashrc

--- TCSH SHELL TEMPORARY ---
>> setenv GRADESCOPE_EMAIL student9@terpmail.umd.edu  # replace with your email
>> setenv GRADESCOPE_PASSWORD suPer_seCret7           # and password
>> gradescope-submit 618117 6326806 lab01-complete.zip 

--- TCSH SHELL PERMANENT ---
>> echo setenv GRADESCOPE_EMAIL student9@terpmail.umd.edu >> ~/.cshrc  # replace with your email
>> echo setenv GRADESCOPE_PASSWORD suPer_seCret7 >> ~/.cshrc           # and password

--- OTHER SHELLS ---
You probably know what you're doing if you aren't using one of the
defaults so, you know, set an envioronment variable.

-------------------
--- EXAMPLE RUN ---
-------------------
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

"""

def main():
  argparser = argparse.ArgumentParser(description=SHORT_DESCRIPTION,
                                      epilog=LONG_DESCRIPTION,
                                      formatter_class=argparse.RawDescriptionHelpFormatter)
  
  argparser.add_argument("-n","--no-autograder",dest='autograder_wait',action='store_false',
                         help="Disable waiting for the autograder to finish and show its results")
  argparser.add_argument("course_id",metavar="course_id",
                         help="Numeric ID of the course on Gradescope")
  argparser.add_argument("assign_id",metavar="assign_id",
                         help="Numeric ID of the assignment on Gradescope")
  argparser.add_argument("submission",metavar="submission",nargs="*", default=["."],
                         help="directory, zip, or files to submit; defaults to current directory (.)")

  args = argparser.parse_args()

  file_objs = None

  if len(args.submission) == 0:
    print(f"submissiono argument list is unexpectedly 0, WTF^M?")
    sys.exit(1)
  elif len(args.submission)==1 and os.path.isdir(args.submission[0]):
    dirname = args.submission[0]
    file_objs = file_objs_from_dir(dirname)
    print(f"Submitting directory {dirname} with {len(file_objs)} files")
  elif len(args.submission)==1 and args.submission[0].endswith(".zip"):
    zipname = args.submission[0]
    file_objs = file_objs_from_zip(zipname)
    print(f"Submitting zipfile {zipname} with {len(file_objs)} files")
  else:
    file_objs = file_objs_from_list(args.submission)
    print(f"Submitting list of {len(file_objs)} files")
    
  if not file_objs:                            # empty list
    print("No files to submit, bailing")
    sys.exit(1)

  (cred_kind,(email,password)) = get_credentials()
    
  ret = submit_assignment(args.course_id, args.assign_id, email, password,
                          file_objs, args.autograder_wait)
  if ret:
    sys.exit(0)
  else:
    sys.exit(2)

if __name__ == '__main__':
  main()
