# Import the required libraries
from pymongo import MongoClient
from cassandra.cluster import Cluster

# Create a connection to MongoDB
mongo_client = MongoClient("mongodb://localhost:27017/")
mongo_db = mongo_client["testdb"]
mongo_collection = mongo_db["testcollection"]

# Create a connection to CassandraDB
cluster = Cluster(['127.0.0.1'])
cassandra_session = cluster.connect()
cassandra_session.execute("CREATE KEYSPACE IF NOT EXISTS testkeyspace WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'};")
cassandra_session.set_keyspace('testkeyspace')
cassandra_session.execute("CREATE TABLE IF NOT EXISTS testtable (id uuid PRIMARY KEY, name text, age int);")

# Perform CRUD operations with MongoDB
# Create
mongo_collection.insert_one({"name": "John", "age": 30})
# Read
result = mongo_collection.find_one({"name": "John"})
print(result)
# Update
mongo_collection.update_one({"name": "John"}, {"$set": {"age": 40}})
result = mongo_collection.find_one({"name": "John"})
print(result)
# Delete
mongo_collection.delete_one({"name": "John"})

# Perform CRUD operations with CassandraDB
# Create
cassandra_session.execute("INSERT INTO testtable (id, name, age) VALUES (uuid(), 'John', 30);")
# Read
result = cassandra_session.execute("SELECT * FROM testtable WHERE name='John' ALLOW FILTERING;")
for row in result:
    print(row)
# Update
cassandra_session.execute("UPDATE testtable SET age = 40 WHERE name='John';")
result = cassandra_session.execute("SELECT * FROM testtable WHERE name='John' ALLOW FILTERING;")
for row in result:
    print(row)
# Delete
cassandra_session.execute("DELETE FROM testtable WHERE name='John';")

# Close the connections
mongo_client.close()
cluster.shutdown()
