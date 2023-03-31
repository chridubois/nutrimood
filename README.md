# Nutrimood : a innovative app which tell you what you eat according to your actual mood
<img width="897" alt="Capture d’écran 2023-03-31 à 16 11 40" src="https://user-images.githubusercontent.com/113714569/229144494-e66f7b37-c034-4557-b7a8-2ce455e4bc34.png">
<img width="682" alt="Capture d’écran 2023-03-31 à 16 12 08" src="https://user-images.githubusercontent.com/113714569/229144563-5894bb2b-bece-4936-a14e-dc5c86f47569.png">

## Features 
- Seeds built with Web scraping of 5000 recipes from different websites
- JS animation on all pages to make the app more funny
- Sign In / Log In with Devise
- Own Matching algorythm to find the best 3 recipes for a combinaison of mood/energy/symptoms
- Google Maps API to display organic shop near to you
- Pundit implementation to manage authorizations
- Blazer implementation to be able to analyze user choices and make statistics
- Sidekiq and Redis cron job to run scraping each night and update of the database each night
- Tom Select controller
- Use of Bullet to optimize active records queries
- Rails admin implementation
- Implementation of Google tag Manager and Google ANalytics to track users behaviour
