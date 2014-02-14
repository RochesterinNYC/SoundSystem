SoundSystem
---

This web app represents a suite of tools/functionalities that I wish SoundCloud had.

####Playlist Shuffling

I've become intimately familiar with the order of some of my playlists (Vocal Beauty in particular) and really want to listen to the songs in them in a randomized, shuffled order.

User Flow:

- Pick playlist that you want to play in shuffle
- Rails --> get array of song ids from playlist data and use Fisher-Yates shuffle alg to randomize it
- Pass that randomized list of song ids to the javascript front-end
- Javascript streamer that streams through song ids and acts as stack (remove from end)
- Page refreshes and new randomized list plays when old list has been played through (stack empty)
