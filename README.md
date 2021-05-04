# Citrullus_3D_GMM
3D geometric morphometric analysis using the R packages geomorph v4.0.0 and Morpho v2.8 for landmarks generated in Amira Software version 5.4.5   
Code accompanies Wolcott et al. 2021, Plants, People, Planet.   
*Last updated 3 May 2021*

<p align="center">
<a href="url"><img src="https://github.com/aubricot/Citrullus_3D_GMM/blob/main/ms_banner.png" align="middle" width="900" ></a></p>   

<p align="center">
<sub><sup>Images show a subset of seeds and landmarks used to investigate 3D shape differences of modern and ancient watermelon seeds (To access micro-CT datasets and surfaces used for analysis, see our <a href="https://www.morphosource.org/projects/0000C1170?id=0000C1170&locale=en&page=2#about"> MorphoSource project page</a>).</sup></sub>

Archaeological research on the domestication history of watermelons has focused on seeds found at settlements where people either ate the sweet fruit pulp, the fat-rich seeds, or used the oil extracted from seeds. The earliest seeds assigned to <i>Citrullus lanatus</i> and <i>C. colocynthis</i> come from the Libyan archaeological site Uan Muhuggiag, but stratigraphic evidence suggested that it had been disturbed and contained younger intrusive material. We used 3D x-ray-micro-CT to investigate whether ancient Citrullus seeds can be reliably assigned to <i>C. lanatus</i> or <i>C. colocynthis</i>, using seeds from all but one extant species of <i>Citrullus</i> as well as seeds from Tutankhamun’s tomb at Thebes and from Uan Muhuggiag.

### Steps
1) Generate surface files in Amira (see surface files and CT datasets in Morphosource)
2) Add landmarks to surface files in Amira (see all_lms.txt in this GitHub repository)
3) Do 3D GMM analysis (see analyze_landmarks_mac.R in this GitHub repository)

### References
* [geomorph](https://github.com/geomorphR/geomorph). geomorph. GitHub.
* [geomorph documentation on CRAN](https://cran.r-project.org/web/packages/geomorph/geomorph.pdf)
* [Adams and Otárola‐Castillo 2013](https://doi.org/10.1111/2041-210X.12035). Geomorph: An r package for the collection and analysis of geometric morphometric shape data. Methods in Ecology and Evolution.
* [Morpho](https://github.com/zarquon42b/Morpho). Morpho. GitHub.
* [Morpho documentation on CRAN](https://cran.r-project.org/web/packages/Morpho/Morpho.pdf)
* [Schlager 2017](http://dx.doi.org/10.1016/B978-0-12-810493-4.00011-0). Morpho and Rvcg - Shape Analysis in R: R-Packages for Geometric Morphometrics, Shape Analysis and Surface Manipulations. Statistical Shape and Deformation Analysis: Methods, Implementation and Applications.
* [Polly 2012a](https://g562.sitehost.iu.edu/PBDB2013/Day%202A%20-%20Introduction%20to%20Geometric%20Morphometrics.pdf). Geometric morphometrics, an introduction - Day 2A. Department of Geological Sciences, Indiana University.
* [Polly 2012b](https://g562.sitehost.iu.edu/PBDB2013/Day%202B%20-%20Geometric%20Morphometrics%20in%20R.pdf). A basic geometric morphometric analysis - Day 2B. Department of Geological Sciences, Indiana University.
* [Jones 2018](https://www.cnidaria.nat.uni-erlangen.de/shortcourse/Lecture%202%20-%20Introduction%20to%20Geomorph%20Package.pdf). Introduction to geomorph package. Uni Erlangen. 
