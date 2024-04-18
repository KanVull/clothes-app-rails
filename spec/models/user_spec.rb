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

    it "#send_password_reset_email sends password recovery email" do
      user.create_reset_password_digest
      expect { user.send_password_reset_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe '#create_reset_password_digest' do
    it 'should set reset_token, reset_password_digest, and reset_password_sent_at' do
      user.create_reset_password_digest
      expect(user.reset_token).to_not be_nil
      expect(user.reset_password_digest).to_not be_nil
      expect(user.reset_password_sent_at).to_not be_nil
    end
  end

  describe '#password_reset_expired?' do
    it 'should return true if reset_password_sent_at is older than 2 hours' do
      user.reset_password_sent_at = 3.hours.ago
      expect(user.password_reset_expired?).to eq(true)
    end

    it 'should return false if reset_password_sent_at is within 2 hours' do
      user.reset_password_sent_at = 1.hour.ago
      expect(user.password_reset_expired?).to eq(false)
    end
  end
end
