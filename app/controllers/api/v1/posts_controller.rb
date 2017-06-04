class Api::V1::PostsController < Api::V1::ApiController
  before_action :set_post, only: [:show]
  skip_before_action :authenticate

  def index
    @posts = Post.all.order(created_at: :desc)
    if params[:q].present?
      @res = @posts.search do
        fulltext params[:q]
      end
      @posts = @res.results
    end
    render json: @posts
  end

  def show

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
