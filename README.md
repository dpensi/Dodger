# Dodger
top-down 2d character

an example of a top-down 2d character that moves with keyboard keys and looks at mouse direction.

# set up
There's no easy way in godot to set up dependencies, so git submodules have been used

clone the project with `--recurse-submodule` to download [Backpack](https://github.com/dpensi/Backpack) (the inventory system)

`git clone --recurse-submodules git@github.com:dpensi/Dodger.git`

than make sure that you're on the main branch and delete the project file of Backpack to allow godot to import it

```
cd Dodger/Backpack
git checkout main
rm project.godot
```

finally import the project

# Credits

music hogfi_maybe.ogg made by Vojvodinosaurus under [this licence](https://creativecommons.org/licenses/by-nc-sa/3.0/legalcode.txt)