function creatematbynames
	curDir = 'faces94';
	files = dir(curDir);
	
	%('data400.mat');
	%load('data400seg.mat');
	%load('data400seg1.mat');
	load('data400seg2.mat');
	
	cnt = 1;
	cnt2 = 1;
	
	for k = 3: size(files,1)
		curDir2 = strcat(curDir,'/',files(k).name);
		files2 = dir(curDir2);
		for i = 3:size(files2,1)
			curDir3 =strcat(curDir2,'/',files2(i).name);
			files3 = dir(curDir3);
			for j = 3:size(files3,1)
				imagename = strcat(curDir3,'/',files3(j).name);
				if files3(j).name(size(files3(j).name,2) - 3 : end) ~= '.jpg'
					continue;
				end
				
				disp(imagename);
				
				y(cnt2) = cnt;
				cnt2 = cnt2 + 1;
							
			end
			
			cnt = cnt + 1;
			
		end
	end
	
	noOfFaces = cnt - 1;
	
	save dataByFacesSeg2.mat X y noOfFaces;
	
end
				