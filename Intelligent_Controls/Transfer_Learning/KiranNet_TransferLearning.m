%% Transfer Learning using AlexNet as a base   Suryakiran George    Mar 2022

%% Load a pre-trained, deep, convolutional network
alex = alexnet;
layers = alex.Layers

%% Modify the network to use five categories
layers(23) = fullyConnectedLayer(5); 
layers(25) = classificationLayer

%% Set up our training data
allImages = imageDatastore('AlexNet_TransfLearning_Images', 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
[trainingImages, testImages] = splitEachLabel(allImages, 0.8, 'randomize');

%% Re-train the Network
opts = trainingOptions('sgdm', 'InitialLearnRate', 0.001, 'MaxEpochs', 200, 'MiniBatchSize', 64);
KiranNet = trainNetwork(trainingImages, layers, opts);

%% Measure network accuracy
predictedLabels = classify(KiranNet, testImages); 
accuracy = mean(predictedLabels == testImages.Labels)

%% Save myNet to a .mat file
save KiranNetSave.mat KiranNet
