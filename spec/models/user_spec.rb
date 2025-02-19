require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = Factorybot.build(:user)  
    end

    it "nameとemail、passwordとpassword_confirmationが存在すれば登録できること" do
      expect(@user).to be_valid
    end

    it "nameが空では登録できないこと" do
      @user.name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")

    end

    it "emailが空では登録できないこと" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")


    end

    it "passwordが空では登録できないこと" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")

    end

    it "passwordが６文字以上であれば登録できること" do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      expect(@user).to be_valid
    end

    it "passwordが５文字以下であれば登録できないこと"
       @user.password = "12345"
       @user.password_confirmation = "12345"
       @user.valid?
       expect(@user.errors.full_messages).to include("Password is too short(minimum is 6 characters)")
    end

    it "passwordとpassword_confirmationが不一致では登録できないこと"
        @user.password = "123456"
        @user.password_confirmation = "1234567"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match password!")
   end

   it "重複したemailが存在する場合登録できないこと"
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
   end



  end
end