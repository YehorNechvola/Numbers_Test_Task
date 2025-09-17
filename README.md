# Numbers Facts iOS App

## Overview
This is a test iOS application developed as a candidate assignment for the iOS Developer position.  
The app provides interesting facts about numbers using Swift (SwiftUI). Users can enter a number to get a fact or generate a random number to see a fact about it. The app has **two screens**.

---

## Features

### Main Screen
- Input field for entering a number.
- Button: **Get Fact** – fetches a fact about the entered number.
- Button: **Get Random Fact** – fetches a fact about a random number.
- History section: displays the list of previously searched numbers with a **preview of the fact** (single-line).  
  - Tapping a history item navigates to the detail screen.

### Detail Screen
- Displays the selected number and the **full text of the fact**.
- Ability to navigate back to the main screen.

---

## API

- To fetch a fact about a specific number:  
  `http://numbersapi.com/{number}`  
  Example: [http://numbersapi.com/10](http://numbersapi.com/10)

- To fetch a fact about a random number:  
  `http://numbersapi.com/random/math`  

---

## Technical Requirements

- Language: **Swift**  
- IDE: **Xcode**  
- Network requests must be performed **asynchronously** (Async/Await or GCD).  
- Optional: **CoreData** for storing search history.  
- Architecture: **MVVM** with folder structure corresponding to MVVM principles.  
- UI design: flexible; design is not a grading criterion.

---

## Notes

- Error handling is implemented with a **top banner** that appears on network errors and hides after 3 seconds or on tap.  
- The app is structured with **SwiftUI NavigationStack** for navigation between screens.  
- History items are tappable and show detailed facts on the second screen.  
