class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact =Contact.new(contents: params[:contents])
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      flash[:success] = 'お問い合わせを受け付けました'
      redirect_to root_path
    else
     redirect_to action: "new"
    end
  end

  # def index
  #  @contacts = Contact.all.order(id:"DESC")
  # end

  # def show
  #   @contact=Contact.find(params[:id])
  # end

end


