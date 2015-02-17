class CreateIsearches < ActiveRecord::Migration
  def change
    create_table :isearches do |t|

      t.timestamps null: false
    end
  end
end
