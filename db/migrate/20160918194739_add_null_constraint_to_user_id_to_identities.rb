class AddNullConstraintToUserIdToIdentities < ActiveRecord::Migration
  def change
    change_column :identities, :user_id, :integer, null: false
  end
end
