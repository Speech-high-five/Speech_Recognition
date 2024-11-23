classdef GlobalSetting
    %GLOBALSETTING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Constant=true)
        DATASET_FOLDER = 'data/EEEM030cw2-DevelopmentSet-2024';
        TRAIN_DATA = 'data/trainData.mat';
        TEST_DATA = 'data/testData.mat';
    end
    
    methods
        function obj = GlobalSetting()
            %GLOBALSETTING Construct an instance of this class
            %   Detailed explanation goes here
        end
    end
end

