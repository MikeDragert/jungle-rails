require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validation' do
    context 'can save' do
      it 'saves the user' do
        @user = User.new
        @user.first_name = 'Bilbo'
        @user.last_name = 'Baggins'
        @user.email = 'bilboB@shire.com'
        @user.password = '1234'
        @user.password_confirmation = '1234'

        @user.save!

        expect(@user.first_name).to eq('Bilbo')
        expect(@user.last_name).to eq('Baggins')
        expect(@user.email).to eq('bilboB@shire.com')
        expect(@user.password).to eq('1234')
        expect(@user.password_confirmation).to eq('1234')
        expect(@user.password_digest).to be_present
      end

    end

    context 'validates first_name present' do
      it 'returns an error' do
        @user = User.new
        @user.last_name = 'Baggins'
        @user.email = 'bilboB@shire.com'
        @user.password = '1234'
        @user.password_confirmation = '1234'

        @user.save

        expect(@user.id).not_to be_present
        expect(@user.errors.full_messages.include? "First name can't be blank").to be true
      end
    end

    context 'validates last_name present' do
      it 'returns an error' do
        @user = User.new
        @user.first_name = 'Bilbo'
        @user.email = 'bilboB@shire.com'
        @user.password = '1234'
        @user.password_confirmation = '1234'

        @user.save

        expect(@user.id).not_to be_present
        expect(@user.errors.full_messages.include? "Last name can't be blank").to be true
      end
    end

    context 'validates email present' do
      it 'returns an error' do
        @user = User.new
        @user.first_name = 'Bilbo'
        @user.last_name = 'Baggins'
        @user.password = '1234'
        @user.password_confirmation = '1234'

        @user.save
        expect(@user.id).not_to be_present
        expect(@user.errors.full_messages.include? "Email can't be blank").to be true
      end
    end

    context 'validates password present' do
      it 'returns an error' do
        @user = User.new
        @user.first_name = 'Bilbo'
        @user.last_name = 'Baggins'
        @user.email = 'bilboB@shire.com'
        @user.password_confirmation = '1234'

        @user.save
        expect(@user.id).not_to be_present
        expect(@user.errors.full_messages.include? "Password can't be blank").to be true
      end
    end
  
    context 'validate password minimum length' do
      it 'returns an error' do
        @user = User.new
        @user.first_name = 'Bilbo'
        @user.last_name = 'Baggins'
        @user.email = 'bilboB@shire.com'
        @user.password = '12'
        @user.password_confirmation = '12'

        @user.save

        expect(@user.id).not_to be_present
        expect(@user.errors.full_messages.include? "Password is too short (minimum is 3 characters)").to be true
      end
    end

    context 'validate passwords must match' do
      it 'returns an error' do
        @user = User.new
        @user.first_name = 'Bilbo'
        @user.last_name = 'Baggins'
        @user.email = 'bilboB@shire.com'
        @user.password = '1234'
        @user.password_confirmation = 'NOTMATCH'

        @user.save
        expect(@user.id).not_to be_present
        expect(@user.errors.full_messages.include? "Password confirmation doesn't match Password").to be true
      end
    end

    # todo: need to validate that emails are unique and not case sensitive
  end

  describe '.authenticate_with_credentials' do
    it 'authenticates against a user' do
      @user = User.new
      @user.first_name = 'Bilbo'
      @user.last_name = 'Baggins'
      @user.email = 'bilboB@shire.com'
      @user.password = '1234'
      @user.password_confirmation = '1234'
      
      @user.save

      @user1 = User.authenticate_with_credentials('bilboB@shire.com', '1234')
      expect(@user1.id).to be_present
      expect(@user1.first_name).to eq('Bilbo')
      expect(@user1.last_name).to eq('Baggins')
      expect(@user1.email).to eq('bilboB@shire.com')
    end

    it 'authenticates against a user with different upcase in email' do
      @user = User.new
      @user.first_name = 'Bilbo'
      @user.last_name = 'Baggins'
      @user.email = 'BilboB@Shire.com'
      @user.password = '1234'
      @user.password_confirmation = '1234'
      
      @user.save

      @user1 = User.authenticate_with_credentials('bilBOB@shire.COM', '1234')
      expect(@user1.id).to be_present
      expect(@user1.first_name).to eq('Bilbo')
      expect(@user1.last_name).to eq('Baggins')
      expect(@user1.email).to eq('BilboB@Shire.com')
    end

    it 'does not authenticate with an non-existent email' do
      @user = User.new
      @user.first_name = 'Bilbo'
      @user.last_name = 'Baggins'
      @user.email = 'bilboB@shire.com'
      @user.password = '1234'
      @user.password_confirmation = '1234'
      
      @user.save

      @user1 = User.authenticate_with_credentials('NO.COM', '1234')
      expect(@user1).not_to be_present
    end

    it 'does not authenticate with an invalid password' do
      @user = User.new
      @user.first_name = 'Bilbo'
      @user.last_name = 'Baggins'
      @user.email = 'bilboB@shire.com'
      @user.password = '1234'
      @user.password_confirmation = '1234'
      
      @user.save

      @user1 = User.authenticate_with_credentials('bilboB@shire.com', 'WRONG_PASSWORD')
      expect(@user1).not_to be_present
    end


    it 'authenticates against a user with spaces at start or end of email' do
      @user = User.new
      @user.first_name = 'Bilbo'
      @user.last_name = 'Baggins'
      @user.email = 'bilboB@shire.com'
      @user.password = '1234'
      @user.password_confirmation = '1234'
      
      @user.save

      @user1 = User.authenticate_with_credentials('  bilboB@shire.com     ', '1234')
      expect(@user1.id).to be_present
      expect(@user1.first_name).to eq('Bilbo')
      expect(@user1.last_name).to eq('Baggins')
      expect(@user1.email).to eq('bilboB@shire.com')
    end
    

  end
end
