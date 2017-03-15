# Hierarchial-Clustering-Example---R

## Description:
Example of hierarchical clustering used to generate factors that can then be used to modify data.frames and enhance plots of those data.

The Coursera Exploratory Data Analysis lectures covering hierarchial clustering do not describe how to actually assign records in a database to a cluster. This example shows how to accomplish that with a simple example using EPA pollution data from 2008.

Each observation site has latitude and longitude coordinates, which allows one to plot a poor man's map of the United States. The example here simply identifies the four major landmasses that appear in the data: Alaska, Hawaii, Puerto Rico, and the lower 48 states.

The function missing from the lectures is the cutree() function, which this example demonstrates.
