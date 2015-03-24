module Depp
  class XmlConsolesController < ApplicationController
    def show; end

    def create
      begin
        @result = current_user.server.request(params[:payload])
      rescue
        @result = 'CONNECTION ERROR - Is the EPP server running?'
      end
      render :show
    end

    def load_xml
      cl_trid = "#{current_user.tag}-#{Time.now.to_i}"
      xml = File.read("public/epp_requests/#{params[:obj]}/#{params[:epp_action]}.xml")
      xml.gsub!('<clTRID>ABC-12345</clTRID>', "<clTRID>#{cl_trid}</clTRID>")
      render text: xml
    end
  end
end
