function image = getimage(img,intensity,num)
%GETIMAGE Summary of this function goes here
%   Detailed explanation goes here
image = 0*img(:,:,:);
L=num;
intensity1 = [0 intensity(1,:) 256];
intensity2 = [0 intensity(2,:) 256];
intensity3 = [0 intensity(3,:) 256];
for x=1:size(img,1)
    for y=1:size(img,2)
        if (img(x,y,1)<intensity1(L+1) && img(x,y,1)>=intensity1(L)) || (img(x,y,2)<intensity2(L+1) && img(x,y,2)>=intensity2(L)) || (img(x,y,3)<intensity3(L+1) && img(x,y,3)>=intensity3(L))
            image(x,y,1) = img(x,y,1);
            image(x,y,2) = img(x,y,2);
            image(x,y,3) = img(x,y,3);
        end
    end
end

end

