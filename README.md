Insurance Claim Fraud Detection using Machine Learning

An end-to-end Machine Learning classification project for identifying potentially fraudulent insurance claims using Python and Scikit-learn.

Project Overview

Insurance fraud can result in significant financial losses and increase claim-processing costs. Manual claim verification can also be time-consuming and may fail to identify complex fraud patterns.

This project develops a machine learning-based approach to identify potentially fraudulent insurance claims for further investigation.

The workflow covers:

- Data integration
- Data cleaning and preprocessing
- Exploratory Data Analysis (EDA)
- Feature engineering and selection
- Class imbalance analysis
- Machine Learning classification
- Model evaluation
- Feature importance analysis
- Business recommendations

Dataset

The project uses three datasets:

1. Insurance Data — 10,000 records and 38 columns
2. Employee Data — 1,200 records and 10 columns
3. Vendor Data — 600 records and 7 columns

The datasets were integrated to combine customer, employee/agent, and vendor information for fraud analysis.

After integration, the combined dataset contained 10,000 records and 53 columns.

Target Variable

The "CLAIM_STATUS" variable was mapped to create the binary "Fraud" target:

- "0" — Genuine Claim
- "1" — Fraudulent Claim

The final dataset contained:

- 9,497 Genuine Claims
- 503 Fraudulent Claims
- Fraud Rate: 5.03%

This indicates a class imbalance in the dataset.

Project Objectives

- Understand the insurance claim data
- Integrate insurance, employee, and vendor information
- Clean and preprocess the datasets
- Perform exploratory data analysis
- Identify potential fraud-related patterns
- Prepare relevant features for Machine Learning
- Analyze class imbalance
- Train multiple classification models
- Compare model performance
- Identify important fraud-related factors
- Generate actionable business recommendations

Exploratory Data Analysis

The project includes 18 visualizations covering:

- Customer age distribution
- Marital status
- Employment status
- Education level
- Social class
- Insurance type
- Claim amount distribution
- Premium amount distribution
- Claim status distribution
- Fraud by age
- Fraud by insurance type
- Fraud by incident severity
- Fraud by injury information
- Fraud by police report availability
- Fraud by incident hour
- Correlation analysis
- Claims by state
- Risk segmentation

Key EDA Insights

- Most policyholders fall between 30–60 years.
- Married customers represent the dominant customer segment.
- Auto and Health insurance generate a large share of claims.
- Most claims are relatively small, with a smaller number of very large claims.
- Major incident severity shows higher fraud likelihood.
- Some insurance categories show higher fraud frequency.
- Missing police reports are associated with suspicious claim patterns.
- Late-night incidents show higher fraud concentration.
- High-risk segments show increased denial rates.

Data Preprocessing

The preprocessing workflow included:

- Handling missing values
- Removing unnecessary identifiers and personal information
- Encoding categorical variables
- Feature selection
- Preparing the target variable
- Train-test splitting
- Stratified sampling to preserve class distribution

Machine Learning Models

Four classification algorithms were trained and compared:

1. Logistic Regression
2. Decision Tree
3. Random Forest
4. Gradient Boosting

Model Performance

Model| Accuracy
Logistic Regression| 94.95%
Random Forest| 94.95%
Gradient Boosting| 94.80%
Decision Tree| 88.80%

Logistic Regression and Random Forest achieved the highest reported accuracy of 94.95% on the test dataset.

«Note: Since the dataset is imbalanced, accuracy should not be considered sufficient on its own for evaluating a fraud detection model. Fraud-focused metrics such as precision, recall, F1-score, ROC-AUC and confusion-matrix analysis are important for a more comprehensive evaluation.»

Important Fraud-Related Factors

Feature analysis highlighted several factors associated with fraudulent claims:

1. Claim Amount
2. Incident Severity
3. Risk Segmentation
4. Premium Amount
5. Incident Hour
6. Police Report Availability
7. Injury Information

These factors can help prioritize claims for additional investigation.

Business Recommendations

1. Automatically Flag High Claim Amounts

Claims with unusually high claim amounts can be automatically flagged for additional verification.

2. Increase Verification for High-Risk Segments

High-risk customer segments can receive additional verification before claim approval.

3. Investigate Claims Without Police Reports

Claims without available police reports can be prioritized for further investigation.

4. Monitor Repeat Vendors and Agents

Vendor and agent behavior can be monitored to identify recurring suspicious patterns.

5. Deploy Machine Learning Before Claim Approval

A fraud-screening model can be incorporated into the claim-processing workflow to identify potentially suspicious claims before approval.

Technology Stack

- Python
- Pandas
- NumPy
- Scikit-learn
- Matplotlib
- Seaborn
- Jupyter Notebook

Project Workflow

Data Integration
       ↓
Data Cleaning & Preprocessing
       ↓
Exploratory Data Analysis
       ↓
Fraud Target Creation
       ↓
Class Imbalance Analysis
       ↓
Feature Preparation
       ↓
Train-Test Split
       ↓
Machine Learning Models
       ↓
Model Evaluation
       ↓
Feature Importance
       ↓
Business Recommendations

Conclusion

This project developed a Machine Learning-based approach for insurance claim fraud detection using 10,000 insurance claim records integrated with employee and vendor information.

Through exploratory analysis and Machine Learning classification, the project identified important fraud-related patterns and compared four classification algorithms. Logistic Regression and Random Forest achieved the highest reported accuracy of 94.95%.

The project demonstrates how Machine Learning and data analytics can support insurance companies in fraud screening, risk prioritization, claim investigation, and more efficient claim-processing workflows.

Project File

The complete analysis, code, visualizations, model training, evaluation, and findings are available in the Jupyter Notebook:

"Insurance_Claim_Fraud_Detection_using_Machine_Learning.ipynb"