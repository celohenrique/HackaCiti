CITI Hackathon Project README

Project Description

This repository contains the Swift/SwiftUI application developed during the CITI Hackathon. The application utilizes mock data for a variety of banking operations. The mock data simulates API responses and is served via Mockoon.

Prerequisites

Xcode: Download and install the latest version of Xcode from the Apple Developer site or through the App Store.
Mockoon: Download and install Mockoon from here. Mockoon is used to run mock servers for API development.
Setting up the Mock Server

Open Mockoon.
Click on 'Create a new environment'.
Set the port to 3001. This will make our mock server available at localhost:3001.
Click on 'Add a route'.
Set the method to GET, the endpoint to /mockData and leave the status as 200.
In the 'Body' tab, paste the contents of the xxxx.json file.
Click on 'Start the server'.
Now, every time you send a GET request to http://localhost:3001/mockData, you will receive the mock data response.

Running the Project in Xcode

Clone the repository to your local machine: git clone <repository-url>.
Navigate into the project directory.
Open the .xcodeproj or .xcworkspace file (in case of usage of CocoaPods) to open the project in Xcode.
Make sure your Mockoon server is running.
Click on the 'Play' button in the top left corner of Xcode to run the application.
Connecting to the Mock Server

The application is already configured to fetch data from http://localhost:3001/mockData. If your mock server is running and set up correctly, the application will retrieve and display the mock data upon launch.

Remember, any changes in the structure of the mock data may require modifications in the app's data model and the decoding process. Ensure that the mock data matches the structure of the OperacaoRemessa struct, or adjust the struct and decoder accordingly.
