# NewsLetters - Automated AI News Aggregation System

## Project Overview
NewsLetters is an automated news aggregation system that transforms daily newsletter emails into a structured, categorized news feed. The system combines Gmail automation, AI-powered content analysis, and a mobile app interface for seamless news consumption.


https://github.com/user-attachments/assets/8f928eb4-325f-4fd5-8daa-c31b6a8c0d1f


## System Architecture

### Backend Components
1. **Gmail Trigger System**
   - Automatically detects and processes incoming newsletter emails
   - Extracts relevant content for processing
   - Developed with Make.com
    
<img width="800" alt="Screenshot 2025-01-08 at 11 12 03 AM" src="https://github.com/user-attachments/assets/4038afc0-9568-44be-94d3-d6f630284fff" />

2. **AI Processing Layer**
   - Utilizes Google's Gemini AI model for content analysis
   - Categorizes news items
   - Extracts key information and context

3. **Flask Backend** [Check it out](https://github.com/gokulpulikkal/NewsLetters-Summarizer-backend)
   - Python-based server handling data processing
   - Manages data write operation to Firebase
   - Processes and structures the data

4. **Firebase Integration**
   - Stores processed news items
   - Manages real-time data synchronization
   - Handles data structure:
     ```
     news/
       └── YYYY-MM-DD/
           └── categories/
           └── [news items]
     ```

### iOS Application
- Swift-based native iOS app
- SwiftUI for modern UI implementation
- Real-time synchronization with Firebase
- Categorized news viewing interface

## Features
- Automated daily news updates
- AI-powered news categorization
- Real-time content delivery
- Categorized news browsing
- Clean, intuitive mobile interface

## Technical Stack
- **Backend**: Python, Flask
- **AI Processing**: Google Gemini AI
- **Database**: Firebase Firestore
- **Mobile App**: Swift, SwiftUI

## Data Flow
1. Newsletters arrive in Gmail
2. scenario defined in make.com retrieves the new news letters from gamil
3. Content is processed through Gemini AI
4. Structured data is stored in Firebase
5. iOS app fetches and displays content

## Future Enhancements
- Additional news sources integration
- Advanced categorization features
- User preferences and customization
- Cross-platform support
