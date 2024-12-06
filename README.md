# Speech_Recognition
EEEM030 Group Assignment 2


## Structure of the code
```
.
├── HMM_model                                       # HMM model
│   ├── Baum_Welch.m                                # Baum-Welch algorithm
│   ├── compute_backward_likelihood.m               # compute backward likelihood
│   ├── compute_error_rate.m                        # compute error rate
│   ├── compute_forward_likelihood.m                # compute forward likelihood
│   ├── compute_occupation_likelihood.m             # compute occupation likelihood
│   ├── compute_pdf.m                               # compute pdf
│   ├── compute_pdf_gm.m                            # compute pdf of gaussian mixture model
│   ├── compute_probability.m                       # compute probability
│   ├── compute_transition_likelihood.m             # compute transition likelihood
│   ├── obtain_likelihoods.m                        # obtain likelihoods
│   ├── plot_errors.m                               # plot errors
│   ├── speech.mlx
│   └── viterbi.m                                   # viterbi algorithm
├── README.md                                       # Readme file
├── compute_confusion_matrix.m                      # compute confusion matrix
├── conf
│   └── GlobalSetting.m                             # global setting
├── data                                            # data
│   ├── EEEM030cw2-DevelopmentSet-2024
│   ├── EEEM030cw2-EvaluationSet-2024
│   ├── data_augmentation
│   ├── evaluationData.mat
│   ├── graphs
│   │   ├── Error_rate_trend_for_HMM_model.png
│   │   └── confusion_matrix.png
│   ├── hmm_models
│   ├── recognition_result.mat
│   ├── testData.mat
│   └── trainData.mat
├── document                                         # Report
│   ├── Enhanced Report.docx
│   ├── Report for Speech Recognition.tex            # LaTeX source code
│   ├── bibliography
│   ├── refs.bib
│   └── speech.docx
├── feature_extraction
│   ├── mfccFeature.m                                # MFCC feature extraction
│   └── shared_feature_extraction.mlx                # Feature extraction shared function
├── model_initialization                             # HMM model initialization
│   ├── Gussian_mix.m                                # Gaussian mixture initialization
│   ├── init_hmm.m                                   # HMM initialization
│   ├── meanVariance.m                               # Mean and variance calculation
│   ├── normalizeMatrix.m                            # Matrix normalization
│   └── regularizeCovariance.m                       # Covariance regularization
├── preprocessing                                    # Data preprocessing
│   ├── data_augmentation.m                          # Data augmentation
│   ├── data_exploration.m                           # Data exploration
│   └── make_train_evaluation_data.m                 # Make train and evaluation data
├── test                                             # Test
│   ├── test.m
│   └── testMfccFeature.m
├── test_model.m                                     # Test model
└── train_model.m                                    # Train model
```