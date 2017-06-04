class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:ajax_oldest_posts, :ajax_newest_posts, :show]

  def ajax_oldest_posts
    @posts = Post.all.order(created_at: :asc)
    render partial: 'posts/list_posts'
  end

  def ajax_newest_posts
    @posts = Post.all.order(created_at: :desc)
    render partial: 'posts/list_posts'
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(user_id: current_user&.id).order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post.body = CGI.unescapeHTML(@post.body)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post.body = CGI.unescapeHTML(@post.body)
  end

  # POST /posts
  # POST /posts.json
  def create
    create_params = post_params
    create_params[:user_id] = current_user.id
    create_params[:body] = CGI.escapeHTML(post_params[:body])
    create_params[:content_filtered] = "#{post_params[:title]} #{ActionController::Base.helpers.strip_tags(post_params[:body])}"
    @post = Post.new(create_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    update_params = post_params
    update_params[:body] = CGI.escapeHTML(update_params[:body])
    update_params[:content_filtered] = "#{post_params[:title]} #{ActionController::Base.helpers.strip_tags(post_params[:body])}"
    respond_to do |format|
      if @post.update(update_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :content_filtered)
    end
end
