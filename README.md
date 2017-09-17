# My Tic Tac Toe Challenge

## Instructions for Running the Program on Terminal

* Clone this repository in your terminal ```git@github.com:michaelyatco/TicTacChallenge.git```
* In the file, advance to the ```/tictacchallenge/lib``` folder by typing ```cd lib/``` in the terminal
* Run the program by typing ```ruby tictactoe.rb```

## In-Game Instructions

* When prompted by the game, decide who will go first (as Player 1) by typing ```1``` for you, the human, or ```2``` for the computer.
* Player 1 will always be "x" and Player 2 will always be "o".
* Each space on the tic-tac-toe board corresponds to a number from 0 to 8. You will use these numbers to designate where you would like to place your "x" or "o" depending on whether you are Player 1 or Player 2.

                                              0  |  1  |  2
                                              --------------
                                              3  |  4  |  5
                                              --------------
                                              6  |  7  |  8
* If Player 1 is human, entering ```0``` on the first move will place the "x" in the top-left corner.

                                               x |     |   
                                              -------------
                                                 |     |   
                                              -------------
                                                 |     |   
* The computer will respond and play will continue until there is a three-in-a-row winning combination or there are no more open spaces.
                                                 
**Note - If the computer goes first, it will take about 10-15 seconds to make that first move due to the algorithm used to power its thinking.**                                           
