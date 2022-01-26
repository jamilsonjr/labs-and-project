#!/usr/bin/python3

import psycopg2, cgi
import login

# Load Attributes
form = cgi.FieldStorage()
owner_id = form.getvalue('owner_id')
owner_iso_code = form.getvalue('owner_iso_code')

#Initizalize HTML
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project 3 - Owner </title>')
print('</head>')
print('<body>')

connection = None
try:

    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    # Page Header
    print('<h3>SQL LOG - DELETE OWNER:</h3>')

    # Create SQL Query
    sql = 'DELETE FROM owner WHERE id = %s AND iso_code = %s;'
    data = (owner_id, owner_iso_code)
    print('<p>Query: {}.</p>'.format(sql % data))
    
    # Run SQL Query 
    cursor.execute(sql, data)
    connection.commit()
    print('<p>Status: Delete completed sucessfully.</p>')

    # Connectivity to Page - Owner
    print('<td><a href="owner.cgi"> < List of Owners </a></td>')

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