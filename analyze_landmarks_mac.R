# Citrullus Landmark Analysis
# Last updated on 1 May 2021 by K Wolcott
# See analysis in Wolcott et al. 2021, Plants, People, Planet

# Run this R script after converting Amira landmark data to txt files using directions in preprocess_landmarks.txt
# Refer to http://people.tamu.edu/~alawing/materials/ESSM689/Quick_Guide_to_Geomorph_v2.0.pdf

# If on Mac
# First, install XQuartz 2.7.11
# https://www.xquartz.org/releases/XQuartz-2.7.11.html
# Then, install packages
install.packages("geomorph") 
install.packages("Morpho")
install.packages("rgl")

# Load libraries
library("geomorph")
library("Morpho")
library("abind")

# Set working directory
setwd("C:/Users/katherinewolcott/Documents/r/Citrullus/landmark_analysis")

# Read in landmark files
df = readland.tps("all_lms.txt", specID ="ID", negNA=FALSE)

df # Inspect file
df[,,32] # Inspect one specimen
df[1,,] # Inspect one landmark for all specimens
df[,1,] # Inspect landmark coord 1 of 3 for all specimens

# Set LM pairs for "connecting the dots" to draw an outline of LMs
links = rbind(c(1,2), c(2,3), c(3,4), c(4,5), c(5,6), c(6,7), c(7,8), c(8,1),
              c(9,10), c(10,11), c(11,12),c(12,13), c(13,14),c(14,15), c(15,16),
              c(16,9), c(17,18), c(18,19), c(19,20), c(20,21), c(21,22), c(22,23),
              c(23,24), c(24,17), c(25,26), c(26,27), c(27,28), c(28,29),
              c(29,30), c(30,31), c(31,32), c(32,25))

# Read in specimen id mapping file to get species and subfossil/cultivated info for specimens
spec.ids = read.csv("map_specimen_ids.csv", header=T, row.names=1)
spec.ids$type = as.factor(spec.ids$type) # make subfossil/cultivated a factor
spec.ids$type
spec.ids$species = as.factor(spec.ids$species) # make species a factor
spec.ids$species

# Two separate analyses carried out due to fragmented/incomplete fossil specimens
### A) ALL Specimens analysis below ### (no exclusions)

# 1) Estimate missing landmarks using Morpho TPS
all = df
all.est = fixLMtps(all,comp=3)

# 2) Procrustes fit, all specimens
gpa.all = gpagen(all.est$out)
gpa.all
# Plot points on aligned axes
plot(gpa.all)
# Add connecting lines
plotAllSpecimens(gpa.all$coords,links=links)
# Plot outliers
plotOutliers(gpa.all$coords)

# 3) PCA, all specimens
pca.all = gm.prcomp(gpa.all$coords)
summary(pca.all)
# Plot PCA
pca.plot = plot(pca.all, main = "PCA, all datasets", col = c(rep("darkorange4", 25), 
              rep("darkolivegreen", 10)), bg = c(rep("darkorange1", 25), 
              rep("darkolivegreen3", 10)), pch=21)

# Add polygons using custom shapeHulls1 function (excludes rehmii bc only 1 specimen)
groups = spec.ids$species
shapeHulls1(pca.plot, groups=groups, group.cols=c(rep("grey", 5)), group.lwd=c(rep(1,5)),
            group.lty=c(rep(2,5)))

# Add legend
legend(0.42, -0.31, inset=0, legend=c("Modern","Ancient"), col=c("darkorange4", 
              "darkolivegreen"), pt.bg=c("darkorange1", "darkolivegreen3"), pch=21,
              y.intersp=0.3,x.intersp=0.3,text.width=0.06, bg="transparent")

# Add labels to points
names(gpa.all$Csize) = 1:35
text((pca.all$x[,1]+0.001),(pca.all$x[,2]-.002),names(gpa.all$Csize))

### END ALL specimen analysis ###


### B) Excluded specimen analysis below ###
# Exclude fragmented specimens w/o enough LMs to est. using bilat. symm. (exclude 26,31:35)

# 1) Estimate missing landmarks using Morpho TPS
exclu = df[,,c(1:25,27:30)]
spec.ids.exclu = spec.ids[c(1:25,27:30),]
#exclu.est = fixLMtps(exclu,comp=3) # Note: only use this line if any inclu. spec. need est. LMs

# 2) Procrustes fit, 7 specimens excluded
#gpa.exclu = gpagen(exclu_est$out) # Note: only use this line if any inclu. spec. have est. LMs
gpa.exclu = gpagen(exclu) # Note: use this line if no estimated LMs
gpa.exclu
# Plot points on aligned axes
plot(gpa.exclu)
# Add connecting lines
plotAllSpecimens(gpa.exclu$coords,links=links)

# Plot outliers
plotOutliers(gpa.exclu$coords)
# Compare outliers to mean consensus shape
shape1<-mshape(gpa.exclu$coords) # mean shape
#shape2<-gpa.exclu$coords[,,9] # Normal ex
#shape2<-gpa.exclu$coords[,,24] # Outlier ex: naudinianus C
#shape2<-gpa.exclu$coords[,,1] # Outlier ex: rehmii
# Thin	plate	spline
plotRefToTarget(shape1,	shape2,	method=c("TPS"),mag=2)
# Lollipops
plotRefToTarget(shape1,	shape2, method=c("vector"),	mag=10)
# Points
plotRefToTarget(shape1,	shape2, method=c("points"),	mag=10)

# 3) PCA, 6 specimens excluded
pca_exclu = gm.prcomp(gpa.exclu$coords)
summary(pca.exclu)
# Plot PCA
pca.plot = plot(pca.exclu, main = "PCA, 6 subfossils excluded", col = c(rep("darkorange4", 25), 
                rep("darkolivegreen", 5)), bg = c(rep("darkorange1", 25), 
                rep("darkolivegreen3", 5)), pch=21, cex=1.3, pt.cex = 1)
# Add polygons using custom shapeHulls1 function (excludes rehmii bc only 1 specimen)
groups = spec.ids.exclu$species
shapeHulls1(pca.plot, groups=groups, group.cols=c(rep("grey", 5)), group.lwd=c(rep(1,5)),
            group.lty=c(rep(2,5)))

# Select point on plot and compare to mean shape
#picknplot.shape(plot(pca.exclu), method = "points")

# Add legend
legend(-0.168, -0.076, inset=0, legend=c("Modern","Ancient"), col=c("darkorange4", 
            "darkolivegreen"), pt.bg=c("darkorange1", "darkolivegreen3"), pch=21,
            y.intersp=0.3,x.intersp=0.3,text.width=0.02)
# Add labels to points
names(gpa.exclu$Csize) = 1:29
text((pca.exclu$x[,1]+0.001),(pca.exclu$x[,2]-.002),names(gpa.exclu$Csize))

# Make deformation meshes to manually add to PCA plots outside of R
# Compare min and max from PCA to mean consensus shape
msh<-mshape(gpa.exclu$coords) # mean shape
# Component 1
plotRefToTarget(pca.exclu$shapes$shapes.comp1$min, msh) # min shape to mean
plotRefToTarget(pca.exclu$shapes$shapes.comp1$max, msh) # max shape to mean
# Component 2
plotRefToTarget(pca.exclu$shapes$shapes.comp2$min, msh) # min shape to mean
plotRefToTarget(pca.exclu$shapes$shapes.comp2$max, msh) # max shape to mean

