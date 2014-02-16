class Message < ActiveRecord::Base

    validates :from_id, presence: true
    validates :to_id, presence: true
    validates :content, presence: true, length: { maximum: 140 }

    belongs_to :from, class_name: "User"
    belongs_to :to, class_name: "User"

end
