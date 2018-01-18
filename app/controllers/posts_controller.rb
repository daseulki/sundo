class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like_post, :create_comment, :destroy_comment]
  before_action :authenticate_user!, except: [:index, :index2, :show]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(boardtype: params[:type])
    #localhost:3000/posts?type=auction 혹은 /posts?type=rent로 하면 해당 게시글만 보여짐
  end

  def index2
    @posts = Post.where("content LIKE ?", "%#{params["q"]}%")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = Comment.all
    if user_signed_in?
      @like = Like.where(user_id: current_user.id, post_id: @post.id)
    else
      @like = []
    end
  end

  def like_post
  user_like = Like.where(user_id: current_user.id, post_id: @post.id)

  if user_like.count > 0
    user_like.first.destroy
  else
    Like.create(
      user_id: current_user.id,
      post_id: @post.id
    )
  end
  @like = @post.likes.count
end

  # GET /posts/new
  def new
    @post = Post.new
  end

  def create_comment

    @comment = Comment.create(
      user_id: current_user.id,
      post_id: @post.id,
      content: params[:content]
    )

    puts params[:content]
    redirect_to :back
  end

  def destroy_comment

    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    redirect_to :back

  end
  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

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
    respond_to do |format|
      if @post.update(post_params)
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
      params.require(:post).permit(:boardtype, :title, :content, :postimage)
    end

    def is_post_owner?
      unless @post.user_id == current_user.id

      flash[:alert] = "글 주인만 할 수 있어"
      redirect_to :back

      end
    end


end
