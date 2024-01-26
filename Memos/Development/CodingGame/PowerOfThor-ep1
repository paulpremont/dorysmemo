import sys
import math

# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.
# ---
# Hint: You can use the debug stream to print initialTX and initialTY, if Thor seems not follow your orders.

# light_x: the X position of the light of power
# light_y: the Y position of the light of power
# initial_tx: Thor's starting X position
# initial_ty: Thor's starting Y position
light_x, light_y, initial_tx, initial_ty = [int(i) for i in input().split()]

# get the init Thor position
thor_x_position = initial_tx
thor_y_position = initial_ty

# game loop
while True:
    remaining_turns = int(input())  # The remaining amount of turns Thor can move. Do not remove this line.

    # Write an action using print
    # To debug: print("Debug messages...", file=sys.stderr, flush=True)

    direction = ""

    #Vertical move
    if thor_y_position < light_y :
        #if you are above the light, come down
        direction += "S"
        thor_y_position += 1
    elif thor_y_position > light_y :
        #if you are below the light, come up
        direction += "N"
        thor_y_position -= 1

    #Hoizontal move
    if thor_x_position < light_x :
        #if you are on the West of the light, come Est
        direction += "E"
        thor_x_position += 1
    elif thor_x_position > light_x :
        #if you are on the Est of the light, come West
        direction += "W"
        thor_x_position -= 1

    # Print debug informations
    print("Go Thor ! Go !!! (" + direction + ") is the way to the light !", file=sys.stderr, flush=True)

    # A single line providing the move to be made: N NE E SE S SW W or NW
    print(direction)

