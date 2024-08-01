# Cadastro

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9.1-orange.svg" />
    <img src="https://img.shields.io/badge/Xcode-15.2.X-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://www.linkedin.com/in/rodrigo-silva-6a53ba300/" target="_blank">
        <img src="https://img.shields.io/badge/LinkedIn-@RodrigoSilva-blue.svg?style=flat" alt="LinkedIn: @RodrigoSilva" />
    </a>
</p>

An iOS application written in Swift, for user registrations, this application registers the following data, "Email, Password, Password Confirmation and Name". The application follows a simple verification of email address, password and password confirmation. When logging in, the application loads a list of Pokemon fed by the PokeAPI, where the user can favorite their Pokemons and all this data is saved on the device itself using userDefaults.

## Contents

- [Requirements](#requirements)
- [Functionalities](#functionalities)
- [Setup](#setup)
- [Credits](#credits)

## Features

- Dark Mode
- Modern TableView
- MVVM
- View Code (UIKit)
- Custom elements

## Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Swift 5.0 or later

## Functionalities
- [x] User Registration
- [x] Login Screen
- [x] Registration Screen
- [x] List of Pokemon, favorites when clicking on the cell
- [x] Saving data using userDefaults

## Setup

First of all download and install Xcode, Cocoapods and then clone the repository:

```sh
$ git@github.com:diggosilva/Cadastro.git
```

After cloning, do the following:

```sh
$ cd <diretorio-base>/Cadastro/
$ open Cadastro.xcworkspace/
```

## Built With

* [SDWebImage](https://github.com/SDWebImage/SDWebImage) - Asynchronous image downloader with cache support as a UIImageView category

## Credits

- Diggo Silva
- Helio Mesquita
- Junior Silva
