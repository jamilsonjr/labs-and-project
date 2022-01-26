#!/usr/bin/python3

import psycopg2, cgi
import login

# Load Attributes
form = cgi.FieldStorage()
boat_cni = form.getvalue('boat_cni')
boat_iso_code = form.getvalue('boat_iso_code')

#Initizalize HTML
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project 3 - Boat </title>')
print('</head>')
print('<body>')

connection = None
try:

    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    # Page Header
    print('<h3>SQL LOG - DELETE BOAT:</h3>')
    
    # Create SQL Query
    sql = 'DELETE FROM boat WHERE cni = %s AND iso_code = %s;'
    data = (boat_cni, boat_iso_code)
    print('<p>Query: {}.</p>'.format(sql % data))
    cursor.execute(sql, data)
    connection.commit()
    print('<p>Status: Delete completed sucessfully.</p>')

    # Connectivity to Page - Boat
    print('<td><a href="boat.cgi"> < Go Back! </a></td>')

    # Closing connection
    cursor.close()
    connection.close()

except Exception as e:
    # Print errors on the webpage if they occur
    print('<p> Status: <b>Delete Failed</b>.')    
    print('<p>Description: {} </p>'.format(e))

finally:
    if connection is not None:
        connection.close()

# Close HTML
print('</body>')
print('</html>')