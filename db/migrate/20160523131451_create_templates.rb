class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :from
      t.string :to
      t.string :subject
      t.string :body
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
