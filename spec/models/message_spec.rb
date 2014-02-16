
require 'spec_helper'

describe Message do
    
    let(:user1) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }

    before { @message = user1.outgoing_messages.build(content: "Lore Ipsum", to: user2) }

    subject { @message }

    its(:from) { should eq user1 }
    its(:to) { should eq user2 }

    it "should be valid" do
        expect(@message).to be_valid
    end

    it "should be in the user's outbox" do
        @message.save
        expect(user1.outgoing_messages).to include @message
    end
    
    it "should be in other user's inbox" do
        @message.save
        expect(user2.incoming_messages).to include @message
    end

end