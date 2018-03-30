class Array
  def to_penultimate_s()
    string = ""
    self.each_index do |index|
      if index == self.size - 1 && self.size > 1
        string += "and " + self[index].to_s.downcase
      else
        string += self[index].to_s.downcase
        if self.size > 2
          string += ", "
        else
          string += " "
        end
      end
    end
    string += "."

    return string
  end
end