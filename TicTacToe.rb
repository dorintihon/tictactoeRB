class TicTacToe
    def initialize
      @board = Array.new(3) { Array.new(3, ' ') }
      @current_player = 'O'
      @game_ended = false
    end
  
    def play
        until game_over? || @game_ended
          print_board
          switch_player
          player_move
        end
        print_board
        if @game_ended
          puts "Game ended by the player."
        elsif winner?
          puts "Player #{@current_player} wins!"
        else
          puts "It's a draw!"
        end
      end
  
    private
  
    def print_board
      puts " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} "
      puts "---|---|---"
      puts " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} "
      puts "---|---|---"
      puts " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} "
    end
  
    def player_move
      puts "Player #{@current_player}, enter row: "
      input = gets.to_i
      if input > 3 or input < 1
        end_game
      else
        row = input.to_i - 1
        puts "Player #{@current_player}, enter column: "
        col = gets.to_i - 1
        if valid_move?(row, col)
         @board[row][col] = @current_player
        else
            puts "Invalid move. Try again."
            player_move
        end
      end
    end

    def end_game
        puts "Do you want to end game? (Y/N)"
        input = gets.chomp
        if input.downcase == 'y'
          @game_ended = true
        else
          player_move
        end
      end
  
    def valid_move?(row, col)
      row.between?(0, 2) && col.between?(0, 2) && @board[row][col] == ' '
    end
  
    def switch_player
      @current_player = @current_player == 'X' ? 'O' : 'X'
    end
  
    def game_over?
      winner? || draw?
    end
  
    def winner?
      winning_combinations.any? do |combination|
        combination.all? { |row, col| @board[row][col] == @current_player }
      end
    end
  
    def draw?
      @board.flatten.none? { |cell| cell == ' ' }
    end
  
    def winning_combinations
      rows + columns + diagonals
    end
  
    def rows
      @board.each_with_index.map { |row, index| row.each_index.map { |col| [index, col] } }
    end
  
    def columns
      @board.each_index.map { |col| @board.each_index.map { |row| [row, col] } }
    end
  
    def diagonals
      [
        [[0, 0], [1, 1], [2, 2]],
        [[0, 2], [1, 1], [2, 0]]
      ]
    end
  end
  
  game = TicTacToe.new
  game.play
  