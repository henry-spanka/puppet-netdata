require 'spec_helper'
describe 'netdata' do
  context 'with default values for all parameters' do
    it { should contain_class('netdata') }
  end
end
