describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  it "should have many videos" do
    t = User.reflect_on_association(:videos)
    expect(t.macro).to match :has_many
  end


end
