1. Introduction (30-45 seconds)
- Greet the audience
- "Hello, my name is Trang Nguyen."
- "I'm applying for the Senior Software Engineer position at ELSA."
- "This video demonstrates my solution for the technical assignment."

2. Assignment Overview (1-2 minutes)

Describe the technical assignment from ELSA
- implementing user participation in quiz sessions
- Highlight key requirements:
  - Users joining a quiz using a unique quiz ID
  - Support for multiple users joining simultaneously
  - Real-time participation
- Assumptions:
  - Users are already existing in the system
  - Quizzes are already created

3. Solution Overview (2-3 minutes)
- Explain your approach to solving the problem
- Discuss key design decisions
- Highlight important implementation elements
- libraries:
  - Ruby on Rails 7.1.4
  - Action Cable for real-time communication
  - Hotwire Turbo for frontend framework
- Database:
  - SQLite for development
  - PostgreSQL for production
- Redis:
  - Pub/Sub messaging

4. Demo (2-3 minutes)
- Show your development environment
- Run the code on your local machine
Walk through the output, explaining each step
If applicable, demonstrate any tests you've written

5. Conclusion (1-2 minutes)
- Summarize the main points of your solution:
  - Channels vs. Consumers
  - The Unique ID of quiz?

Share key learnings from the project
- Channels vs. Consumers

Mention potential improvements or future enhancements
- in Production, use PostgreSQL instead of SQLite
- use Docker to containerize the application
- Nginx for reverse proxy or a CDN for static files or hardware load balancing

6. Closing (15-30 seconds)
Thank the audience for their time
Invite questions or feedback (if applicable)
Remember to keep your explanations concise and focused, as you have a limited time frame of 5-10 minutes. Practice your presentation to ensure you can cover all the points within the given time limit. Good luck with your video submission!
