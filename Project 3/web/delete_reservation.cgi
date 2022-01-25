#!/usr/bin/python3

import psycopg2, cgi
import login

# Load Attributes
form = cgi.FieldStorage()
boat_cni = form.getvalue('boat_cni')
boat_iso_code = form.getvalue('boat_iso_code')
sailor_id = form.getvalue('sailor_id')
sailor_iso_code = form.getvalue('sailor_iso_code')
start_date = form.getvalue('start_date')
end_date = form.getvalue('end_date')

#Initizalize HTML
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project 3 - Reservation </title>')
print('</head>')
print('<body>')

connection = None
try:

    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    # Page Header
    print('<h3>SQL LOG - DELETE RESERVATION:</h3>')

    # Create SQL Query
    sql = 'DELETE FROM reservation WHERE cni = %s AND iso_code_boat = %s AND id_sailor = %s AND iso_code_sailor = %s AND start_date = %s AND  end_date = %s;'
    data = (boat_cni,boat_iso_code,sailor_id, sailor_iso_code,start_date,end_date)
    print('<p>Query: {}.</p>'.format(sql % data))
    
    # Run SQL Query 
    cursor.execute(sql, data)
    connection.commit()
    print('<p>Status: Delete completed sucessfully. </p>')

    # Connectivity to Page - Reservation
    print('<td><a href="reservation.cgi"> < List of Reservations </a></td>')

    # Close Connection
    cursor.close()
    connection.close()

except Exception as e:
    # TO BE HANDLED
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))

finally:
    if connection is not None:
        connection.close()

# Close HTML
print('</body>')
print('</html>')