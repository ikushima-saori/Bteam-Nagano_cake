class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @address = Address.new
    @addresses = current_customer.addresses.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
   if @address.save
     @addresses = current_customer.addresses.all 
     flash[:notice] = "住所が追加されました。"
    redirect_to addresses_path
   else
    @addresses = current_customer.addresses.all 
    render :index
   end
  end

  def update
    @address = Address.find(params[:id])
   if @address.update(address_params)
     flash[:notice] = "住所が更新されました。"
    redirect_to addresses_path
   else
     render :edit
   end
  end

  def destroy
     @address = Address.find(params[:id])
     @address.destroy
     flash[:notice] = "住所が削除されました。"
     redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end
end
