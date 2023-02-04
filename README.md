# Dodger

Dodger is a framework to ease development of 2d top-down games

# Set Up
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

# How To

The project already provides an example game.

# Credits

music from [Aim To Head Mix](https://www.youtube.com/@aimtoheadmix1915)