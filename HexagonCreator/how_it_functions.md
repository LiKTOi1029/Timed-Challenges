# Hexagon Creator

A few needed pre-requisite information is this, that the angle of every closed shape 
(squares, circles, hexagons, pentagons, etc) will have an angle of 360 degrees, as in 
if we were to add the degrees of all the sides together, we'd amount to exactly 360 degrees.\
\
Using this information, a hexagon has 6 sides, this means that we'd need to divide 360 by 6 
to get 60 degrees. The angle of any two given adjacent sides of a hexagon (given the hexagon is a symmetrical shape) 
will be 60 degrees exactly.\
\
On a unit circle, the Cosine value is how close the tip of the hypotnuse is to 
the unit circle's X point while the Sine value is how close the tip of the hypotnuse is to the Y point. 
We can use this knowledge to obtain each of the angles individual Cosine and Sine values. It will be 
useful later.\
\
i = 60\
PI = math.pi\
\
Cos(i / PI/180) -- Lua takes values in radians, not degrees, therefore we must do the conversion\
Sin(i / PI/180) -- For both Sine and Cosine, of course\
\
I do this in a loop, starting from 0 degrees and looping all the way up to 300 degrees (as a 360 
degree angle on a unit circle is equivelant to 0 degrees, there is no need to take in 360 degrees as an 
input) adding 60 to the starting value **i** every loop.\
\
We plot our first point. In my script's case, (100x, 100y). Then, I loop over every single {Cosine, Sine} pair 
and use this formula to find out where all the next points of my hexagon should be plotted.\
\
StartingVertex = {100, 100}\
(Cosine \* StartingVertex\[1\])+StartingVertex\[1\]\
(Sine \* StartingVertex\[2\])+StartingVertex\[2\]\
\
and we add each of the resulting pair of values to a table, in subtables as pairs of values. Finally, now that we 
have every point of the hexagon, we draw it to the screen using `love.graphics.line()`.\
\
To run this, I didn't compile this as it's only a proof of concept, but you can run it using love2d. I won't include 
a love2d tutorial here figure it out yourself lol.