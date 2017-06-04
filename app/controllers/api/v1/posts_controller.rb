class Api::V1::PostsController < Api::V1::ApiController
  before_action :set_post, only: [:show]
  skip_before_action :authenticate

  def index
    if params[:q].present?
      # Simple way
      # @posts = Post.where((Post.arel_table[:title].matches("%#{params[:q]}%".gsub('"',''))).or(Post.arel_table[:body].matches("%#{params[:q]}%".gsub('"',''))))

      # Ransack Search
      @posts = Post.ransack(params[:q]).result(distinct: true)

      # Using sunsport for searching
      # @res = @posts.search do
      #   fulltext params[:q]
      # end
      # @posts = @res.results
    else
      @posts = Post.all.order(created_at: :desc)
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
