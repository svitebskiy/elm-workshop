## Auth.elm Container Directory
Create a new Auth.elm file here using the insturctions from the main project README file.

## Why Auth.elm is in its Own Dir?
There is the `Main.elm` file in the project root directory as well as a `Main.elm` in each `partN` directory.
`elm make Main.elm` complains if it finds two files of the same name in the `source-directories` listed in the project's `elm.json` file, and most workshop part projects also need to include the source dirctory with `Auth.elm`.