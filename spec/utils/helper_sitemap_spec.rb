require_relative '../spec_helper'

describe(HelperSitemap) do
  let(:sitemap_path) { File.expand_path('./spec/fixtures/sitemaps') }
  describe 'get_urls' do
    it 'returns all urls from a file' do
      # Given
      input = File.join(sitemap_path, 'sitemap.xml')

      # When
      actual = HelperSitemap.get_urls(input)

      # Then
      expect(actual.length).to eq 2
      expect(actual[0]).to eq 'http://www.foo.com/bar/1'
      expect(actual[1]).to eq 'http://www.foo.com/bar/2'
    end

    it 'it removes duplicates urls from the list' do
      # Given
      input = File.join(sitemap_path, 'sitemap_duplicate.xml')

      # When
      actual = HelperSitemap.get_urls(input)

      # Then
      expect(actual.length).to eq 2
      expect(actual[0]).to eq 'http://www.foo.com/bar/1'
      expect(actual[1]).to eq 'http://www.foo.com/bar/2'
    end

    it 'it sorts urls' do
      # Given
      input = File.join(sitemap_path, 'sitemap_unsorted.xml')

      # When
      actual = HelperSitemap.get_urls(input)

      # Then
      expect(actual.length).to eq 2
      expect(actual[0]).to eq 'http://www.foo.com/bar/1'
      expect(actual[1]).to eq 'http://www.foo.com/bar/2'
    end
  end
end
