roll = function(){sample(1:6, 1)}

roll_plus = function(){
    x = 0

    while({r = roll()} == 6){
        x = x + r - 1
        }
    x = x + r
    x
    }
    x = roll()
    if(x == 6){
        x = x - 1 + roll_plus()
    }

drn = function(){ roll_plus() + roll_plus() }

# Lets use a single set of simulated DRN
n = 10^6
drn_n = replicate(n, drn())

damage = function(dmg, prot, type = c("pierce", "slash")){
    type = match.arg(type)

    if(type == "pierce")
        prot = floor(prot * 0.85)

    y = dmg + drn_n  - prot - sample(drn_n)
    y[y < 0] = 0

    if(type == "slash")
        y = floor(y * 1.25)

    mean(y)
    }

spear = sapply(1:20, damage, dmg = 10, type = "pierce")
sword = sapply(1:20, damage, dmg = 10, type = "slash")

plot.new()
plot.window(xlim = c(0, 20), ylim = c(0, 20))
lines(spear, type = "b", col = "red", pch=19)
lines(sword, type = "b", col = "blue", pch=19)
axis(1)
axis(2, las = 1)
legend("topleft", bty="n", legend=c("pierce", "slash"), pch = 19, col = c("red", "blue"))
title(adj = 0, "Comparison of slash and pierce damage")
mtext(adj = 0, "For atk 10 and protection from 1 to 20")
