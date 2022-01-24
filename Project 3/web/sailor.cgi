#!/usr/bin/python3
from traceback import print_tb
import psycopg2
import login
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title> Project 3 - Sailor</title>')
print('</head>')
print('<body>')
print('<h3>Boat Sailors</h3>')
connection = None

try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    # Making query
    sql = 'SELECT * FROM sailor;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
    sailor_header = ['ID','ISO Code','Action']
    sailor_id = None
    sailor_iso_code = None


    # Displaying results
    print('<table border="0" cellspacing="10">')

    print('<tr>')
    for col_name in sailor_header:
        print('<th>%s</th>'%col_name)
    print('</tr>')

    for row in result:
        print('<tr>')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td><center>{} </center></td>'.format(value))
        print('<td><a href="delete_sailor.cgi?sailor_id={}&sailor_iso_code={}">Remove Sailor</a></td>'.format(row[0],row[1])) #Scanf
        print('</tr>')
    print('</table>')

    print('<h3>New Sailor? Please register here:</h3>')

    print('<form action="insert_sailor.cgi" method="post">')
    print('<p>Id: <input type="text" name="sailor_id"/></p>')
    print('<p>ISO code: <input type="text" name="sailor_iso_code"/></p>')
    print('<p><input type="submit" value="Register Sailor"/></p>')
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