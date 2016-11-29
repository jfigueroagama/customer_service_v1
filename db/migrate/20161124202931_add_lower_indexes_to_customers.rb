class AddLowerIndexesToCustomers < ActiveRecord::Migration[5.0]
  # PostgreSQL uses operator classes, the default operator classes
  # uses an exact match to optimize the index. Since we are using
  # like in our search we need a non stndard operator class: varchar_pattern_ops
  def up
    execute %{
      CREATE INDEX
      customers_lower_last_name
      ON
      customers (lower(last_name) varchar_pattern_ops)
    }
    execute %{
      CREATE INDEX
      customers_lower_first_name
      ON
      customers (lower(first_name) varchar_pattern_ops)
    }
    execute %{
      CREATE INDEX
      customers_lower_email
      ON
      customers (lower(email))
    }
  end
  def down
    remove_index :customers, name: 'customers_lower_last_name'
    remove_index :customers, name: 'customers_lower_first_name'
    remove_index :customers, name: 'customers_lower_email'
  end
end
