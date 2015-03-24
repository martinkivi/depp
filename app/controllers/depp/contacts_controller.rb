module Depp
  class ContactsController < ApplicationController
    include Common

    before_action :init_epp_contact

    def index
      res = current_user.repp_request('contacts', { page: params[:page] })
      flash.now[:epp_results] = [{ 'code' => res.code, 'msg' => res.message }]
      @response = JSON.parse(res.body).with_indifferent_access
      @contacts    = @response[:contacts]
      @total_pages = @response[:total_pages]
    end

    def new
      @contact = Contact.new
    end

    def show
      @contact = Contact.find_by_id(params[:id])
    end

    def edit
      @contact = Contact.find_by_id(params[:id])
    end

    def create
      @contact = Contact.new(params[:contact])

      if @contact.save
        redirect_to contact_url(@contact.id)
      else
        render 'new'
      end
    end

    def update
      @contact = Contact.new(params[:contact])

      if @contact.update_attributes(params[:contact])
        redirect_to contact_url(@contact.id)
      else
        render 'edit'
      end
    end

    def delete
      @contact = Contact.find_by_id(params[:id])
    end

    def destroy
      @contact = Contact.new(params[:contact])

      if @contact.delete
        redirect_to contacts_url, notice: t(:destroyed)
      else
        render 'delete'
      end
    end

    def check
      @ids = params[:contacts]
      #    if @ids
      #      @contacts = []
      #      @ids.split(',').each do |id|
      #        @contacts << id.strip
      #      end
      #    end
      return unless @ids

      @data = @contact.check(@ids)
      @contacts = Contact.construct_check_hash_from_data(@data)
    end

    private

    def init_epp_contact
      Contact.user = current_user
    end
  end
end
