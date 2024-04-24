class BoardPolicy
  attr_reader :user, :board

  def initialize(user, board)
    @user = user
    @board = board
  end

  def update?
    user.admin? || board.user == @user
  end
end
