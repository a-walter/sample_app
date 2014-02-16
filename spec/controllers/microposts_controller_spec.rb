require 'spec_helper'

describe MicropostsController do
    
    describe "Messages" do

        it "filters messages" do
            user1 = FactoryGirl.create(:user, name: "user1")
            user2 = FactoryGirl.create(:user, name: "user2")

            sign_in user1, no_capybara: true

            m = { content: "d @#{user2.name} Lore Ipsum", user_id: user1.id }

            expect { post :create, micropost: m }.not_to change(Micropost, :count)
            expect { post :create, micropost: m }.to change(Message, :count)

            m[:content] = "d @foo Lore Ispum"

            expect { post :create, micropost: m}.not_to change(Micropost, :count)
            expect { post :create, micropost: m}.not_to change(Message, :count)
        end
    end
end