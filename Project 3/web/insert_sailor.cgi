#!/usr/bin/python3
import psycopg2, cgi
import login

# Load Attributes
form = cgi.FieldStorage()
sailor_id = form.getvalue('sailor_id')
sailor_iso_code = form.getvalue('sailor_iso_code')
sailor_name = form.getvalue('sailor_name')

#Initizalize HTML
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project 3 - Sailor</title>')
print('</head>')
print('<body>')
connection = None
try:

    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()

    # Page Header
    print('<h3>SQL LOG - INSERT SAILOR:</h3>')

    # Create SQL Query
    sql = 'SELECT check_person(%s,%s);' #SQL Function (see IC.sql ot below)
    data = (sailor_id,sailor_iso_code)
    cursor.execute(sql,data)
    result = cursor.fetchall()
    num = len(result)

    # Run SQL Query 
    sql = 'INSERT INTO sailor VALUES (%s,%s);'
    data = (sailor_id, sailor_iso_code)
    print('<p>Query: {}.</p>'.format(sql % data))

    if num == 1 and result[0][0] == True: # Execute if valid operation

        cursor.execute(sql, data)
        connection.commit()
        print('<p>Status: Insert completed sucessfully. </p>')

    elif sailor_name != None:
        print('<p>Status: Insert aborted...</p>')
        sql = 'INSERT INTO person VALUES (%s,%s,%s);'
        data = (sailor_id, sailor_name, sailor_iso_code)
        print('<p>Query: {}.</p>'.format(sql % data))
        cursor.execute(sql, data)
        connection.commit()
        print('<p>Status: Insert completed sucessfully.</p>')

        sql = 'INSERT INTO sailor VALUES (%s,%s);'
        data = (sailor_id, sailor_iso_code)

        print('<p>Query Executed: {}</p>'.format(sql % data))
        cursor.execute(sql, data)
        connection.commit()
   
        print('<p>Status: Insert completed sucessfully.</p>')

    else:
        # Person not Registered
        print('<p> Status: <b>Insert Failed</b>. There is no person registered with credentials: {} , {}.'.format(sailor_id,sailor_iso_code))    
        print('<p>Hint: Please fill the information below. </p>')

        print('<h3>Register new Person</h3>')

        print('<form action="insert_sailor.cgi" method="post">')
        print('<p><input type="hidden" name="sailor_id" value="{}"/></p>'.format(sailor_id))
        print('<p> Name: <input type="text" name="sailor_name"/></p>')
        print('<p><input type="hidden" name="sailor_iso_code" value="{}"/></p>'.format(sailor_iso_code))
        # Submite and Close Form
        print('<p><input type="submit" value="Register Person"/></p>')

    print('<td><a href="sailor.cgi"> < List of Sailors </a></td>')
    
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


# drop function if exists check_person(owner_id varchar, owner_iso_code char);
# create function check_person(owner_id varchar(80),owner_iso_code char(2))
# returns bool
# language plpgsql
#   as
# $$

#     BEGIN
#         If exists (SELECT * FROM person WHERE id = owner_id AND iso_code = owner_iso_code) then
#             return true;
#         else
#             return false;
#         end if;
#     END
# $$;