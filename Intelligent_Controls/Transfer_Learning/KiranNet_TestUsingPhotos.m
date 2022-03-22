clear 
load KiranNetSave.mat
nnet = KiranNet
while true   
picture = imread('Capture6.jpg');
    picture = imresize(picture,[227,227]);  % Resize the picture
    label = classify(nnet, picture);        % Classify the picture   
    image(picture);     % Show the picture
    title(char(label)); % Show the label
    drawnow;   
end
%%  Type >>  CRTL-C to exit
