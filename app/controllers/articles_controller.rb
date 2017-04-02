require 'custom_render_detail.rb'
require 'custom_render_sum.rb'

class ArticlesController < ApplicationController
  def index
    @articles = Article.order(created_at: "DESC")
    @markdown = Redcarpet::Markdown.new(CustomRenderSum)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @article = Article.new
  end

  def create
    @player = current_player
    @article = @player.articles.build article_params
    @article.save

    respond_to do |format|
      format.html do
        if @article.persisted?
          redirect_to @player
        else
          flash[:error] = "Error #{@team_message.errors.full_messages.to_sentence}"
          render 'new'
        end
      end

      format.js
    end
  end

  def show
    @article = Article.find(params[:id])
    @markdown = Redcarpet::Markdown.new(CustomRenderDetail)
    @player = @article.player
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end