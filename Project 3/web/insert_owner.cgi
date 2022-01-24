#!/usr/bin/python3
import psycopg2, cgi
import login

form = cgi.FieldStorage()

#getvalue uses the names from the form in previous page
owner_id = form.getvalue('owner_id')
owner_iso_code = form.getvalue('owner_iso_code')
owner_birthdate = form.getvalue('owner_birthdate')
owner_name = form.getvalue('owner_name')

print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project 3 - Owner </title>')
print('</head>')
print('<body>')
connection = None
try:

    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    # Making query
    sql = 'SELECT check_person(%s,%s);'
    data = (owner_id,owner_iso_code)
    cursor.execute(sql,data)
    result = cursor.fetchall()
    num = len(result)

    sql = 'INSERT INTO owner VALUES (%s,%s,%s);'
    data = (owner_id, owner_iso_code,owner_birthdate)
    print('<p>Query Executed: {}</p>'.format(sql % data))

    if num == 1 and result[0][0] == True: # Execute if valid operation

        cursor.execute(sql, data)
        connection.commit()
   
        print('<p>Status: Completed Sucessfully </p>')

    elif owner_name != None:

        sql = 'INSERT INTO person VALUES (%s,%s,%s);'
        data = (owner_id, owner_name, owner_iso_code)
        print('<p>Query Executed: {}</p>'.format(sql % data))
        cursor.execute(sql, data)
        connection.commit()

        sql = 'INSERT INTO owner VALUES (%s,%s,%s);'
        data = (owner_id, owner_iso_code,owner_birthdate)

        print('<p>Query Executed: {}</p>'.format(sql % data))
        cursor.execute(sql, data)
        connection.commit()
   
        print('<p>Status: Completed Sucessfully </p>')
        

    else :
        print('<p> Status: Failed - There is no person registered with credentials: {} , {} .    Please fill the information below </p>'.format(owner_id,owner_iso_code))
        print('<form action="insert_owner.cgi" method="post">')
        print('<p><input type="hidden" name="owner_id" value="{}"/></p>'.format(owner_id))
        print('<p> Name: <input type="text" name="owner_name"/></p>')
        print('<p><input type="hidden" name="owner_iso_code" value="{}"/></p>'.format(owner_iso_code))
        print('<p><input type="hidden" name="owner_birthdate" value="{}"/></p>'.format(owner_birthdate))
        
        print('<p><input type="submit" value="Register Person"/></p>')
        print('</form>')


    print('<td><a href="owner.cgi"> < Go Back! </a></td>')
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