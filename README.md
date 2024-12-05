# Speech_Recognition
EEEM030 Group Assignment 2


## Structure of the code
```
.
├── HMM_model                           # HMM model
│   ├── Baum_Welch.m                    # Baum-Welch algorithm
│   ├── compute_backward_likelihood.m   # Compute backward likelihood
│   ├── compute_forward_likelihood.m    # Compute forward likelihood
│   ├── compute_occupation_likelihood.m # Compute occupation likelihood
│   ├── compute_pdf.m                   # Compute pdf
│   ├── compute_pdf_gm.m                # Compute pdf for Gaussian mixture
│   ├── compute_probability.m           # Compute probability
│   ├── compute_transition_likelihood.m # Compute transition likelihood
│   ├── obtain_likelihoods.m            # Obtain likelihoods
│   ├── train.m                         # Train HMMs
│   └── viterbi.m                       # Viterbi algorithm
├── README.md                           # Readme file
├── compute_confusion_matrix.m          # Compute confusion matrix
├── conf
│   └── GlobalSetting.m                 # Global setting
├── data
│   ├── data_augmentation               # all data for data augmentation
│   ├── evaluationData.mat              # evaluation data
│   ├── graphs
│   │   └── confusion_matrix.png        # confusion matrix graph
│   ├── hmm_models.mat                  # HMM models
│   ├── recognition_result.mat          # recognition result
│   ├── testData.mat                    # test data
│   └── trainData.mat                   # training data
├── document                            # report
│   ├── Report for Speech Recognition.tex
│   └── bibliography
├── feature_extraction                  # feature extraction code
│   ├── mfccFeature.m                   # MFCC feature extraction
│   └── shared_feature_extraction.mlx   # shared feature extraction
├── model_initialization                # model initialization code
│   ├── Gussian_mix.m                   # Gaussian mixture initialization
│   ├── Gussian_mix_with_kmeans.m       # Gaussian mixture initialization with kmeans
│   ├── init_hmm.m                      # HMM initialization
│   ├── init_hmm_with_kmeans.m          # HMM initialization with kmeans
│   ├── meanVariance.m                  # mean and variance calculation
│   └── transitionProbability.m         # transition probability calculation
├── preprocessing                       # data preprocessing
│   ├── data_augmentation.m             # data augmentation
│   ├── data_exploration.m              # data exploration
│   └── make_train_evaluation_data.m    # make train and evaluation data
├── test                                # test scripts
│   ├── test.m
│   └── testMfccFeature.m
├── test_model.m                        # test model
├── train_model.m                       # train model
└── voicebox                            # voicebox package
    ├── disteusq.m
    ├── kmeans.m
    ├── rnsubset.m
    ├── voicebox.m
    └── winenvar.m
```