require 'spec/spec_helper'

########################
### LISTING PROFILES ###
########################

describe 'listing profiles' do
  it 'lists the default profile' do
    `mdf list`.strip.must_equal "Profiles\n========\ndefault"
  end
end
