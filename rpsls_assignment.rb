p_score = 0
c_score = 0
choice = ''
answer = ''

NEW_LINE = "\n".freeze
CHOICES = %w(rock paper scissors lizard spock).freeze
VALID_ANSWER = %w(yes y no n).freeze
ROUNDS = 5

CHOICES_SHORTCUT = {
  'r' => ['rock'],
  'p' => ['paper'],
  'sc' => ['scissors'],
  'l' => ['lizard'],
  'sp' => ['spock']
}.freeze

WINNING_CHOICES = {
  'rock' => %w(scissors lizard),
  'paper' => %w(rock spock),
  'scissors' => %w(paper lizard),
  'lizard' => %w(spock paper),
  'spock' => %w(rock scissors)
}.freeze

def shortcut(characters)
  CHOICES_SHORTCUT[characters]
end

def prompt(message)
  puts message.to_s
end

def win?(first, second)
  WINNING_CHOICES[first].include?(second)
end

def display_initial_message
  prompt 'Welcome to the RPSLS Game'
  prompt 'Score ROUNDS wins to be the Grand Winner!' + (NEW_LINE * 2)
end

def display_result(player, computer)
  if win?(player, computer)
    prompt 'You won!'
  elsif win?(computer, player)
    prompt 'You lose!'
  else
    prompt 'It\'s a tie!'
  end
end

def score_prompt(p_score, c_score)
  prompt "Your score is #{p_score}. Computer score is #{c_score}"
  prompt 'You are the grand winner!' if p_score == ROUNDS
  prompt 'Computer is the grand winner!' if c_score == ROUNDS
end

def retrieve_move_input(input)
  loop do
    prompt "Choose either #{CHOICES.join(', ')}"
    prompt "( You can also use shortcuts- #{CHOICES_SHORTCUT.keys.join(', ')})"
    input = gets.downcase.chomp

    break if CHOICES.include?(input)
    break if CHOICES_SHORTCUT.keys.include?(input)
    prompt "That's not a valid choice."
  end
  input
end

def match_ended?(p_score, c_score)
  (p_score == ROUNDS) || (c_score == ROUNDS)
end

display_initial_message
loop do
  choice = retrieve_move_input(choice)

  choice = shortcut(choice).join('') if CHOICES_SHORTCUT.keys.include?(choice)

  computer_choice = CHOICES.sample

  puts "You chose #{choice}; computer chose #{computer_choice}"

  display_result(choice, computer_choice)

  p_score = p_score.to_i + 1 if win?(choice, computer_choice)
  c_score = c_score.to_i + 1 if win?(computer_choice, choice)

  score_prompt(p_score, c_score)
  prompt NEW_LINE

  if match_ended?(p_score, c_score)
    prompt 'Do you want to play again? (Y for yes, all else no).'
    loop do
      answer = gets.downcase.chomp
      break if VALID_ANSWER.include?(answer)
      puts 'Invalid answer. Enter Yes,No,Y,N'
    end
    break unless answer.downcase.start_with?('y')
    system('clear') || system('cls')
  end

  (p_score = 0) && (c_score = 0) if match_ended?(p_score, c_score)
end

prompt 'Thank you for playing, goodbye!'
