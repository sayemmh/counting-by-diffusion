function dispImage(u)
show2=u/max(max(u));
show2(:,:,2)=show2(:,:,1);
show2(:,:,3)=show2(:,:,1);
image(show2)


end

