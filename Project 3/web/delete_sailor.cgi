#!/usr/bin/python3

import psycopg2, cgi
import login

form = cgi.FieldStorage()

sailor_id = form.getvalue('sailor_id')
sailor_iso_code = form.getvalue('sailor_iso_code')

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

    # Making query
    sql = 'DELETE FROM sailor WHERE id = %s AND iso_code = %s;'
    data = (sailor_id, sailor_iso_code)

    # The string has the {}, the variables inside format() will replace the {}
    print('<p>Query Executed: {}</p>'.format(sql % data))
    print('<p>Status: Completed Sucessfully </p>')

    # Feed the data to the SQL query as follows to avoid SQL injection
    cursor.execute(sql, data)

    print('<td><a href="sailor.cgi"> < Go Back! </a></td>')

    # Commit the update (without this step the database will not change)
    connection.commit()

    # Closing connection
    cursor.close()

except Exception as e:
    # Print errors on the webpage if they occur
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))

finally:
    if connection is not None:
        connection.close()

print('</body>')
print('</html>')