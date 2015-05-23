function [ry] = recode(y,num_labels)

temp=(1:num_labels);m=size(y,1);
ry=zeros(m,num_labels);
%disp(size(ry(1,:)));disp(size((temp==y(1))));
for i=(1:m)
	ry(i,:)=(temp==y(i));
end

end