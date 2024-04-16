require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "validations" do
    let(:user2) { build(:user) }

    it "is not valid with not unique email" do
      user2.email = user.email
      expect(user2).not_to be_valid
    end
  end

  describe "instance methods" do
    it "#admin? returns true if user is an admin" do
      user.update(is_admin: true)
      expect(user.admin?).to be true
    end

    it "#activated? returns true if user is activated" do
      user.update(activated: true)
      expect(user.activated?).to be true
    end

    it "#activate activates the user" do
      user.activate
      expect(user.activated?).to be true
    end

    it "#authenticated? returns true if the token matches the digest" do
      expect(user.authenticated?(:activation, user.activation_token)).to be true
    end

    it "#update_activation_digest updates the activation digest" do
      old_digest = user.activation_digest
      user.update_activation_digest
      expect(user.activation_digest).not_to eq(old_digest)
    end

    it "#send_activation_email sends activation email" do
      expect { user.send_activation_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
