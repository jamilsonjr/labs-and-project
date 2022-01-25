#!/usr/bin/python3
from traceback import print_tb
import psycopg2
import login

#Initizalize HTML
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title> Project 3 - Sailor</title>')
print('</head>')
print('<body>')

connection = None

try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    # Page Header
    print('<h3>List of Boat Sailors</h3>')

    # Create SQL Query
    sql = 'SELECT name,id,iso_code FROM sailor natural join person;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
    


    # Create and Format Table
    print('<table border="0" cellspacing="10">')
    print('<tr>')
    # Table Header
    sailor_header = ['Name','ID','ISO Code','Action']
    for col_name in sailor_header:
        print('<th>%s</th>'%col_name)
    print('</tr>')
    # Table Rows
    for row in result:
        print('<tr>')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td><center>{} </center></td>'.format(value))
        print('<td><a href="delete_sailor.cgi?sailor_id={}&sailor_iso_code={}">Remove Sailor</a></td>'.format(row[1],row[2])) #Scanf
        print('</tr>')
    print('</table>')

    # Page Header 2
    print('<h3>New Sailor? Please register here:</h3>')
    
    # Create Form
    print('<form action="insert_sailor.cgi" method="post">')
    print('<p>Id: <input type="text" name="sailor_id"/></p>')

    sql = 'SELECT DISTINCT iso_code FROM person;'
    cursor.execute(sql)
    result = cursor.fetchall()

    print('<label for="sailor_iso_code">Sailor Nationality (ISO Code):</label>')
    print('<select name="sailor_iso_code" id="sailor_iso_code">')
    for iso in result:
        print('<option value={}>{}</option>'.format(iso[0],iso[0]))
    print('</select>')

    # Submit and Close form
    print('<p><input type="submit" value="Register Sailor"/></p>')
    print('</form>')
    
    # Connectivity to Home Page 
    print('<p> <a href="home.cgi"> < Home Page </a></p>')

    # Closing connection
    cursor.close()
    connection.close()

except Exception as e:
    # Print errors on the webpage if they occur
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))

finally:
    if connection is not None:
        connection.close()
        
# Close HTML
print('</body>')
print('</html>')