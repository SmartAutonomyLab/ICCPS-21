function [X, Y] = sample_from(models)
% Function to draw samples from the modes;
    % models can be either a probability distribution function or
    % Simulinkmodel
    
sample = [];
for i = 1 : 2
    if ~contains(class(models(i)), 'prob') && ~contains(class(models(2)), '.slx')
        disp('The models musb be either a Simulink model or a Probability Distribution function')
    elseif contains(class(models(i)), 'prob')
        sample(i,1) = random(models(i),1);
    elseif contains(class(models(i)), '.slx')
        sample(i,1)  = sim(models(i),'SaveTime','on','TimeSaveName','tout');
    end
end
X = sample(1,1);
Y = sample(2,1);
end