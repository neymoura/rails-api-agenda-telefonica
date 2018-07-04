class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.where("user_id = ?", current_user.id)
    render json: @contacts
  end

  # GET /contacts/1
  def show
    render json: @contact
  end

  # POST /contacts
  def create
    @contact = Contact.new(parse_contact)

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(parse_contact)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
    render json: {:error => "Contato excluído com sucesso!"}, status: :unprocessable_entity
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      
      @contact = Contact.where("id = ? and user_id = ?", params[:id], current_user.id).first()

      if !@contact then
        render json: {:error => "Contato não existe"}, status: :unprocessable_entity
      end

    end

    def parse_contact
      contact = contact_params
      contact[:birth] = Time.at(contact[:birth])
      contact[:user_id] = current_user.id
      contact
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:name, :birth, :email, :phone, :picture)
    end
end
