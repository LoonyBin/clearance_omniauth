class CreateClearanceOmniauthAuthentications < ActiveRecord::Migration
  def change
    create_table :clearance_omniauth_authentications do |t|
      t.references :user
      t.string :provider
      t.string :uid

      t.timestamps
    end
    add_index :clearance_omniauth_authentications, :user_id
  end
end
