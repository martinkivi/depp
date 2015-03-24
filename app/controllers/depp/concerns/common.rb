module Depp
  module Common
    extend ActiveSupport::Concern

    private

    def response_ok?
      @data.css('result').each do |x|
        success_codes = %(1000, 1300, 1301)
        return false unless success_codes.include?(x['code'])
      end
      true
    end
  end
end
