class FrequencyStrategy
  def calculate(rent, rent_changes)
    raise NotImplementedError, "You must implement the rent frequency"
  end
end