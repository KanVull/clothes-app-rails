class AddResetPasswordToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :reset_password_digest, :string
    add_column :users, :reset_password_sent_at, :datetime
  end
end
