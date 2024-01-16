class Public::PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = post.post_comments.new(post_comment_params)
    comment.user_id = current_user.id
    comment.save
    redirect_to request.referer
    # 上記３行の別の書き方↓
    # comment = PostComment.new(post_comment_params)
    # post = Post.find(params[:post_id])
    # comment.user_id = current_user.id
    # comment.post_id = post.id

  end

  def destroy
    post = PostComment.find(params[:id])
    post.destroy
    redirect_to request.referer
  end


  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
