require "digest"

module CryptoHash
  STATE = 32
  @disco_buf = [].fill(0, 0, STATE)
  @ds = @disco_buf.pack("q")

  def self.pr()

  end

  def self.discohash()

  end
end

str = "Find"
a = Digest::MD5.digest str

puts a.inspect

