#! python3
# usage: get-html.py <URL> returns html webpage as html file
import sys, os
from urllib import request

if len(sys.argv) < 2:
    print('usage: get-html.py url')
    sys.exit()

resp = request.urlopen(sys.argv[1])
html = resp.read().decode("UTF-8")

f = open(os.path.join(os.getcwd(),"resp.html"), 'w')
f.write(html)
f.close()
print("html file saved")
