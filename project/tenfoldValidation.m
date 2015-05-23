function tenfoldValidation(oX,oy,hidden_layer_size,num_labels,lambda, loadFile)
m=size(oX,1);
input_layer_size=size(oX,2);
foldSize=m/10;
options = optimset('MaxIter', 30);
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
%  randomize corpus...
r=randperm(m);
oX=oX(r,:);oy=oy(r,:);
for fold=1:10
	lambda=1;
	lX=[oX( 1:(fold-1)*foldSize,:) ; oX(1+fold*foldSize:10*foldSize,:) ];
	ly=[oy( 1:(fold-1)*foldSize,:) ; oy(1+fold*foldSize:10*foldSize,:) ];
	costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, lX, ly, lambda);
	fprintf('\nTraining Neural Network on fold: %d... \n',fold);
	%initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
	%initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
	%initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
	[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
	%lambda = 3;
	%checkNNGradients(lambda);
	
	Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));
	Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
	tX=oX( 1+(fold-1)*foldSize:fold*foldSize ,:);
	ty=oy( 1+(fold-1)*foldSize:fold*foldSize ,:);
	[dummy,pred]=predict(tX, loadFile);
	fprintf('\nFold:%d Training Set Accuracy: %f\n', fold,mean(double(pred == ty)) * 100);
end

end