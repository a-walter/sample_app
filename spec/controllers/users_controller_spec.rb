require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

    describe "admins" do

        let(:admin) { FactoryGirl.create(:admin) }

        it "should not be able to delete themself" do
            sign_in admin, no_capybara: true
            expect { delete :destroy, id: admin.id }.not_to change(User, :count)
        end
    end
end
