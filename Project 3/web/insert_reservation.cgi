#!/usr/bin/python3
import psycopg2, cgi
import login

# Load Attributes
form = cgi.FieldStorage()
boat = form.getvalue('boat')
sailor = form.getvalue('sailor')
start_date = form.getvalue('start_date')
end_date = form.getvalue('end_date')

# Combined attributes translation
if boat != None:
    boat_cni,boat_iso_code = boat.split('#@')
else:
    boat_cni = None
    boat_iso_code = None

if sailor != None:
    sailor_id,sailor_iso_code = sailor.split('#@')
else:
    sailor_id = None
    sailor_iso_code = None

#Initizalize HTML
print('Content-type:text/html\n\n')
print('<html>')
print('<head>')
print('<title>Project 3 - Reservation </title>')
print('</head>')
print('<body>')
connection = None
try:

    # Creating connection
    connection = psycopg2.connect(login.credentials)
    cursor = connection.cursor()
    # Page Header
    print('<h3>SQL LOG - INSERT RESERVATION:</h3>')
    # Create SQL Query
    sql = 'SELECT * FROM schedule where start_date = %s AND end_date = %s;'
    data = (start_date,end_date)
    print('<p>Query: {}.</p>'.format(sql % data))

    # Run SQL Query 
    cursor.execute(sql, data)
    connection.commit()
    print('<p>Status: Query completed sucessfully. </p>')
    result = cursor.fetchall()

    # New Schedule (if necessairy)
    if len(result) == 0:
        sql = 'INSERT INTO schedule VALUES(%s,%s);'
        data = (start_date,end_date)
        print('<p>Query: {}.</p>'.format(sql % data))
        cursor.execute(sql, data)
        connection.commit()
        print('<p>Status: Insert completed sucessfully. </p>')
    
    # Check New Reservation Validity
    sql = 'SELECT check_reservation_web(%s,%s,%s,%s);' #SQL Function (see IC.sql)
    data = (boat_cni,boat_iso_code,start_date,end_date)
    print('<p>Query: {}</p>'.format(sql % data))
    cursor.execute(sql, data)
    connection.commit()
    print('<p>Status: Query completed sucessfully. </p>')
    result = cursor.fetchall()

    # New Reservation
    sql = 'INSERT INTO reservation VALUES (%s,%s,%s,%s,%s,%s);'
    data = (boat_cni,boat_iso_code,sailor_id,sailor_iso_code,start_date,end_date)
    print('<p>Query Executed: {}</p>'.format(sql % data))

    if len(result)==1 and result[0][0] == True:
        cursor.execute(sql, data)
        connection.commit()
        print('<p>Status: Insert completed sucessfully. </p>')
    else:
        print('<p>Status: <b>Insert Failed.</b> Boat already booked for that period.</p>')
        print('<p>Hint: Retry with a different boat or diferent dates.</p>')
   
    # Connectivity to Page - Reservation
    print('<td><a href="reservation.cgi"> < List of Reservations </a></td>')

    # Close Connection
    cursor.close()
    connection.close()


except Exception as e:
    # Print errors on the webpage if they occur
    print('<p> Status: <b>Insert Failed</b>.')    
    print('<p> Description: {} </p>'.format(e))
    # Connectivity to Page - Reservation
    print('<td><a href="reservation.cgi"> < List of Reservations </a></td>')

finally:
    if connection is not None:
        connection.close()

print('</body>')
print('</html>')



# drop type if exists reservation_interval;
# create type reservation_interval as (
#     start_date date,
#     end_date date
# );
# drop function if exists  check_reservation_web(boat_cni varchar, boat_iso_code varchar, start_date date, end_date date);
# create or replace function check_reservation_web(boat_cni varchar(60),boat_iso_code varchar(2),start_date date, end_date date)
# returns bool
# language plpgsql
#   as
# $$
#     declare
#         res_int reservation_interval default null;
#     declare
#         cursor_boat cursor for
#         (select r.start_date,r.end_date
#         from reservation r
#         where r.cni = boat_cni and r.iso_code_boat = boat_iso_code);

#     BEGIN
#         open cursor_boat;

#         Loop -- verifies if the dates intersect
#             fetch cursor_boat into res_int;

#             if res_int is null then
#                 exit;
#             end if;

#             if ((start_date between res_int.start_date and res_int.end_date)
#                 or (end_date between  res_int.start_date and res_int.end_date)
#                 or (start_date <= res_int.start_date and end_date >= res_int.end_date)) then
#                 return false;
#             end if;

#         end loop;
#         close cursor_boat;
#         return true;
#     END
# $$;