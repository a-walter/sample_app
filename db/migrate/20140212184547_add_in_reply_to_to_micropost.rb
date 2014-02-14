class AddInReplyToToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :in_reply_to_user_id, :integer
  end
end
