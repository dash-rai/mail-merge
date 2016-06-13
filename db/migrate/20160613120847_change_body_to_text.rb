class ChangeBodyToText < ActiveRecord::Migration
  def up
    change_column :mail_templates, :body, :text
  end

  def down
    change_column :mail_templates, :body, :string
  end
end
