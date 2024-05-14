RSpec.describe "Factories" do
  describe "Messages" do
    it "has a valid factory" do
      message = FactoryBot.build(:message)
      expect(message).to be_valid
    end
  end
end
