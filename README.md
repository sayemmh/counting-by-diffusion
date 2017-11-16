
## counting by diffusion

Research project under Professor Sung Kang in the School of Mathematics at Georgia Tech. The idea behind this project is to count objects within certain sets of images in real time and return some information on those objects.

The process works as such:
1. detect edges in the input image with a Canny edge detector
2. apply anisotropic diffusion methods (total variation reduction & Perona-Malik) to the edge plots
3. take histograms of the anisotropically diffused image (using built in MATLAB function)
4. cluster the resulting histograms with a regularized kmeans algorithm
5. the result of the clustering algorithm gives information on the number and size of objects

I implemented my own versions of the Canny edge detector, total variation denoising filter (Rudin/Osher/Fatemi), Perona-Malik anisotropic diffusion filter, and wrote a regularized version of the kmeans algorithm. These are found in `cannyEdges.m`, `tvreduction.m`, `peronamalik.m`, and `regKMeans.m` respectively.

The usefulness of this tool is in situations where counting objects in a large set of images becomes repetitive and time consuming. For example, if you had to count the number of red blood cells in a blood smear under a microscope for hundreds of smears this would help.

![alt text](https://github.com/sayemmh/counting-by-diffusion/img/smear1.png)
