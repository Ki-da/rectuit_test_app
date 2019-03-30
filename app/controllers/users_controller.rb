class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]



  # GET /users/1
  def show
    if @user != nil
      render json: {
          message: "user details by user id",
          user: @user.comment!='null' ? ({
              user_id: @user.user_id,
              nickname: @user.nickname || @user.user_id
          }) : ({
              user_id: @user.user_id,
              nickname: @user.nickname || @user.user_id,
              comment: @user.comment
          })
      }
    else
      render json: {
          message:  'No user found'
      }
    end

  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: {
          message: "Account successfully created",
          user: @user.comment!='null' ? ({
              user_id: @user.user_id,
              nickname: @user.nickname || @user.user_id
          }) : ({
                        user_id: @user.user_id,
                        nickname: @user.nickname || @user.user_id,
                        comment: @user.comment
                    })
      }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    auths = request.headers[:Authorization].split(':')

    user_id = Base64.decode64(auths[0])
    password = Base64.decode64(auths[1])

    #認証未実装
    @user = User.find_by_id(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:user_id, :password, :nickname, :comment)
  end
end
