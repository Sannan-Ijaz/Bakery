def run_sql(sql, params = [])
    db = PG.connect(dbname: 'bakersinc')
    results = db.exec_params(sql, params)
    db.close
    return results
  end

  def all_items()
    run_sql('SELECT * FROM inventory;')
  end
  
  def create_item(name, quantity, destination,notes)
    sql = "INSERT INTO inventory (name,quantity, destination, notes) VALUES ($1,$2, $3, $4);"
    run_sql(sql, [name,quantity, destination, notes])
  end 

  

  def delete_item(name)
    sql = "DELETE FROM inventory WHERE name = $1;"
    run_sql(sql, [name])
  end

  def update_item(name, quantity, destination,notes)
    sql = "update inventory set quantity = $1, destination = $2, notes = $3 where name = $4;"
    run_sql(sql, [quantity, destination, notes, name])
  end

  def find_user_by_name(name)
    results = run_sql("select * from users where name = $1;", [name])
    return results[0];
  end

  def create_customer(name, password)
    sql = "INSERT INTO customer_info (name, password_digest) VALUES ($1, $2);"
    password_digest = BCrypt::Password.create('password')
  run_sql(sql, [name, password_digest])
  end 

  def find_customer_by_name(name)
    results = run_sql("select * from customer_info where name = $1;", [name])
    return results[0];
  end

  def display_customer_items(name)
    results = run_sql("select * from inventory where destination = $1;", [name])
    return results[0];
  end
