<a href="http://sound-system.herokuapp.com" target="_blank">SoundSystem</a>
---

This web app represents a suite of tools/functionalities that I wish SoundCloud had.

####Playlist Shuffling

I've become intimately familiar with the order of some of my playlists (Vocal Beauty in particular) and really want to listen to the songs in them in a randomized, shuffled order.

Shuffle Flow:

- Pick playlist that you want to play in shuffle
- Rails --> get array of song ids from playlist data and use Fisher-Yates shuffle alg to randomize it
- Use that randomized list of song ids to create or alter new or existing shuffle playlist
- Stream the shuffle playlist

####To Do:

The SoundCloud querying is rather slow. Have to either find a way to speed up the querying or change how the shuffle mechanism is implemented.

Also have to add a lot of other features after my summer plans are settled. So many things I want to play around with!

- How well do you know your SoundCloud favorites/likes? (Quiz)
- SoundCloud Queue Player
- Playlist Manager (Easy GUI for moving tracks)
- SoundCloud Stats Analyzer (Need to find way to access personal stats)
