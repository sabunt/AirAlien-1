class ChangeColumnNameToContent < ActiveRecord::Migration
  def change
  	rename_column :messages, :content_text, :content

  end
end
