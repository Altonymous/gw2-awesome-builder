gw2-awesome-builder
===================

Guild Wars 2 - Want to be awesome?  Use our builder.

- Setup Basic System
  - `createuser -d -l -P postgres`
    - leave password blank

  - `rake db:setup`

- Setup & Run Specs
  - run `rake db:test:prepare`

  - run `rake spec`

- Setup & Run Specs (in parallel)
  - run `rake parallel:create`

  - run `rake parallel:prepare`

  - run `rake parallel:spec`

[![Build Status](https://secure.travis-ci.org/Altonymous/gw2-awesome-builder.png?branch=master)](https://travis-ci.org/Altonymous/gw2-awesome-builder)