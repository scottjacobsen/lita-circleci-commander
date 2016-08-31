# lita-circleci-commander

TODO: Add a description of the plugin.

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
