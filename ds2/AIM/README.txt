# DS2 Award Items Management
Powershell Script to remove free award items like Soldier Suit from store to ease menuing. 
3 options: NG, HC, NG+.

Simple to use:
Place anywhere, right click, open with Powershell. 
Use before launching the game.

There are several free item awards obtained by completing game, on hardcore, and so on. These are not allowed for use in runs, except NG+. In order to prevent their use by accident and ease navigation in the shop menu, they can be removed.

# How to do it manually

Paste in explorer or notepad path (or in Win + R)
%LOCALAPPDATA%\EA Games\Dead Space 2\settings.txt
Edit following lines:
Controls.AcL.X = 0x00010000 // to unlock Hardcore
Controls.AcL.Y = 0x00004000 // Hand Cannon
else leave all zeros. For HC you also need:
Game.PDiff = 1
Game.Played = 1

[Reference](https://www.pcgamingwiki.com/wiki/Dead_Space_2#No_suit_unlocks_for_higher_difficulty_completion)
