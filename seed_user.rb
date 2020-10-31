require 'bcrypt'
require 'pg'

require_relative 'data_access.rb'

name = 'Tutts'
password_digest = BCrypt::Password.create('Tutts')

sql = "INSERT INTO customer_info (name, password_digest) VALUES ($1, $2);"
run_sql(sql, [name, password_digest])