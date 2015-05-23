function imgPredict(name, loadFileNeuralParams)

	figure;
	load('nameMapping.mat');
	I = imread(name);
	
	if size(loadFileNeuralParams,2) == size('NeuralParametersSeg.mat',2) && loadFileNeuralParams == 'NeuralParametersSeg.mat'
		I = segmentation(I,4,'dpso');
	elseif size(loadFileNeuralParams,2) == size('NeuralParametersSeg1.mat',2) && loadFileNeuralParams == 'NeuralParametersSeg1.mat'
		[imgseg,int] = segmentation(I,4,'dpso');
		I = getimage(I,int,3);
	elseif size(loadFileNeuralParams,2) == size('NeuralParametersSeg2.mat',2) && loadFileNeuralParams == 'NeuralParametersSeg2.mat'
		[imgseg,int] = segmentation(I,4,'dpso');
		I = getimage(I,int,2);
	end
	
	image(I);
	load(loadFileNeuralParams);
	I = imresize(I, [20 20]);
	nI = zeros(1,0);
	for k = 1:size(I,3)
		nI = [nI reshape(I(:,:,k) , [1 400])];
	end
	nI = double(nI);
	[dummy,categ] = predict(nI, loadFileNeuralParams);
	
	fprintf('Neural network predicts the image to be of %s with probablity %.2f\n',nameMapping((categ-1)*6 + 1: categ*6),dummy);
	file_id = fopen('predictionImage.txt', 'w');
	fdisp(file_id, 'Neural network predicts the image to be of ');
	fdisp(file_id, nameMapping((categ-1)*6 + 1: categ*6));
	fdisp(file_id, 'with probablity');
	fdisp(file_id,dummy);
	fclose(file_id);
	
	pause;
	close;
end