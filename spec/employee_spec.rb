require 'spec_helper'

describe Employee do
  it {should have_many :projects}
  it { should belong_to :division}
end
