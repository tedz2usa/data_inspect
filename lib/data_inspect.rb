
class DataInspect

  def self.version
    '0.0.2'
  end


  def self.readfile(filename)
    reader = Reader.new(filename)
    yield reader
  end

end


class Reader

  @@unpack_formats = {
    unsigned_int: {
      1 => { not_applicable: 'C' },
      2 => { big_endian: 'n', little_endian: 'v' },
      4 => { big_endian: 'N', little_endian: 'V' }
    },

    signed_int: {
      1 => { not_applicable: 'c' }
    },

    ieee_single_precision_float: {
      4 => { big_endian: 'g', little_endian: 'e' }
    },

    ieee_double_precision_float: {
      8 => { big_endian: 'G', little_endian: 'E' }
    }

  }

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

  def next_unsigned_int(size=1, byte_order=:not_applicable)
    unpack_format = format(:unsigned_int, size, byte_order)
    unpack(size, unpack_format)
  end

  # Ruby doesn't do this for us automatically so we
  # have to add our own code (UnsignedToSignedInteger class).
  def next_signed_int(size, byte_order)
    unsigned_value = next_unsigned_int(size, byte_order)
    UnsignedToSignedInteger.toSignedInteger(unsigned_value, size)
  end
 
  # Next IEEE single-precision floating point number
  # (4 bytes)
  def next_ieee_single_precision_float(byte_order)
    size = 4
    unpack_format = format(:ieee_single_precision_float, size, byte_order)
    unpack(size, unpack_format)
  end


  # Next IEEE double-precision floating point number
  # (8 bytes)
  def next_ieee_double_precision_float(byte_order)
    size = 8
    unpack_format = format(:ieee_double_precision_float, size, byte_order)
    unpack(size, unpack_format)
  end

  # If the file is at the end of stream.
  def atEOS?
    @file.eof?
  end

  # Seek to a given offset in the file.
  def seek(offset)
    @file.seek(offset)
  end

  private

  # returns the String.unpack format string given the 
  #   parameter details (data type, size, and byte order).
  # byte_order is not required when size (bytes) is 1.
  # size defaults to 1.
  def format(type, size=1, byte_order=:not_applicable)
    @@unpack_formats[type][size][byte_order]
  end

  # Consumes 'size' bytes from the file,
  # uses String.unpack() to interpret that data,
  # using the given unpack format string.
  def unpack(size, unpack_format)
    @file.read(size).unpack(unpack_format)[0]
  end

end

class UnsignedToSignedInteger

  # Size is in bytes, and should be 1, 2 or 4.
  def self.toSignedInteger(unsigned_value, size)
    subtrahend = 2 ** (size * 8)

    puts "subtrahend is #{subtrahend}."

    max_value = 2 ** (size * 8 - 1) - 1
    puts "max value is #{max_value}"

    result = unsigned_value
    result -= subtrahend if (unsigned_value > max_value)

    return result
  end

end

