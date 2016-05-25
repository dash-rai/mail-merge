class CreateMailTemplates < ActiveRecord::Migration
  def change
    create_table :mail_templates do |t|
      t.string :from
      t.string :to
      t.string :subject
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
