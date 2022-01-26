#!/usr/bin/python3

import psycopg2, cgi
import login

# Load Attributes
form = cgi.FieldStorage()
sailor_id = form.getvalue('sailor_id')
sailor_iso_code = form.getvalue('sailor_iso_code')

#Initizalize HTML
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project 3 - sailor </title>')
print('</head>')
print('<body>')

connection = None
try:

    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    # Page Header
    print('<h3>SQL LOG - DELETE SAILOR:</h3>')

    # Create SQL Query
    sql = 'DELETE FROM sailor WHERE id = %s AND iso_code = %s;'
    data = (sailor_id, sailor_iso_code)
    print('<p>Query: {}.</p>'.format(sql % data))

    # Run SQL Query 
    cursor.execute(sql, data)
    connection.commit()
    print('<p>Status: Delete completed sucessfully </p>')

    # Connectivity to Page - Sailor
    print('<td><a href="sailor.cgi"> < List of Sailors</a></td>')

    # Closing connection
    cursor.close()

except Exception as e:
    # Print errors on the webpage if they occur
    print('<p> Status: <b>Delete Failed</b>.')    
    print('<p>Description: {} </p>'.format(e))

finally:
    if connection is not None:
        connection.close()

print('</body>')
print('</html>')