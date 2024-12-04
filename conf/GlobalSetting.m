classdef GlobalSetting
    %GLOBALSETTING Summary of this class goes here
    %   Detailed explanation goes here

    properties(Constant=true)
        % Dataset path
        DATASET_FOLDER = 'data/EEEM030cw2-DevelopmentSet-2024';
        EVALUATION_FOLDER = 'data/EEEM030cw2-EvaluationSet-2024';
        TRAIN_DATA = 'data/trainData.mat';
        TEST_DATA = 'data/testData.mat';
        EVALUATION_DATA = 'data/evaluationData.mat';
        HMM_MODEL = 'data/hmm_models.mat'
        RECOGNITION_RESULT = 'data/recognition_result.mat'
        GRAPH_PATH = 'data/graphs'
        DATA_AUGMENTATION = 'data/data_augmentation'

        % words for speech recognition
        WORDS = {'heed', 'hid', 'head', 'had', 'hard', 'hud', 'hod', 'hoard', 'hood', 'whod', 'heard'}

        % Epochs for training
        EPOCHS = 1

        % HMM parameters
        % The state of HMM model
        N = 8;
        % The dimension of continuous probability density function
        D = 13;

        % Based on the instructions in the assignment, we can get initial A and Pi in Table 1
        A_init = [0.8 0.2 0.0 0.0 0.0 0.0 0.0 0.0,
            0.0 0.8 0.2 0.0 0.0 0.0 0.0 0.0,
            0.0 0.0 0.8 0.2 0.0 0.0 0.0 0.0,
            0.0 0.0 0.0 0.8 0.2 0.0 0.0 0.0,
            0.0 0.0 0.0 0.0 0.8 0.2 0.0 0.0,
            0.0 0.0 0.0 0.0 0.0 0.8 0.2 0.0,
            0.0 0.0 0.0 0.0 0.0 0.0 0.8 0.2,
            0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.8];
        Pi_init = [1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0];
        eta_init = [0 0 0 0 0 0 0 0.2]';

        % Replace NaNs with 0
        REPLACE_NAN = 0;

    end

    methods
        function obj = GlobalSetting()
            %GLOBALSETTING Construct an instance of this class
            %   Detailed explanation goes here
        end
    end
end

