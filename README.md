# Polygon-Area
Write a program to find the area of any polygon given its vertexes.  

Inputs:	The input is the set of polygons. 

Outputs:	Label and print the area value for each input.

Restrictions:	You are to use one-dimensional array(s) to hold vertex values.
	You are to use Functions/Procedures in your implementation.  
                           DO NOT repeat code for each polygon, but loop through one set of code
                                 for every polygon.
	Print your output into a file.

Consider:	Area = (1/2) E^(N-1)_(i=1) ( (X_(i+1).Y_i) - (X_i.Y_(i+1)) )
	
         Repeat the first point in the polygon in setting up the list of points for the above loop.  Loop through the points in a clockwise process form point to point.
