require './lib/caesar_cipher'

describe  '#caesar_cipher' do 

  it "returns each letter in the given string replaced by a letter a given number of positions down the alphabet." do
    expect(caesar_cipher("Hello", 2)).to eql("Jgnnq")
  end

end