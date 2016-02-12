require_relative '../spec_helper'

describe(HelperPath) do
  describe 'sanitize' do
    it 'replaces any special char with an underscore' do
      # Given
      input = 'foo?bar.html'

      # When
      actual = HelperPath.sanitize(input)

      # Then
      expect(actual).to eq 'foo_bar.html'
    end
    it 'keep slash directory structure intact' do
      # Given
      input = 'foo/bar?baz.html'

      # When
      actual = HelperPath.sanitize(input)

      # Then
      expect(actual).to eq 'foo/bar_baz.html'
    end
  end

  describe 'download' do
    it 'return the complete path in the download folder' do
      # Given
      input = 'foo.html'

      # When
      actual = HelperPath.download(input)

      # Then
      expect(actual).to match(%r{_cache/foo.html$})
    end

    it 'keeps the directory structure' do
      # Given
      input = 'foo/bar.html'

      # When
      actual = HelperPath.download(input)

      # Then
      expect(actual).to match(%r{_cache/foo/bar.html$})
    end

    it 'adds an html prefix if none is found' do
      # Given
      input = 'bar'

      # When
      actual = HelperPath.download(input)

      # Then
      expect(actual).to match(%r{_cache/bar.html$})
    end
  end
end
