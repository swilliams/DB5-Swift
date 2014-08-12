# DB5-Swift

**DB5** originally by [Q Branch](http://qbranch.co/)

**DB5-Swift** ported by [Scott Williams](http://swilliams.me)

## App Configuration via Plist

By storing colors, fonts, numbers, booleans, and so on in a plist, we were able to iterate quickly on our app [Vesper](http://vesperapp.co/).

Our designers could easily make changes without having to dive into the code or ask engineering to spend time nudging pixels and changing values.

There is nothing magical about the code or the system: it’s some simple code plus a few conventions.

### How it works

See the demo app. You include two classes — `ThemeLoader` and `Theme` — and DB5.plist. The plist is where you set values.

At startup you load the file via `ThemeLoader`, then access values via methods in `Theme`.

#### Theme methods

Most of the methods are straightforward. `Theme.boolForKey()` returns a Bool, and so on.

Some of the methods require multiple values in the plist file. For instance, `Theme.fontForKey()` expects the font name as `keyName` and the size as `keyNameSize`. See Theme.swift for more information about these multiple-key values.

#### Inheritance

Though we haven’t used this capability in Vesper, we made it so that you can have multiple themes. Every theme inherits from the Default theme.

If you ask for a value from a theme other than Default, and that value is not specified in that theme, it falls back to Default to get that value.

### Demo app

The demo app is straightforward and small. `AppDelegate` loads the themes. `ViewController` shows some example use.

Also, see the Examples folder for the DB5.plist from Vesper.

#### Swift Customizations

 * Prefixes were removed.
 * Some unit tests were added in the `Tests` folder.
 * A different constructor was created in `ThemeLoader` to allow you to use a different plist file.

### Contact

DB5 — [Brent Simmons](https://github.com/brentsimmons)<br />
[@brentsimmons](https://twitter.com/brentsimmons)

DB5-Swift — [Scott Williams](https://github.com/swilliams)<br />
[@swilliams](https://twitter.com/swilliams)

### License

DB5-Swift is available under the MIT license. See the LICENSE file for details.
