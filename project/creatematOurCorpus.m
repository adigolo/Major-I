function creatematOurCorpus
	curDir = 'OurCorpus';
	files = dir(curDir);
	X = zeros(0,400);
	y = zeros(0,1);
	
	Xseg = zeros(0,400);
	yseg = zeros(0,1);
	
	Xseg1 = zeros(0,400);
	yseg1 = zeros(0,1);
	
	Xseg2 = zeros(0,400);
	yseg2 = zeros(0,1);
	
	cnt = 1;
	nameMapping = '';
	
	sizeSetting = 0;
	for k = 3: size(files,1)
		curDir2 = strcat(curDir,'/',files(k).name);
		files2 = dir(curDir2);
		disp(files(k).name);
		nameMapping = [nameMapping files(k).name];
		disp(nameMapping);
		for j = 3:size(files2,1)
			imagename = strcat(curDir2,'/',files2(j).name);
			if files2(j).name(size(files2(j).name,2) - 3 : end) ~= '.jpg'
				continue;
			end
			
			disp(imagename);
			I = imread(imagename);
			[imgseg,int] = segmentation(I,4,'dpso');
			imgsegth1 = getimage(I,int,3);
			imgsegth2 = getimage(I,int,2);
			
			I = imresize(I, [20 20]);
			imgseg = imresize(imgseg, [20 20]);
			imgsegth1 = imresize(imgsegth1, [20 20]);
			imgsegth2 = imresize(imgsegth2, [20 20]);
			
			if sizeSetting == 0 && size(X,2) ~= size(I,1)*size(I,2)*size(I,3)
				X = zeros(0,size(I,1)*size(I,2)*size(I,3));

				Xseg = zeros(0,size(imgseg,1)*size(imgseg,2)*size(imgseg,3));
				
				Xseg1 = zeros(0,size(imgsegth1,1)*size(imgsegth1,2)*size(imgsegth1,3));
				
				Xseg2 = zeros(0,size(imgsegth2,1)*size(imgsegth2,2)*size(imgsegth2,3));
				
				sizeSetting = 1;
			end
			
			nI = zeros(1,0);
			for k = 1:size(I,3)
				nI = [nI reshape(I(:,:,k) , [1 400])];
			end
			X = [X ; nI];
			y = [y ; cnt];
			
			nI = zeros(1,0);
			for k = 1:size(imgseg,3)
				nI = [nI reshape(imgseg(:,:,k) , [1 400])];
			end
			Xseg = [Xseg ; nI];
			yseg = [yseg ; cnt];
			
			nI = zeros(1,0);
			for k = 1:size(imgsegth1,3)
				nI = [nI reshape(imgsegth1(:,:,k) , [1 400])];
			end
			Xseg1 = [Xseg1 ; nI];
			yseg1 = [yseg1 ; cnt];
			
			nI = zeros(1,0);
			for k = 1:size(imgsegth2,3)
				nI = [nI reshape(imgsegth2(:,:,k) , [1 400])];
			end
			Xseg2 = [Xseg2 ; nI];
			yseg2 = [yseg2 ; cnt];
			
		end
		cnt = cnt + 1;
		
	end
	
	noOfFaces = cnt - 1;
	save dataOurCorpus.mat X y noOfFaces nameMapping;
	
	X = Xseg; y = yseg;
	save dataOurCorpusSeg.mat X y noOfFaces nameMapping;
	
	X = Xseg1; y = yseg1;
	save dataOurCorpusSeg1.mat X y noOfFaces nameMapping;
	
	X = Xseg2; y = yseg2;
	save dataOurCorpusSeg2.mat X y noOfFaces nameMapping;
	
	save nameMapping.mat nameMapping;
	
end
				