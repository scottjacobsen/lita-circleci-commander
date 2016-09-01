![circle](https://circleci.com/gh/scottjacobsen/lita-circleci-commander.svg?style=shield)

# lita-circleci-commander

This Lita plugin allows you to retry a faild build directly from chat.

## Installation

Add lita-circleci-commander to your Lita instance's Gemfile:

``` ruby
gem "lita-circleci-commander"
```

## Configuration

You must set the following environement variables that correspond to
the values expected by the CircleCi API:

* `CIRCLECI_VCS_TYPE`
* `CIRCLECI_USERNAME`
* `CIRCLECI_PROJECT`
* `CIRCLECI_TOKEN`

## Usage

`> lita: rebuild #123`
