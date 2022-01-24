#!/usr/bin/python3
import psycopg2, cgi
import login

form = cgi.FieldStorage()

#getvalue uses the names from the form in previous page
sailor_id = form.getvalue('sailor_id')
sailor_iso_code = form.getvalue('sailor_iso_code')
sailor_name = form.getvalue('sailor_name')

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project 3 - Sailor </title>')
print('</head>')
print('<body>')
connection = None
try:

    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    # Making query
    sql = 'SELECT check_person(%s,%s);'
    data = (sailor_id,sailor_iso_code)
    cursor.execute(sql,data)
    result = cursor.fetchall()
    num = len(result)

    sql = 'INSERT INTO sailor VALUES (%s,%s);'
    data = (sailor_id, sailor_iso_code)
    print('<p>Query Executed: {}</p>'.format(sql % data))

    if num == 1 and result[0][0] == True: # Execute if valid operation

        # Feed the data to the SQL query as follows to avoid SQL injection
        cursor.execute(sql, data)

        # Commit the update (without this step the database will not change)
        connection.commit()
   
        print('<p>Status: Completed Sucessfully </p>')

    elif sailor_name != None:

        sql = 'INSERT INTO person VALUES (%s,%s,%s);'
        data = (sailor_id, sailor_name, sailor_iso_code)
        print('<p>Query Executed: {}</p>'.format(sql % data))
        cursor.execute(sql, data)
        connection.commit()

        sql = 'INSERT INTO sailor VALUES (%s,%s);'
        data = (sailor_id, sailor_iso_code)

        print('<p>Query Executed: {}</p>'.format(sql % data))
        cursor.execute(sql, data)
        connection.commit()
   
        print('<p>Status: Completed Sucessfully </p>')
    else:
        print('<p> Status: Failed - There is no person registered with credentials: {} , {} .    Please register in Person </p>'.format(sailor_id,sailor_iso_code))
        
        print('<form action="insert_sailor.cgi" method="post">')

        print('<p><input type="hidden" name="sailor_id" value="{}"/></p>'.format(sailor_id))
        print('<p> Name: <input type="text" name="sailor_name"/></p>')
        print('<p><input type="hidden" name="sailor_iso_code" value="{}"/></p>'.format(sailor_iso_code))
        
        print('<p><input type="submit" value="Register Person"/></p>')

    print('<td><a href="sailor.cgi"> < Go Back! </a></td>')
    # Closing connection
    cursor.close()

except Exception as e:
    # Print errors on the webpage if they occur
    print('<h1>An error occurred.</h1>')
    print('<p>{}</p>'.format(e))
    print('<p>{}</p>'.format(e))

finally:
    if connection is not None:
        connection.close()

print('</body>')
print('</html>')