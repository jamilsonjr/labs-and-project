#!/usr/bin/python3

from matplotlib.pyplot import connect
import psycopg2,cgi
import login


#Initizalize HTML
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title> Project 3 - Reservation </title>')
print('</head>')
print('<body>')

connection = None

try:
    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    # Page Header
    print('<h3>List of Reservations</h3>')

    # Create and Run SQL Query
    sql = 'SELECT b.name, b.cni, b.iso_code, p.name, r.id_sailor, r.iso_code_sailor, r.start_date, r.end_date FROM reservation r natural join boat b join person p on r.id_sailor = p.id AND r.iso_code_sailor = p.iso_code;'
    cursor.execute(sql)
    result = cursor.fetchall()
    
    # Create and Format Table
    print('<table border="0" cellspacing="10">')
    print('<tr>')
    # Table Header
    boat_header = ['Boat Name','Boat CNI','Boat ISO Code','Sailor Name','Sailor ID','Sailor ISO Code','Check-In Date','Check-Out Date']
    for col_name in boat_header:
        print('<th>%s</th>'%col_name)
    print('</tr>')
    # Table Rows
    for row in result:
        print('<tr>')
        for value in row:
            print('<td><center>{} </center></td>'.format(value))
        print('<td><a href="delete_reservation.cgi?boat_cni={}&boat_iso_code={}&sailor_id={}&sailor_iso_code={}&start_date={}&end_date={}">Remove Reservation</a></td>'.format(row[1],row[2],row[4],row[5],row[6],row[7])) #Scanf
        print('</tr>')
    print('</table>')

    # Page Header 2
    print('<h3>New Reservation? Please register here:</h3>')
   
    # Create Form
    print('<form action="insert_reservation.cgi" method="post">')
    # Create SQL Query
    sql = 'SELECT cni,iso_code,name FROM boat;'
    cursor.execute(sql)
    result = cursor.fetchall()

    print('<label for="boat">Boat:</label>')
    print('<select name="boat" id="boat">')
    for iso in result:
        print('<option value="{}#@{}">{} ({})</option>'.format(iso[0],iso[1],iso[2],iso[1]))

    print('</select>')
    print('<br><br>')

    sql = 'SELECT id,iso_code,name FROM sailor NATURAL JOIN person;'
    cursor.execute(sql)
    result = cursor.fetchall()

    print('<label for="sailor">Sailor:</label>')
    print('<select name="sailor" id="sailor">')

    for iso in result:
        print('<option value="{}#@{}">{} ({})</option>'.format(iso[0],iso[1],iso[2],iso[1]))

    print('</select>')
    print('<br><br>')

    print('<label for="start_date">Check_In:</label>')
    print('<input type="date" id="start_date" name="start_date">')
    print('<br><br>')
    print('<label for="end_date">Check_Out:</label>')
    print('<input type="date" id="end_date" name="end_date">')

    # Submit and Close form
    print('<p><input type="submit" value="Next"/></p>')
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

