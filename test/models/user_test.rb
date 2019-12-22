require 'test_helper'
require 'faker'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(
      name: Faker::Name.name,
      email: Faker::Internet.email, 
      phone_number: Faker::PhoneNumber.phone_number,
      )
  end
  # A valid user should be saved
  test "should be valid" do
    assert @user.valid?
  end
  # name must be present
  test "should not save the user without a user name" do
    @user.name = ""
    assert_not @user.valid?, "User was saved without a Name"
  end
  # name should only be saved when it is less than 50 char
  test "should not save a name that is longer than 50 characters" do
    @user.name = "a"*51
    assert_not @user.valid?, "Name is greater than 50 characters long"
  end
  # email must be present
  test "should not save new user without a user email" do
    @user.email = ""
    assert_not @user.valid?, "User was saved without an email"
  end
  # email should be less than 250 characters long
  test "should not save user with email longer than 250 Characters" do
    @user.email = "a"*245 + "example.com"
    assert_not @user.valid?, "Email was saved with string greater than 250 Characters"
  end
  # email must be unique
  test "should not save a user if the email is being used for another user" do
    user_email = Faker::Internet.email
    user_1 = User.new(
      email: user_email,
      name: Faker::Name.name, 
      phone_number: Faker::PhoneNumber.phone_number,
      )
    user_1.save

    user_2 = User.new(
      email: user_email,
      name: Faker::Name.name, 
      phone_number: Faker::PhoneNumber.phone_number,
      )
    assert_not user_2.valid?, "Should not save two users under one email address"
  end
  # user will be saved when valid email address is entered 
  test "email should accept correct format" do
    valid_emails = %w[simple@example.com very.common@example.com disposable.style.email.with+symbol@example.com other.email-with-hyphen@example.com fully-qualified-domain@example.com user.name+tag+sorting@example.com]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email.inspect} should be vaild"
    end
  end
  # user should not me save when email is an invalid formatt
   test "email should not accept incorrect format" do
    invalid_emails = %w[Abc.example.com A@b@c@example.com]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_emails.inspect} should be invalid"
    end
  end

  
end
