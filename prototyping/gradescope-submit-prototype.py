# working version that submits two pre-determined files to a
# pre-determined course/assign; prompts for email and password

import requests
import re
import getpass

# the www is important
GRADESCOPE_URL="https://www.gradescope.com"
COURSE_ID=618117
ASSIGN_ID=5522418

print("==Gradscope Login Credentials==")
email = input('email: ')
password = getpass.getpass("password: ")
print()

print("Contacting Gradescope")
session = requests.Session()

url = GRADESCOPE_URL
response = session.get(url)
print(f"{url} response {response.reason} ({response.status_code})")
response.raise_for_status()

# extract token from the html on the main page
login_auth_token = \
  re.search(r'action="/login".*?authenticity_token" value="([^"]*)"', \
            response.text)[1]

# data required on the login page
login_data = [
  ("utf8", "✓"),
  ("session[email]", email),       # "email@gmail.com"
  ("session[password]", password), # "abc12345"
  ("session[remember_me]", 0),
  ("commit", "Log+In"),
  ("session[remember_me_sso]", 0),
  ("authenticity_token", login_auth_token),
]

# perform the login request which will store cookies for the session
url = f"{GRADESCOPE_URL}/login"
response = session.post(url,login_data)
print(f"{url} response {response.reason} ({response.status_code})")
response.raise_for_status()

# visit the assignment page to get an authentication token for
# submission
url = f"{GRADESCOPE_URL}/courses/{COURSE_ID}/assignments/{ASSIGN_ID}"
response = session.get(url)
print(f"{url} response {response.reason} ({response.status_code})")
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
  
# test file names
fname1 = "testfile1.txt"
fname2 = "testfile2.txt"

# files are submitted in the form all with the name
# 'submission[files][]'; later tuple is as described and format for
# preparation is supported by 
submit_files = [              
  # form field name       (fname,  file handle,       mime/Content-Type)
  ("submission[files][]", (fname1, open(fname1,'rb'), "text/plain")),
  ("submission[files][]", (fname2, open(fname2,'rb'), "text/plain")),
]

url = f"{GRADESCOPE_URL}/courses/{COURSE_ID}/assignments/{ASSIGN_ID}/submissions"
response = session.post(url, data=submit_data, files=submit_files)
print(f"{url} response {response.reason} ({response.status_code})")
response.raise_for_status()

print("Submit successful")
