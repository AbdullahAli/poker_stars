require 'active_model'

class Response
  include ActiveModel::Model

  attr_accessor :status, :value

  def initialize(opts_array)
    self.status = opts_array[0]
    self.value = opts_array[1]
  end

  def ok?
    self.status
  end
end
