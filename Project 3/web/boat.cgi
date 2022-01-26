#!/usr/bin/python3
import psycopg2
import login

#Initizalize HTML
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title> Project 3 - Boat</title>')
print('</head>')
print('<body>')
connection = None

try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    # Page Header
    print('<h3>List of Boat</h3>')

    # Making query
    sql = 'SELECT b.name,b.year,b.cni,b.iso_code,p.name,p.id,p.iso_code,v.mmsi FROM boat b NATURAL LEFT OUTER JOIN boat_vhf v join person p on b.id_owner = p.id AND b.iso_code_owner = p.iso_code ;'
    cursor.execute(sql)
    result = cursor.fetchall()
    num = len(result)
    

    # Create and Format Table
    print('<table border="0" cellspacing="10">')
    print('<tr>')
    # Table Header
    boat_header = ['Name','Year','Boat CNI','Boat ISO Code','Owner Name','Owner ID','Owner ISO Code','MMSI']
    for col_name in boat_header:
        print('<th>%s</th>'%col_name)
    print('</tr>')
    # Table Rows
    for row in result:
        print('<tr>')
        for value in row:
            # The string has the {}, the variables inside format() will replace the {}
            print('<td><center>{} </center></td>'.format(value))
        print('<td><a href="delete_boat.cgi?boat_cni={}&boat_iso_code={}">Remove Boat</a></td>'.format(row[2],row[3])) #Scanf
        print('</tr>')
    print('</table>')

    
    # Page Header 2
    print('<h3>New Boat? Please register here:</h3>')
    # Create Form
    print('<form action="insert_boat.cgi" method="post">')
    print('<p>Boat Name: <input type="text" name="boat_name"/></p>')
    print('<p>Year of Registration: <input type="text" name="boat_year"/></p>')
    print('<p>Country identifier (CNI): <input type="text" name="boat_cni"/></p>')
    # Create and Run SQL Query
    sql = 'SELECT DISTINCT iso_code FROM location;'
    cursor.execute(sql)
    result = cursor.fetchall()

    print('<label for="boat_iso_code">Country of Registration (ISO Code):</label>')
    print('<select name="boat_iso_code" id="boat_iso_code">')
    for iso in result:
        print('<option value={}>{}</option>'.format(iso[0],iso[0]))
    print('</select>')

    print('<br><br>')
   
    sql = 'SELECT id,iso_code,name FROM owner NATURAL JOIN person;'
    cursor.execute(sql)
    result = cursor.fetchall()

    print('<label for="boat_owner">Owner:</label>')
    print('<select name="boat_owner" id="boat_owner">')

    for iso in result:
        print('<option value="{}#@{}">{} ({})</option>'.format(iso[0],iso[1],iso[2],iso[1]))

    print('</select>')
    
    print('<p>Boat MMSI (Optional): <input type="text" name="boat_mmsi"/></p>')
    # Submit and Close form
    print('<p><input type="submit" value="Register Boat"/></p>')
    print('</form>')

    # Connectivity to Home Page
    print('<p> <a href="home.cgi"> < Home Page </a></p>')

    # Closing connection
    cursor.close()
    connection.close()

except Exception as e:
    # Print errors on the webpage if they occur
    print('<p> Status: <b>Something went wrong</b>.')    
    print('<p> Description: {} </p>'.format(e))
    # Connectivity to Home Page
    print('<p> <a href="home.cgi"> < Home Page </a></p>')

finally:
    if connection is not None:
        connection.close()

# Close HTML
print('</body>')
print('</html>')