p_score = 0
c_score = 0
choice = ''

NEW_LINE = "\n".freeze

CHOICES = %w(rock paper scissors lizard spock).freeze

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
  prompt 'You are the grand winner!' if p_score == 5
  prompt 'Computer is the grand winner!' if c_score == 5
end

prompt 'Welcome to the RPSLS Game'
prompt 'Score 5 wins to be the Grand Winner!' + (NEW_LINE * 2)
loop do
  loop do
    prompt "Choose either #{CHOICES.join(', ')}"
    prompt "( You can also use shortcuts- #{CHOICES_SHORTCUT.keys.join(', ')})"
    choice = gets.chomp

    break if CHOICES.include?(choice)
    break if CHOICES_SHORTCUT.keys.include?(choice)
    prompt "That's not a valid choice."
  end

  choice = shortcut(choice).join('') if CHOICES_SHORTCUT.keys.include?(choice)

  computer_choice = CHOICES.sample

  puts "You chose #{choice}; computer chose #{computer_choice}"

  display_result(choice, computer_choice)

  p_score = p_score.to_i + 1 if win?(choice, computer_choice)
  c_score = c_score.to_i + 1 if win?(computer_choice, choice)

  score_prompt(p_score, c_score)
  prompt NEW_LINE

  if (p_score == 5) || (c_score == 5)
    prompt 'Do you want to play again? (Y for yes, all else no).'
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end

  (p_score = 0) && (c_score = 0) if (p_score == 5) || (c_score == 5)
end

prompt 'Thank you for playing, goodbye!'
