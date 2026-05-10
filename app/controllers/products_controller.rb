class ProductsController < ApplicationController
    def current_user
  User.find_by(id: session[:user_id])
end
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
        session[:user_id] = User.first.id
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to @product
    else
    render :new, status: :unprocessable_entity
    end
  end
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path, notice: "Product deleted successfully"
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :image)
  end
end
