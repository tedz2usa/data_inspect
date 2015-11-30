
class DataInspect

  def self.version
    '0.0.2'
  end

  def self.hi
    puts "Hi from DataInspect!!"
    return 512
  end


  def self.readfile(filename)
    reader = Reader.new(filename)
    yield reader
  end

end


class Reader

  def initialize(filename)
    @file = File.open(filename, 'rb')
  end

  def each_byte
    offset = 0
    @file.each_byte do |byte|
      yield byte, offset
      offset += 1
    end
  end

  # optional parameter size is the number of bytes to read.
  # returns a string, representing the binary data.
  def next_byte(size=1)
    @file.read(size)
  end

  def atEOS?
    @file.eof?
  end

end