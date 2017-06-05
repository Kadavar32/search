require 'rails_helper'

RSpec.describe Searchable::SearchService, type: :service do
  let(:q) { 'lisp' }

  subject { Searchable::SearchService.invoke(q) }

  shared_examples 'correct result' do
    it 'has full_match key' do
      expect(subject.keys.include?(:full_match)).to eq true
    end

    it 'has other_results key' do
      expect(subject.keys.include?(:other_results)).to eq true
    end
  end

  describe 'without errors' do
    let(:full_match) { subject[:full_match].inject([]) { |ar, e| ar.push(e['name']) } }

    shared_examples 'key in result' do |result_type, key|
      it "has key in result_type #{result_type}" do
        result = subject[result_type].inject([]) { |ar, e| ar.push(e['name']) }
        expect(result).to include(key)
      end
    end

    context 'when q is lisp' do
      let(:q) { 'Lisp' }
      it_behaves_like 'correct result'
      it_behaves_like 'key in result', :full_match, 'Lisp'
    end

    context 'when q order is Common Lisp' do
      let(:q) { 'Common Lisp' }
      it_behaves_like 'correct result'
      it_behaves_like 'key in result', :full_match, 'Common Lisp'
    end

    context 'when q order is Lisp Common' do
      let(:q) { 'Lisp Common' }
      it_behaves_like 'correct result'
      it_behaves_like 'key in result', :full_match, 'Common Lisp'
    end
  end
end