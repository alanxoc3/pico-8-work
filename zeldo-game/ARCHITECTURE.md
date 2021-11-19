# Zeldo Architecture

## File Structure
The bulk of the code for this game is in the `src/game` directory. Files in
this directory start with a number that determines which files should come
first when running the `./compile` command.

The `src/tools` directory contains lua code that is used by tools that aid with
developing the game. The most notable of these tools is the mapbuilder. The
mapbuilder tool is used to edit the map and save it as a multiline lua string
in the `src/game` directory.

When you run shell scripts located at the repo's root directory, a `build`
folder will be created. This folder will usually contain at least a `code.lua`.
This lua file is referenced in `zeldo.p8` and is needed to actually run the
cartridge.

## Lua Minifier
The title lua minifier is a bit misleading, because in this project it is much
more than just a minifier.

When running the `./compile` command, a perl script is executed, which performs
multiple transformations on the code including:
- Remove unneeded spacing.
- Remove all comments.
- Enables or disables production or debug related code.
- Replaces certain constants with values.
- Minifies lua functions and variables.
- Minifies multiline and single quote strings too.

The last bullet needs a little clarification. Zeldo treats strings in 3
different ways. Strings with a double quote (`"`) are treated as raw strings.
That means the string is probably visible in the game and should not be
minified. Strings with a single quote or double brackets (`'` or `[[]]`) are
treated as code strings. The minifier will replace all words in those strings
with a minified word. Double brackets strings (`[[]]`) are a special type of
string though. These strings must follow a certain format that is used by a
function called `ztable`. The ztable format is basically a compact format to
store lua tables. All ztables are in double brackets, because this makes it
possible to put all ztable strings together and store it outside of the code
area (ex, in the sprite/map data).

The [ztable format](#ztable-format) section talks more about the ztable format.

## Ztable Format
Colons and semi colons convert a string to a one layer table. Example:
```
[[a:hello;b:hola;]]
```

Will become this lua table:
```
{
   a="hello",
   b="hola"
}
```

Commas and equal signs add an extra layer to the table. Example:
```
[[a:my=friend,is,cool;123]]
```

Will become this lua table:
```
{
   a={my="friend", "is", "cool"},
   "123"
}
```

A forward slash adds yet an extra layer, but this layer can only hold arrays.
```
[[a:my/sub/array,is=cool;]]
```

Will become this lua table:
```
{
   a={
      {"my","sub","array"},
      is="cool"
   }
}
```

There are some special values in ztable. Here's what they mean:
```
ztable -> lua
-------------
yes    -> true
no     -> false
null   -> nil
nf     -> function() end
```

Those are the main symbols that strings could have conflicts with. Other
notable exceptions are these:
- The carrot operator separates screens in the text box system.
- Before the double bracket strings are parsed, pipes are used to separate
  ztables for the create_actor function.
- After the double bracket strings are parsed, pipes are used to separate
  strings that are stored in cartridge data.
- Single quote strings and double bracket strings both mean that there is code
  stored inside the string and the string content can be minified.
- Double quote strings mean that the content is text and therefore should not
  be minified.
- If a double quote string is contained within a double bracket string, the
  text in the double quotes will be preserved, but the double quotes themselves
  will be removed.
- Double bracket strings are all parsed out and put into one massive string
  separated by pipes. This further implies that double bracket strings are
  always used in conjunction with ztable in Zeldo.
- Exclamation marks "!" at the beginning of a value field in ztable means that
  it is a macro that calls a functions from the `_g` table. Parameters are
  separated by forward slashes.
- At signs "@" at the beginning of a field in ztable, followed by a number
  indicates that the value will be replaced with one of the ztable parameters.
  So "@1" will be replaced by the first parameter and so on.
- A `%` sign will take a value from the `_g` table.
- A `$` sign allows you to set a function that has the object as the first
  parameter.
- A `~` sign will copy a value that was previous specified from the root of the
  current table. This means that key/value order can be important with ztables.

The main limitations with the string system is that text boxes in the game
cannot have any of these characters contained within it: `|":;,=/^%~`.
