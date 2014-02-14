
class Micropost < ActiveRecord::Base
    belongs_to :user
    belongs_to :in_reply_to_user, class_name: "User"

    default_scope -> { order('created_at DESC') }
    
    validates :content, presence: true, length: { maximum: 140 }
    validates :user_id, presence: true

    before_validation { check_for_reply }

    def self.from_users_followed_by(user)
        followed_user_ids = "SELECT followed_id FROM relationships
                             WHERE follower_id = :user_id"
        where("user_id IN (#{followed_user_ids}) OR user_id = :user_id OR in_reply_to_user_id = :user_id", 
            user_id: user)
    end

private

    def check_for_reply
        if content[0] == ?@ 
            name = content.split(/\s/)[0].gsub("-", " ")[1..-1]
            user1 = User.find_by_name(name)
            errors[:base] << "You can't reply yourself" if user1 == user
            errors[:base] << "User #{name} not found" if user1.nil?
            self.in_reply_to_user = user1
        end
    end
end


