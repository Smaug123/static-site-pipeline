---
lastmod: "2023-12-31T12:49:00.0000000+00:00"
author: patrick
categories:
- uncategorized
date: "2023-12-31T12:49:00.0000000+00:00"
title: iOS interface
summary: "A bunch of ways the iOS user interface is bad, and some undiscoverable features"
---

As I think is generally agreed, the iOS user interface is really very bad.
I use iOS because it has fewer fundamental bugs than Android does, but I *much* prefer Android if only it worked.
Here are some of my gripes, and some features it's completely impossible to discover but which are necessary to know.
The list is incomplete: it's just what came to the top of my head over about half an hour.

* Keyboard layout, dead space: As far as I can tell, there is genuinely dead space on the outside of the A and L keys on the QWERTY layout. There is simply no need to demand this much accuracy from the typist.
* Keyboard layout, symbols: every keyboard is nerfed compared to the corresponding Android keyboard. The idiom appears to be to hide symbols behind the "symbols" key, rather than being able to hold any key to reveal more symbols. Microsoft SwiftKey on Android was brilliant: you could access symbols either by clicking the "symbols" key, or by knowing its "hold a key and swipe" shortcut. On iOS, the best you can do is swipe from the "symbols" key, which means your thumb is traversing a lot of the screen a lot more frequently.
* Keyboard layout, general paucity: I literally had to Google how to type one of the characters in one of my passwords.
* Keyboard layout, numbers: it appears to be standard to omit a number row from the keyboard. SwiftKey at least lets you turn this on, but I believe the OS secure keyboard (for password entry) does not have a number row; certainly I have several times been in an interface where I wanted to type numbers but had to go through a menu to do so.
* Filling in forms. The "Done" button is always at the top of the screen, which is at the opposite end of the screen from where you are entering data into the form.
* Filling in forms. The "Done" button appears as flat blue text, with nothing to suggest that it is a button. (This is part of a more general problem that it's generally very unclear what you can interact with.)
* The Home screen is almost completely non-customisable. On Android, you can move icons around however you like, and in particular you can put empty space between icons.
* Calendar. The Calendar app is *weirdly* hard to use. It's miles worse than stock Android's. Why is there no week view that shows you, like, the events happening this week? The best they have is a complete chronological listing of all events in your calendar, which loses any spatial intuition of when events are throughout their days.
* Login. The "OK" button is on the other side of the screen from the numpad: you can comfortably type the numbers with one or both thumbs, but then must stretch or reposition entirely to reach the OK button. (This is a common theme in iOS.)
* Settings search. iOS is *much* worse at finding things in its own Settings app than Android is.
* Search discoverability: a common iOS design idiom appears to be to hide search in a secret "scroll up to view the search box" mode. This is, of course, ridiculous.
* General device search. It's frequently the case that appending to the search term will cause matching results to *vanish* from the list.
* Waking the phone. Latency between "tilt to wake" and the phone actually waking is such that I very frequently press the power button to turn on the phone, then a visible delay occurs, then the phone wakes because I had tilted it, and then the phone sleeps again because I pressed the power button seconds ago.
* The Tips app lets you "practise key gestures" (perfect! every OS should have this!), but… only once at a time? For example, the "Select and edit text" practice (which is absolutely necessary, because of how bad text selection is on iOS) lets you "Try it", but if you pause for too long while you're doing it, it decides you've finished and displays a checkmark, and freezes the interface. If you want to do it again, you have to click "Practise again". Why?!
* The "silence" toggle on the side of the phone has turned into an Action Button on the latest iPhones. Sure, give me customisable buttons, but before that I would strongly prefer a physical toggle like I had on my OnePlus 8 Pro. You can't feel what state your phone is in if that functionality is a button.
* The phone status screen you get by swiping down-left from the top-right is *much* worse than Android's. A bunch of key functionality is hidden behind "press and hold in this area". In a very unusual move for Apple, they have removed almost all the text from this screen, which is the opposite problem from everywhere else in iOS (namely "everything is unstyled text and you can't know it's a button"): everything is clearly a button, but you can't know what it does.
* I have to Google "how to turn off an iPhone". [So does Patrick McKenzie](https://twitter.com/patio11/status/1740623388446769661).

## Necessary features you can't find out about

* You can scroll to arbitrary places in a document. Reveal the scroll bar by scrolling a little, then hold the scroll bar until it blips at you; then you can drag it up and down. (You will need to practise this, because it's extremely finnicky. For example, it appears that once you've quick-scrolled this way once, you cannot do so again until you've slow-scrolled once more.) Why this isn't the default mode I cannot fathom.
* The Calendar is just bad, as I noted above. You can at least see the chronological list of all events in the calendar by double-clicking the "Today" text in the bottom left corner of the screen. This is impossible to discover except by accident.
* You can turn off the phone (without invoking Siri): hold the power button and any volume button simultaneously for a while until it blips at you and gives you an interface you can use. Mnemonic: you can't turn off the phone unless you SHOUT AT IT by turning up the volume while you do it.

## Necessary features you can find out about but which aren't the default

* By default the phone shows notification content on the locked home screen. This is a *really* odd default and is trivially seriously vulnerable to attack. Go Settings -> Notifications, and set "Show Previews" to "When Unlocked".
* You can set a black home-screen background to reduce the home-screen clutter. Go Settings -> Wallpaper, hit "Customise", and then select a "Colour".