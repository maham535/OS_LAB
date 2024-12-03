#!/bin/bash
# Color variables
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BOLD_YELLOW="\e[1;33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESET="\e[0m"

rockPaperScissorsScore=0
numberGuessingGameScore=0
ticTacToeScore=0


# Rock Paper Scissors Game
rockPaperScissors() {
    local user
    local cpu
    local computer=0
    local users=0
    local a=0

    echo " __"
    echo " Rock Paper Scissors Shoot! "
    echo " __"
    echo " 1) Rock "
    echo " 2) Paper "
    echo " 3) Scissors "
    echo " ***"

    while [ $a -lt 3 ]; do
        sleep 1
        echo ""
        echo " Choose from above to play the Game."
        read -p "Enter your choice: " user

        if [ $user -gt 3 ]; then
            echo "Invalid choice. Please select a number according to the menu."
            continue
        fi

        case $user in
            1) echo " You chose Rock ";;
            2) echo " You chose Paper ";;
            3) echo " You chose Scissors ";;
        esac

        cpu=$((RANDOM % 3 + 1))

        case $cpu in
            1) echo " CPU chose Rock ";;
            2) echo " CPU chose Paper ";;
            3) echo " CPU chose Scissors ";;
        esac

        if [ $user -eq $cpu ]; then
            echo " It's a Tie "
        elif [ $user -eq 1 ] && [ $cpu -eq 2 ]; then
            echo " You Lose "
            computer=$((computer+1))
        elif [ $user -eq 1 ] && [ $cpu -eq 3 ]; then
            echo " You Win "
            users=$((users+1))
            rockPaperScissorsScore=$((rockPaperScissorsScore+1))
        elif [ $user -eq 2 ] && [ $cpu -eq 1 ]; then
            echo " You Win "
            users=$((users+1))
            rockPaperScissorsScore=$((rockPaperScissorsScore+1))
        elif [ $user -eq 2 ] && [ $cpu -eq 3 ]; then
            echo " You Lose "
            computer=$((computer+1))
        elif [ $user -eq 3 ] && [ $cpu -eq 1 ]; then
            echo " You Lose "
            computer=$((computer+1))
        elif [ $user -eq 3 ] && [ $cpu -eq 2 ]; then
            echo " You Win "
            users=$((users+1))
            rockPaperScissorsScore=$((rockPaperScissorsScore+1))
        fi
        a=$((a+1))
    done
    echo "Final Scores:"
    echo "You: $users"
    echo "Computer: $computer"
    sleep 5

}

initialize_board() {
    board=("1" "2" "3" "4" "5" "6" "7" "8" "9")
}

# Function to print the Tic Tac Toe board
print_board() {
    echo " ${board[0]} | ${board[1]} | ${board[2]} "
    echo "---|---|---"
    echo " ${board[3]} | ${board[4]} | ${board[5]} "
    echo "---|---|---"
    echo " ${board[6]} | ${board[7]} | ${board[8]} "
}

# Function to check for a win
check_win() {
    local win_conditions=( "0 1 2" "3 4 5" "6 7 8" "0 3 6" "1 4 7" "2 5 8" "0 4 8" "2 4 6" )
    for condition in "${win_conditions[@]}"; do
        set -- $condition
        if [ "${board[$1]}" == "${board[$2]}" ] && [ "${board[$2]}" == "${board[$3]}" ]; then
            return 0
        fi
    done
    return 1
}

# Function to check for a draw
check_draw() {
    for cell in "${board[@]}"; do
        if [[ "$cell" != "X" && "$cell" != "O" ]]; then
            return 1
        fi
    done
    return 0
}

# Function to play the Tic Tac Toe game
ticTacToe() {
    local currentPlayer="X"
    local move
    local gameOver=0
    initialize_board
    while [ $gameOver -eq 0 ]; do
        clear
        print_board
        echo "Player $currentPlayer's turn."
        read -p "Enter your move (1-9): " move
        
        if [[ ${board[$move-1]} == "X" || ${board[$move-1]} == "O" || $move -lt 1 || $move -gt 9 ]]; then
            echo "Invalid move. Try again."
            continue
        fi
        
        board[$move-1]=$currentPlayer

        if check_win; then
            clear
            print_board
            echo "Player $currentPlayer wins!"
            if [ "$currentPlayer" == "X" ]; then
                ticTacToeScore=$((ticTacToeScore+1))
            fi
            gameOver=1
            sleep 5  # Pause to allow time to see the result
            break
        elif check_draw; then
            clear
            print_board
            echo "It's a draw!"
            gameOver=1
            sleep 5  # Pause to allow time to see the result
            break
        fi
        
        # Switch player
        if [ "$currentPlayer" == "X" ]; then
            currentPlayer="O"
        else
            currentPlayer="X"
        fi
    done
}

# Number Guessing Game
numberGuessingGame() {
    local evenNumber
    local divide

    echo " Think any number: "
    sleep 2

    echo " Add your friend's number (same as yours): "
    sleep 2

    read -p " Enter any even number to add: " evenNumber

    echo " Divide your total number by 2"
    sleep 2

    echo " Now return your friend's number back."
    sleep 2

    divide=$((evenNumber / 2))

    echo " Your remaining number is..."
    clear
    tput setaf 3
    echo -e "\n\n\t\t\t$divide"
    tput sgr0
    sleep 5

}

# Game Descriptions
descriptions() {
    clear
    tput setaf 15
    echo "Games Descriptions"
    sleep 1

    echo -e "\n\t\t\tGame 1: Rock Paper Scissors Game"
    sleep 1
    echo "1) You play with the computer."
    echo "2) Choose Rock, Paper, or Scissors."
    echo "3) The computer will also choose."
    echo "4) The rules are: Rock breaks Scissors, Scissors cut Paper, Paper wraps Rock."
    sleep 2

    echo -e "\n\t\t\tGame 2: Number Guessing Game"
    sleep 1
    echo "1) Think of any number."
    echo "2) Add your friend's number."
    echo "3) Enter any even number to add."
    echo "4) Divide the total by 2."
    echo "5) Return your friend's number."
    echo "6) The remaining number is your original number."
    sleep 2

    echo -e "\n\t\t\tGame 3: Tic Tac Toe Game"
    sleep 1
    echo "1) The game is played on a 3x3 grid."
    echo "2) Two players take turns to mark X or O."
    echo "3) The first player to line up 3 marks horizontally, vertically, or diagonally wins."
    echo "4) If all spaces are filled without a winner, the game is a draw."
    sleep 2

    echo -e "\n\t\t\tGame 4: Snake Game"
    sleep 1
    echo "1) You control a snake in a grid."
    echo "2) The snake grows in length as it eats food."
    echo "3) Avoid the snake hitting the walls or itself."
    echo "4) The game ends if the snake collides with the wall or itself."
    sleep 2

    echo -e "\n\t\t\tGame 5: Adventure Game"
    sleep 1
    echo "1) Explore a virtual world as a character."
    echo "2) Solve puzzles and challenges to progress."
    echo "3) Interact with various objects and characters."
    echo "4) The game ends when you complete all tasks or fail to solve critical challenges."
    sleep 2

    echo -e "\n\t\t\tGame 6: Typing Test Game"
    sleep 1
    echo "1) Type a randomly selected sentence as quickly and accurately as possible."
    echo "2) The game measures your typing speed (words per minute) and accuracy."
    echo "3) The game ends when you complete the typing challenge."
    sleep 2
}


# Function to show all games score
allGamesScore() {
    echo "All Games Scores:"
    echo "Rock Paper Scissors Score: $rockPaperScissorsScore"
    echo "Number Guessing Game Score: $numberGuessingGameScore"
    echo "Tic Tac Toe Game Winner: Player $ticTacToeScore"
 
    sleep 5
}

# Function to exit the game
exitGame() {
    echo "Exit"
    sleep 2  
    exit 0
}
start_adventure() {
    echo "Welcome to the Adventure Game!"
    echo "You find yourself in a dark forest. Do you go 'left' or 'right'?"
    read direction
    case $direction in
        left)
            river_encounter
            ;;
        right)
            clearing_encounter
            ;;
        *)
            invalid_choice
            ;;
    esac
}

# Function: Handle the river encounter
river_encounter() {
    echo "You walk down a path and encounter a river. Do you 'swim' across or 'walk' along the bank?"
    read choice
    case $choice in
        swim)
            echo "The current is strong! You get swept away and end up back where you started."
            sleep 3  # Pause to allow reading the result
            ;;
        walk)
            echo "You find a bridge further down the river and safely cross. You win!"
            sleep 3  # Pause to allow reading the result
            ;;
        *)
            invalid_choice
            ;;
    esac
}

# Function: Handle the clearing encounter
clearing_encounter() {
    echo "You enter a clearing with a cave. Do you 'enter' the cave or 'climb' a nearby tree to get a better view?"
    read choice
    case $choice in
        enter)
            echo "The cave is dark and you stumble over a treasure chest. You found treasure! You win!"
            sleep 3  # Pause to allow reading the result
            ;;
        climb)
            echo "You climb the tree and spot a village nearby. You make it out safely. You win!"
            sleep 3  # Pause to allow reading the result
            ;;
        *)
            invalid_choice
            ;;
    esac
}

# Function: Handle invalid choices
invalid_choice() {
    echo "Invalid choice. You wander aimlessly and get lost in the forest."
    sleep 3  # Pause to allow reading the result
}



startGame() {
    # Screen dimensions
    SCREEN_WIDTH=40
    SCREEN_HEIGHT=20
    SNAKE_HEAD="O"
    SNAKE_BODY="■"
    FOOD="*"
    EMPTY=" "

    # Initialize game variables
    snake_x=20
    snake_y=10
    snake_length=1
    snake_direction="RIGHT"
    score=0
    game_over=0

    # Define snake's body as an array
    snake_body=()

    # Initialize the food position
    food_x=$((RANDOM % SCREEN_WIDTH))
    food_y=$((RANDOM % SCREEN_HEIGHT))

    # Function to clear the screen only once at start
    clearScreen() {
        echo -e "\033[H\033[J"
    }

    # Function to draw the game board
    drawBoard() {
        # Move cursor to the top to avoid flickering
        echo -e "\033[H"
        # Draw the top border
        for ((i=0; i<SCREEN_WIDTH+2; i++)); do echo -n "#"; done
        echo

        # Draw the game area
        for ((y=0; y<SCREEN_HEIGHT; y++)); do
            echo -n "#"
            for ((x=0; x<SCREEN_WIDTH; x++)); do
                if [[ $x -eq $snake_x && $y -eq $snake_y ]]; then
                    echo -n "$SNAKE_HEAD"
                elif [[ " ${snake_body[@]} " =~ " $x,$y " ]]; then
                    echo -n "$SNAKE_BODY"
                elif [[ $x -eq $food_x && $y -eq $food_y ]]; then
                    echo -n "$FOOD"
                else
                    echo -n "$EMPTY"
                fi
            done
            echo "#"
        done

        # Draw the bottom border
        for ((i=0; i<SCREEN_WIDTH+2; i++)); do echo -n "#"; done
        echo
        echo "Score: $score"
    }

    # Function to handle snake movement and collision
    moveSnake() {
    case $snake_direction in
        "UP")    snake_y=$((snake_y - 1)) ;;
        "DOWN")  snake_y=$((snake_y + 1)) ;;
        "LEFT")  snake_x=$((snake_x - 1)) ;;
        "RIGHT") snake_x=$((snake_x + 1)) ;;
    esac

    # Check for collision with walls (game over if hits wall)
    if ((snake_x < 0 || snake_x >= SCREEN_WIDTH || snake_y < 0 || snake_y >= SCREEN_HEIGHT)); then
        game_over=1
        return
    fi

    # Check for collision with the snake itself
    for part in "${snake_body[@]}"; do
        IFS=',' read -r part_x part_y <<< "$part"
        if [[ $part_x -eq $snake_x && $part_y -eq $snake_y ]]; then
            game_over=1
            return
        fi
    done

    # Add the new head position to the snake body
    snake_body=("$snake_x,$snake_y" "${snake_body[@]}")

    # If the snake eats food, increase length
    if [[ $snake_x -eq $food_x && $snake_y -eq $food_y ]]; then
        score=$((score + 1))
        snake_length=$((snake_length + 1))
        food_x=$((RANDOM % SCREEN_WIDTH))
        food_y=$((RANDOM % SCREEN_HEIGHT))
    else
        # Remove the last part of the snake if not eating food
        snake_body=("${snake_body[@]:0:$snake_length}")
    fi
}

    # Function to get user input
    getInput() {
        read -rsn1 -t 0.1 input
        case $input in
            w|W) snake_direction="UP" ;;
            s|S) snake_direction="DOWN" ;;
            a|A) snake_direction="LEFT" ;;
            d|D) snake_direction="RIGHT" ;;
            q|Q) game_over=1 ;; # Quit the game
        esac
    }

    # Clear the screen initially
    clearScreen

    # Main game loop
    while [ $game_over -eq 0 ]; do
        getInput
        moveSnake
        drawBoard
        sleep 0.1
    done

    clearScreen
    echo "Game Over!"
    echo "Final Score: $score"
}
#!/bin/bash

# Function: Full Typing Speed Test Game
function typing_speed_test() {
    # Display instructions
    echo "Welcome to the Typing Speed Test!"
    echo "You will be shown random sentences or words."
    echo "Your task is to type them as quickly as possible without making any mistakes."
    echo "Press ENTER to start the game!"
    read
    
    # List of sentences for the test
    sentences=("The quick brown fox jumps over the lazy dog"
               "Shell scripting is powerful and easy"
               "Typing speed test is fun"
               "Practice makes perfect")
    
    # Select a random sentence
    random_sentence=${sentences[$RANDOM % ${#sentences[@]}]}
    echo "Type the following sentence as quickly as possible:"
    echo "$random_sentence"
    echo
    
    # Capture start time
    start_time=$SECONDS
    
    # Read user input
    read -p "Start typing: " typed_text
    
    # Calculate time taken
    end_time=$SECONDS
    time_taken=$((end_time - start_time))
    
    # Check for typing accuracy
    if [ "$typed_text" == "$random_sentence" ]; then
        echo "Correct! Well done."
    else
        echo "Oops! There were some mistakes."
    fi
    
    # Calculate typing speed and accuracy
    words=$(echo "$random_sentence" | wc -w)
    wpm=0
    accuracy=0
    
    if [ "$time_taken" -gt 0 ] && [ "$words" -gt 0 ]; then
        # Words per minute calculation
        wpm=$((words * 60 / time_taken))
        
        # Calculate accuracy
        correct_words=0
        for i in $(seq 1 $words); do
            word=$(echo "$random_sentence" | cut -d ' ' -f $i)
            typed_word=$(echo "$typed_text" | cut -d ' ' -f $i)
            if [ "$word" == "$typed_word" ]; then
                correct_words=$((correct_words + 1))
            fi
        done
        accuracy=$((100 * correct_words / words))
    fi
    
    # Display results
    echo "Time Taken: $time_taken seconds"
    echo "Typing Speed: $wpm WPM"
    echo "Accuracy: $accuracy%"
    
    # Pause before returning to the main menu
    echo "Press ENTER to return to the main menu."
    read
}


# Start Word Guessing Game
start_word_guessing_game() {
    # Define months array
    months=("January" "February" "March" "April" "May" "June" "July" "August" "September" "October" "November" "December")

    # Randomly select a month from the array
    answer=${months[$RANDOM % ${#months[@]}]}

    # Convert answer to lowercase for case-insensitive comparison
    answer_lower=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

    # Variables
    foundCount=0
    lives=5
    foundCharIndexes=()

    # Game loop
    while [[ $foundCount -lt ${#answer} && $lives -gt 0 ]]; do
        # Output number of lives
        echo -e "\nYou currently have: $lives lives."

        # Reset foundCount before checking word
        foundCount=0

        # Print current guessed word
        guessedWord=""
        for (( i=0; i<${#answer}; i++ )); do
            if [[ " ${foundCharIndexes[@]} " =~ " $i " ]]; then
                guessedWord="${guessedWord}${answer:$i:1} "
                ((foundCount++))
            else
                guessedWord="${guessedWord}_ "
            fi
        done
        echo -e "\nCurrent Word: $guessedWord"

        # Ask for the user's guess
        read -p "Guess a letter: " guess

        # Convert guess to lowercase for case-insensitivity
        guess=$(echo "$guess" | tr '[:upper:]' '[:lower:]')

        # Validate the input
        if [[ ${#guess} -ne 1 ]]; then
            echo "Please enter a single letter."
            continue
        fi

        # Check if the guessed letter is in the answer
        correctGuess=0
        for (( i=0; i<${#answer}; i++ )); do
            if [[ "${answer_lower:$i:1}" == "$guess" && ! " ${foundCharIndexes[@]} " =~ " $i " ]]; then
                foundCharIndexes+=($i)
                correctGuess=1
            fi
        done

        if [[ $correctGuess -eq 0 ]]; then
            echo "Incorrect guess!"
            ((lives--))
        else
            echo "Good guess!"
        fi
    done

    # Game result
    if [[ $foundCount -eq ${#answer} ]]; then
        echo -e "\nCongratulations! You guessed the word: $answer"
main_menu    else
        echo -e "\nGame Over! The correct word was: $answer"
    fi
}



# Main Menu
main_menu() {
    while true; do
	echo -e "\e[30;47mBlack text on a white background\e[0m"
        clear
        echo -e "${BLUE}\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n${RESET}"
        echo -e "${YELLOW}              EchoMaham Games ${RESET}"
        echo -e "${BLUE}\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n${RESET}"
        echo -e "1 - Game Descriptions (help)"
        echo -e "2 - Play Games"
        echo -e "   - Start Adventure"
        echo -e "   - Rock Paper Scissors"
        echo -e "   - Number Guessing Game"
        echo -e "   - Tic Tac Toe Game"
        echo -e "   - Snake Game"
        echo -e "   - Word Guessing Game"
	echo -e "   - Typing Speed Test"
        echo -e "3 - All games Score"
        echo -e "4 - Exit"
        read -p "Enter your choice: " choice

        case $choice in
            1) descriptions ;;
            2) 
                echo "Which game would you like to play?"
                echo "1) Start Adventure"
                echo "2) Rock Paper Scissors"
                echo "3) Number Guessing Game"
                echo "4) Tic Tac Toe"
                echo "5) Snake Game"
                echo "6) Word Guessing Game"
		echo "7)Typing Speed Test"
                read -p "Enter your choice: " game_choice
                case $game_choice in
                    1) start_adventure ;;
                    2) rockPaperScissors ;;
                    3) numberGuessingGame ;;
                    4) ticTacToe ;;
                    5) startGame ;;
                    6) start_word_guessing_game ;;
		    7)typing_speed_test;;
                    *) echo "Invalid choice. Please try again." ;;
                esac
                ;;
            3) allGamesScore ;;
            4) exitGame ;;
            *) echo "Invalid choice. Please try again." ;;
        esac
    done
}

# Call main_menu to start the game
main_menu
