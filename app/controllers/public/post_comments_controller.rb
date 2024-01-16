class Public::PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = post.post_comments.new(post_comment_params)
    comment.user_id = current_user.id
    comment.save
    redirect_to request.referer
  end

  def destroy
  end


  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
