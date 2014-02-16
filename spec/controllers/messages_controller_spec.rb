require 'spec_helper'

describe MessagesController do

    it "should not delete other users messages" do 
        user1 = FactoryGirl.create(:user)
        user2 = FactoryGirl.create(:user)
        message = user1.outgoing_messages.create(content: "Lore Ipsum", to: user2)

        sign_in user2, no_capybara: true

        expect { delete :destroy, user_id: user1.id, id: message.id }.not_to change(Message, :count)
    end

    it "should delete the users messages" do
        user1 = FactoryGirl.create(:user)
        user2 = FactoryGirl.create(:user)
        message = user1.outgoing_messages.create(content: "Lore Ipsum", to: user2)

        sign_in user1, no_capybara: true

        expect { delete :destroy, user_id: user1.id, id: message.id }.to change(Message, :count).by(-1)
    end 
end
