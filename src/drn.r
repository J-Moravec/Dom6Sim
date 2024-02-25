roll = function(){sample(1:6, 1)}

roll_plus = function(){
    x = 0
    while({r = roll()} == 6){
        x = x + r - 1
        }
    x = x + r
    x
    }

drn = function(){ roll_plus() + roll_plus() }

# Lets use a single set of simulated DRN
n = 10^6
drn_n = replicate(n, drn())
