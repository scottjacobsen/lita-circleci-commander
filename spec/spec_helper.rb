require "lita-circleci-commander"
require "lita/rspec"
require "pry"
require "fakeredis"

# A compatibility mode is provided for older plugins upgrading from Lita 3. Since this plugin
# was generated with Lita 4, the compatibility mode should be left disabled.
Lita.version_3_compatibility_mode = false
