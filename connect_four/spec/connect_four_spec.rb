require './lib/connect_four'

# describe Player do

#   player = Player.new
  
#   describe "#initialize" do
#     it "initializes the instance variables for this class."

#     end
#   end

# end

describe ConnectFour do

  game = ConnectFour.new
  
  describe "#insert_token" do
  context "given an integer, 6, when the sixth column contains two tokens"
    it "returns a hash containing the coordinates of the latest token" do
      expect(game.insert_token(6 - 1)).to eql({:col => 5, :row => 2})
    end
  end

end