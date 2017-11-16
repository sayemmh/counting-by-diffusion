
## counting by diffusion

Research project under Professor Sung Kang in the School of Mathematics at Georgia Tech. The idea behind this project is to count objects within certain sets of images in real time. The canny edge detector is used to generate edge plots and then anisotropic diffusion methods (Perona-Malik) are applied on the edge plots. After this, the histograms of the diffused edge plots are clustered with a regularized kmeans algorithm and give the number of objects in the image.

canny edge detector : `getEdges2.m`
k-means clustering : `kmeansFunction1D.m`
total variation denoising : `tvreduction.m`
counting by diffusion : `CBD.m`
