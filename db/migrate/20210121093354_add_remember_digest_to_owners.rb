class AddRememberDigestToOwners < ActiveRecord::Migration[5.2]
  def change
    add_column :owners, :remember_digest, :string
  end
end
