class ApiController < ApplicationController
  class ApiError < ArgumentError ; end
  class ApiKeyError < ApiError ; end

  class MissingApiKeyError < ApiKeyError
    def initialize
      class_name = self.class.name.gsub("ApiController::","")
      msg = class_name
      super(msg)
    end
  end

  class UnrecognizedApiKeyError < ApiKeyError
    #
    # @param [String] api_key
    #
    def initialize(api_key)
      class_name = self.class.name.gsub("ApiController::","")
      msg = "#{class_name} -- '#{api_key}'"
      super(msg)
    end
  end
end
