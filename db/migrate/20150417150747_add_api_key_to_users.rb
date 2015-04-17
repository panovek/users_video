class AddApiKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_key, :string

    User.all.each do |user|
      user.update(api_key: user.generate_api_key) unless user.api_key
    end
  end
end
