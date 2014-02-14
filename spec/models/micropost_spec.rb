require 'spec_helper'

describe Micropost do
    
    let(:user) { FactoryGirl.create(:user) }
    
    before do
        @micropost = user.microposts.build(content: "Lore Ipsum")
    end

    subject { @micropost }

    it { should respond_to(:content) }
    it { should respond_to(:user_id) }
    it { should respond_to(:user) }
    it { should respond_to(:in_reply_to_user) }
    its(:user) { should eq user }
    

    it {should be_valid }

    describe "when user_id is not present" do
        before { @micropost.user_id = nil }
        it { should_not be_valid }
    end

    describe "with blank content" do
        before { @micropost.content = " " }
        it { should_not be_valid }
    end

    describe "with content that is too long" do 
        before { @micropost.content = "a" * 141 }
        it { should_not be_valid }
    end

    describe "replies" do

        it "should reply to the right user" do
            user1 = FactoryGirl.create(:user, name: "user1")
            user2 = FactoryGirl.create(:user, name: "user2")
            m = user1.microposts.create(content: "@user2 Lore Ipsum")
            expect(m).to be_valid
            expect(m.in_reply_to_user).to eq user2
            expect(user1.feed).to include(m)
            expect(user2.feed).to include(m)
        end

        it "should not reply to himself" do
            user = FactoryGirl.create(:user, name: "user1")
            m = user.microposts.create(content: "@user1 Lore Ipsum")
            expect(m).not_to be_valid
        end
    end
end
