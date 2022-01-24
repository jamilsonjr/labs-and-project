#!/usr/bin/python3
from traceback import print_tb
import psycopg2
import login
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title> Project 3 - Index </title>')
print('</head>')
print('<body>')

print('<b> <center> Website developed by Group 18 </center> </b>')

print('<h3>Welcome to,</h3>')

print('<h1> The Boating Management Database Website </h1>')

print('<h2> Feel free to visit one of the following pages:  </h2>')

print('<ul>')
print('<li> <a href="boat.cgi"> Boat Management </a></li>')
print('<li> <a href="owner.cgi"> Owner Management </a></li>')
print('<li> <a href="sailor.cgi"> Sailor Management </a></li>')
print('</ul>')


print('</body>')
print('</html>')