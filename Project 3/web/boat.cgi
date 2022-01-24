#!/usr/bin/python3
from traceback import print_tb
import psycopg2
import login
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title> Project 3 - Boat</title>')
print('</head>')
print('<body>')
print('<h3>Boat</h3>')
connection = None

try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    # Making query
    sql = 'SELECT * FROM boat;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
    boat_header = ['Name','Year','CNI','Boat ISO Code','Owner ID','Owner ISO Code']
    boat_cni = None
    boat_iso_code = None

    # Displaying results
    print('<table border="0" cellspacing="10">')

    print('<tr>')
    for col_name in boat_header:
        print('<th>%s</th>'%col_name)
    print('</tr>')

    for row in result:
        print('<tr>')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td><center>{} </center></td>'.format(value))
        print('<td><a href="delete_boat.cgi?boat_cni={}&boat_iso_code={}">Remove Boat</a></td>'.format(row[0],row[1])) #Scanf
        print('</tr>')
    print('</table>')

    print('<h3>New Boat? Please register here:</h3>')

    print('<form action="insert_boat.cgi" method="post">')
    print('<p>Boat Name: <input type="text" name="boat_name"/></p>')
    print('<p>Year of Registration: <input type="text" name="boat_iso_code"/></p>')
    print('<p>Country identifier (CNI): <input type="text" name="boat_cni"/></p>')
    print('<p>Country of Registration (ISO Code): <input type="text" name="boat_iso_code"/></p>')
    print('<p>Owner ID: <input type="text" name="boat_owner_id"/></p>')
    print('<p>Owner Nationality (ISO Code): <input type="text" name="boat_owner_iso_code"/></p>')
    print('<p><input type="submit" value="Register Owner"/></p>')
    print('</form>')
    print('<p></p>')
    print('<p></p>')
    print('<p></p>')
    print('<p> <a href="sibd.cgi"> < Index </a></p>')

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