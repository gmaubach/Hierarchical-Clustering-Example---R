# Hierarchical-Clustering-Example---R

## Description:
Example of hierarchical clustering used to generate factors that can then be used to modify data.frames and enhance plots of those data.

The Coursera Exploratory Data Analysis lectures covering hierarchical clustering do not describe how to actually assign records in a database to a cluster. This example shows how to accomplish that with a simple example using EPA pollution data from 2008.

Each observation site has latitude and longitude coordinates, which allows one to plot a poor man's map of the United States. The example here simply identifies the four major landmasses that appear in the data: Alaska, Hawaii, Puerto Rico, and the lower 48 states.

The function missing from the lectures is the cutree() function, which this example demonstrates.

## Key Code Segments:

### Plot without landmasses
```
g <- ggplot(pm25s, aes(lon,lat))
g+geom_point()
```

![alt text](https://github.com/wstreyer/Hierarchical-Clustering-Example---R/blob/master/nolandmasses.png "No Landmasses")

### Identify landmasses with h-clustering
Some trial and error determined that the centroid method correctly groups the landmasses
```
hc <- hclust(dist(pm25s[,1:2]), method = "centroid")
```

### Convert the hclust results into a usable factor
cutree() is the key function missing from the Coursera - DSS EDA lectures. The 'k' parameter describes how many clusters should be formed from the hclust tree. Given that these particular clusters are familiar to most users, the correct number of clusters is 4.
```
landmass <- cutree(hc, k=4)
pm25s$landmass <- as.factor(landmass)
levels(pm25s$landmass) <- c("PR", "HI", "48", "AK")
```

### Plot with landmasses identified
```
g <- ggplot(pm25s, aes(lon,lat, color=landmass))
g+geom_point()
```

![alt text](https://github.com/wstreyer/Hierarchical-Clustering-Example---R/blob/master/landmasses.png "Landmasses")
