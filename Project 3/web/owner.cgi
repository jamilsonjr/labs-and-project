#!/usr/bin/python3

import psycopg2
import login

#Initizalize HTML
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title> Project 3 - Owner</title>')
print('</head>')
print('<body>')
connection = None

try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    # Page Header
    print('<h3>List of Boat Owners</h3>')

    # Create and Run SQL Query
    sql = 'SELECT name,id,iso_code,birthdate FROM owner natural join person;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
    


    # Create and Format Table
    print('<table border="0" cellspacing="10">')
    # Table Header
    owner_header = ['Name','ID','ISO Code','Birthdate','Action']
    print('<tr>')
    for col_name in owner_header:
        print('<th>%s</th>'%col_name)
    print('</tr>')
    # Table Rows
    for row in result:
        print('<tr>')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td><center>{} </center></td>'.format(value))
        print('<td><a href="delete_owner.cgi?owner_id={}&owner_iso_code={}">Remove Owner</a></td>'.format(row[1],row[2])) #Scanf
        print('</tr>')
    print('</table>')


    # Page Header 2
    print('<h3>New owner? Please register here:</h3>')
    # Create Form
    print('<form action="insert_owner.cgi" method="post">')
    print('<p>Id: <input type="text" name="owner_id"/></p>')
    # Create and Run SQL Query
    sql = 'SELECT DISTINCT iso_code FROM country;'
    cursor.execute(sql)
    result = cursor.fetchall()

    print('<label for="owner_iso_code">Owner Nationality (ISO Code):</label>')
    print('<select name="owner_iso_code" id="owner_iso_code">')
    for iso in result:
        print('<option value={}>{}</option>'.format(iso[0],iso[0]))
    print('</select>')

    print('<br><br>')

    print('<label for="owner_birthdate">Birthdate:</label>')
    print('<input type="date" id="owner_birthdate" name="owner_birthdate">')
    
    # Submit and Close form
    print('<p><input type="submit" value="Register Owner"/></p>')
    print('</form>')
    print('<p> <a href="home.cgi"> < Home Page </a></p>')

    # Closing connection
    cursor.close()
    connection.close()

except Exception as e:
    # Print errors on the webpage if they occur
    print('<p> Status: <b>Something went wrong</b>.')    
    print('<p> Description: {} </p>'.format(e))

finally:
    if connection is not None:
        connection.close()

# Close HTML
print('</body>')
print('</html>')