#!/usr/bin/python3
import psycopg2, cgi
import login

# Load Attributes
form = cgi.FieldStorage()
boat_name = form.getvalue('boat_name')
boat_year = form.getvalue('boat_year')
boat_cni = form.getvalue('boat_cni')
boat_iso_code = form.getvalue('boat_iso_code')
boat_owner= form.getvalue('boat_owner')
boat_mmsi = form.getvalue('boat_mmsi')

if boat_owner != None:
    boat_owner_id,boat_owner_iso_code = boat_owner.split('#@')

# Initizalize HTML
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
    print('<h3>SQL LOG - INSERT BOAT:</h3>')
    
    # Create and Run SQL Query
    sql = 'INSERT INTO boat VALUES (%s,%s,%s,%s,%s,%s);'
    data = (boat_name,boat_year,boat_cni ,boat_iso_code,boat_owner_id,boat_owner_iso_code)
    print('<p>Query: {}.</p>'.format(sql % data))

    cursor.execute(sql, data)
    connection.commit()
    print('<p>Status: Insert completed sucessfully.</p>')

    if boat_mmsi != None:
        sql = 'INSERT INTO boat_vhf VALUES (%s,%s,%s);'
        data = (boat_mmsi,boat_cni,boat_iso_code,)
        print('<p>Query: {}.</p>'.format(sql % data))
        cursor.execute(sql, data)
        connection.commit()
        print('<p>Status: Insert completed sucessfully.</p>')

    # Connectivity to Page - Boat
    print('<td><a href="boat.cgi"> < List of Boats </a></td>')

    # Closing connection
    cursor.close()
    connection.close()

except Exception as e:
    # Print errors on the webpage if they occur
    print('<p> Status: <b>Insert Failed</b>.')    
    print('<p> Description: {} </p>'.format(e))

finally:
    if connection is not None:
        connection.close()

# Close HTML
print('</body>')
print('</html>')