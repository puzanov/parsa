class CountLines
  def self.of file
    return %x{wc -l #{file}}.split(" ")[0].to_i
  end
end
