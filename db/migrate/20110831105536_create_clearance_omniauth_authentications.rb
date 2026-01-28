class CreateClearanceOmniauthAuthentications < ActiveRecord::Migration[7.0]
  def change
    create_table :clearance_omniauth_authentications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps
    end

    add_index :clearance_omniauth_authentications, [:provider, :uid], unique: true
  end
end
