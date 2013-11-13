class SampleResource
  def self.primary_key
    'id'
  end

  def self.base_class
    ActiveRecord::Base
  end

  def destroyed?
    false
  end

  def new_record?
    false
  end

  def id
    42
  end

  def [](index)
    'wat'
  end
end