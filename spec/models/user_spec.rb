require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:password)}
  it { should be_valid }
  it { should respond_to :authenticate}

describe 'when password is not present' do
  before {@user.password = @user.password_confirmation = ' '}
  it {should_not be_valid }
end

describe 'when passwords do not match' do 
  before {@user.password_confirmation = 'mismatch'}
  it {should_not be_valid}
end

describe 'when password is equal to nil' do
  before {@user.password_confirmation = nil}
  it { should_not be_valid}
end

 
describe 'return value of authenticate method' do
  before {@user.save}
  let (:found_user) {User.find_by_email(@user.email)}
  describe 'with valid password' do 
    it {should == found_user.authenticate(@user.password)}
  end

  describe 'with invalid password' do
    let (:user_for_invalid_password) {found_user.authenticate('invalidpass')}
    it {should_not == user_for_invalid_password }
    specify { user_for_invalid_password.should be_false }
  end
   
end
end
