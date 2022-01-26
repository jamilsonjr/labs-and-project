#!/usr/bin/python3
import psycopg2, cgi
import login

# Load Attributes
form = cgi.FieldStorage()
owner_id = form.getvalue('owner_id')
owner_iso_code = form.getvalue('owner_iso_code')
owner_birthdate = form.getvalue('owner_birthdate')
owner_name = form.getvalue('owner_name')

# Initizalize HTML
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

    # Page Header
    print('<h3>SQL LOG - INSERT OWNER:</h3>')


    sql = 'START TRANSACTION;'
    print('<p>Query: {}.</p>'.format(sql))
    cursor.execute(sql)
    connection.commit()
    print('<p>Status: Transaction Open.</p>')

    # Create and Run SQL Query
    sql = 'SELECT check_person(%s,%s);'
    data = (owner_id,owner_iso_code)
    print('<p>Query: {}</p>'.format(sql % data))
    cursor.execute(sql,data)
    result = cursor.fetchall()
    print('<p>Status: Query completed sucessfully. </p>')
    num = len(result)

    sql = 'INSERT INTO owner VALUES (%s,%s,%s);'
    data = (owner_id, owner_iso_code,owner_birthdate)
    print('<p>Query: {}.</p>'.format(sql % data))

    if num == 1 and result[0][0] == True: # Execute if valid operation

        cursor.execute(sql, data)
        connection.commit()
   
        print('<p>Status: Insert completed sucessfully.</p>')

    elif owner_name != None:
        print('<p>Status: Insert aborted...</p>')

        sql = 'INSERT INTO person VALUES (%s,%s,%s);'
        data = (owner_id, owner_name, owner_iso_code)
        print('<p>Query: {}.</p>'.format(sql % data))
        cursor.execute(sql, data)
        connection.commit()
        print('<p>Status: Insert completed sucessfully.</p>')

        sql = 'INSERT INTO owner VALUES (%s,%s,%s);'
        data = (owner_id, owner_iso_code,owner_birthdate)

        print('<p>Query: {}.</p>'.format(sql % data))
        cursor.execute(sql, data)
        connection.commit()
   
        print('<p>Status: Insert completed sucessfully. </p>')

        sql = 'COMMIT;'
        print('<p>Query: {}.</p>'.format(sql))
        cursor.execute(sql)
        connection.commit()
        print('<p>Status: Transaction concluded sucessfully.</p>')
        

    else :
        # Person not Registered
        print('<p> Status: <b>Insert Failed</b>. There is no person registered with credentials: {} , {}.'.format(owner_id,owner_iso_code)) 

        sql = 'ROLLBACK;'
        print('<p>Query: <b>{}</b>.</p>'.format(sql))
        cursor.execute(sql)
        connection.commit()
        print('<p> Status: Transaction <b>cancelled</b> sucessfully.')  

        print('<p>Hint: Please fill the information below. </p>')
        
        print('<h3>Register new Person</h3>')

        print('<form action="insert_owner.cgi" method="post">')
        print('<p><input type="hidden" name="owner_id" value="{}"/></p>'.format(owner_id))
        print('<p> Name: <input type="text" name="owner_name"/></p>')
        print('<p><input type="hidden" name="owner_iso_code" value="{}"/></p>'.format(owner_iso_code))
        print('<p><input type="hidden" name="owner_birthdate" value="{}"/></p>'.format(owner_birthdate))
        # Submite and Close Form
        print('<p><input type="submit" value="Register Person"/></p>')
        print('</form>')

    # Connectivity to Page - Owner
    print('<td><a href="owner.cgi"> < List of Owners </a></td>')
    
    # Closing connection
    cursor.close()
    connection.close()

except Exception as e:
    # Print errors on the webpage if they occur
    print('<p> Status: <b>Insert Failed</b>.')    
    print('<p> Description: <b>{}</b> </p>'.format(e))
    sql = 'ROLLBACK;'
    print('<p>Query: {}.</p>'.format(sql))
    cursor.execute(sql)
    connection.commit()
    print('<p> Status: Transaction <b>cancelled</b> sucessfully.</p>')  
    print('<td><a href="owner.cgi"> < List of Owners </a></td>')

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