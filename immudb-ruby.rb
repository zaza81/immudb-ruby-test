require 'immudb'

immudb = Immudb::Client.new
Immudb::Client.new(
  host: "localhost",
  port: 3322,
  username: "immudb",
  password: "immudb",
  database: "defaultdb",
  timeout: nil
)

immudb.set("hello", "world")
out = immudb.get("hello")
p out

immudb.set("hello", "world2")
history_out = immudb.history("hello")
p history_out


tables = immudb.list_tables
p tables

#immudb.sql_exec("CREATE TABLE cities (id INTEGER, name VARCHAR, PRIMARY KEY id)")
table_des = immudb.describe_table("cities")
p table_des

#immudb.sql_exec("INSERT INTO cities (id, name) VALUES (@id, @name)", {id: 1, name: "Chicago"})
select_out = immudb.sql_query("SELECT * FROM cities WHERE id = @id", {id: 1}).to_a
p select_out

list_db = immudb.list_databases
p list_db


r = Random.new
version = r.rand(3...100) 


immudb.create_database("newdb" + version.to_s )
immudb.use_database("newdb" + version.to_s)
list_db = immudb.list_databases
p list_db


list_users = immudb.list_users
p list_users


immudb.create_user("user" + version.to_s, password: "P@ssw0rd", permission: :read_write, database: "defaultdb")
list_users = immudb.list_users
p list_users

immudb.change_password("user"+ version.to_s , old_password: "P@ssw0rd", new_password: "P@ssw0rd2")
p "password changed"


res_health = immudb.healthy?
p res_health


immudb.clean_index


#immudb.verified_set("say", "me")
#immudb.verified_get("say")