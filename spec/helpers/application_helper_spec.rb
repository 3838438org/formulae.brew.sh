# This code is free software; you can redistribute it and/or modify it under
# the terms of the new BSD License.
#
# Copyright (c) 2014, Sebastian Staudt

require 'rails_helper'

describe ApplicationHelper do

  describe '#formulae_link' do
    it 'provides links to formulae in the main repository' do
      repo = Repository.create name: Repository::MAIN
      formula = repo.formulae.create name: 'git'

      expect(helper.formula_link(formula)).to eq('<a class="formula" href="/formula/git">git</a>')
    end

    it 'provides links to formulae in a tap repository' do
      repo = Repository.create name: 'Homebrew/homebrew-science'
      formula = repo.formulae.create name: 'gromacs'

      expect(helper.formula_link(formula)).to eq('<a class="formula" href="/repos/Homebrew/homebrew-science/formula/gromacs">gromacs</a>')
    end
  end

  describe '#timestamp' do
    it 'provides a timestamp tag' do
      time = Time.at 1397573100
      expect(helper.timestamp(time)).to eq('<time class="timeago" datetime="2014-04-15T14:45:00Z">April 15, 2014 16:45</time>')
    end
  end

  describe '#title' do
    it 'provides a default title' do
      expect(helper.title).to eq('braumeister.org')
    end

    it 'provides customized titles' do
      assign :title, 'Custom Title'
      expect(helper.title).to eq('Custom Title – braumeister.org')
    end
  end

end
