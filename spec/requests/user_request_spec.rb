require 'rails_helper'

RSpec.describe "Users", type: :request do

  RSpec.shared_context 'with multiple companies' do
    let!(:company_1) { create(:company) }
    let!(:company_2) { create(:company) }

    before do
      5.times do
        create(:user, company: company_1)
      end
      5.times do
        create(:user, company: company_2)
      end

      User.by_username("ma").delete_all
      create(:user, username: "matthew")
      create(:user, username: "Max")
      create(:user, username: "umma")
    end
  end

  describe "#index" do
    let(:result) { JSON.parse(response.body) }

    context 'when fetching users by company' do
      include_context 'with multiple companies'

      it 'returns only the users for the specified company' do
        get company_users_path(company_1)

        expect(result.size).to eq(company_1.users.size)
        expect(result.map { |element| element['id'] } ).to eq(company_1.users.ids)
      end
    end

    context 'when filtering users by username' do
      it 'return users that match' do
        get "/users", params: {username: "ma"}

        expect(result.size).to eq(User.by_username("ma").size)
      end
    end
    context 'when fetching all users' do
      include_context 'with multiple companies'

      it 'returns all the users' do

      end
    end
  end
end
