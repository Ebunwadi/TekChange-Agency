# Exchange Agency Platform

## Project Description
Tekchange Agency is a small business facilitating the exchange of goods or services online. This e-commerce platform enables users to list items they want to exchange, browse listings from other users, and arrange exchanges.

## Technologies Used
- Java Enterprise Edition (JEE) Platform (Java Servlets, JSP, Web Services)
- Relational Database (MySQL)
- Weka Machine Learning Toolkit

## Functionalities

- **Display Listings**: Users can list items available for exchange, categorized by type or category.
- **Add Listings**: users can add new listings with details such as description, condition, and photos.
- **Browse Listings**: users can browse listings from other users and express interest in exchanges.
- **Finalize Exchanges**: users can finalize exchanges and confirm agreements.
- **Update/Delete Listings**: users can update or delete their listings.
- **Validation**: validation for input data is implemented.

### Item Category Prediction
The platform includes a feature to predict the category of new item listings based on their attributes using a trained model.

## Setup Instructions

### Prerequisites
- JDK 8 or later
- Apache Tomcat 9 or later
- MySQL 5.7 or later
- Weka 3.8 or later
- An IDE such as VsCode or IntelliJ IDEA

### Database Setup

**Create Database and Tables**:
   ```sql
   CREATE DATABASE tekchangedb;

   USE tekchangedb;

   CREATE TABLE Users (
       user_id INT AUTO_INCREMENT PRIMARY KEY,
       username VARCHAR(50) NOT NULL,
       password VARCHAR(50) NOT NULL,
       email VARCHAR(100) NOT NULL
   );

   CREATE TABLE Itemss (
       itemId INT AUTO_INCREMENT PRIMARY KEY,
       category VARCHAR(50),
       description TEXT,
       item_condition VARCHAR(50),
       photo_url VARCHAR(255),
       userId INT,
       FOREIGN KEY (user_id) REFERENCES Users(user_id)
   );

   CREATE TABLE Exchanges (
    exchangeId INT PRIMARY KEY AUTO_INCREMENT,
    itemId INT NOT NULL,
    interestedUserId INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (itemId) REFERENCES Items(itemId),
    FOREIGN KEY (interestedUserId) REFERENCES Users(userId)
);
```

## Weka Model Setup

### Prepare Dataset:
- Convert the training dataset into ARFF format.
- You can save it as items.arff.

### Load ARFF in Weka: 
- Open Weka Explorer.
-  Click on "Open file" and select items.arff.
  
###  Train Naive Bayes Classifier:
-  Go to the "Classify" tab.
-  Choose "NaiveBayes" under the "Classifier" section.
-  Click "Start" to train the model.
  
### Export Model:
- After training, right-click on the result and select "Save model".
- You can save the model as items.model.

### Project Setup
Clone the Repository:
```
git clone https://github.com/Ebunwadi/TekChange-Agency.git
```
### Import Project into IDE:

- Open your IDE.
- Import the project as a Maven project.
- Configure Database Connection:

### Update database.properties with your MySQL credentials.
```
db.url=jdbc:mysql://localhost:3306/techangedb
db.username=root
db.password=yourpassword
```
### Deploy to Tomcat:
- Start the server.
- Add the project to your Apache Tomcat server.
- Deploy the war file

  
### Running the Application
- Open your web browser and go to http://localhost:8080/tekchange. or whatever host/baseurl your server runs in.
